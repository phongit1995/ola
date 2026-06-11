'use strict'
const { ok, section, req, data, summary, registerUser, uniqueUsername, randomPassword, WS_BASE } = require('../helpers')
const { io } = require('socket.io-client')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

function connectWS(token) {
  return new Promise((resolve, reject) => {
    const socket = io(WS_BASE, { auth: { token }, timeout: 8000 })
    const timer = setTimeout(() => { socket.disconnect(); reject(new Error('WS connect timeout')) }, 8000)
    socket.on('connect', () => { clearTimeout(timer); resolve(socket) })
    socket.on('connect_error', (err) => { clearTimeout(timer); reject(err) })
  })
}

// Join confirmation is driven by the ROOM_MEMBER_JOINED broadcast (reliable),
// not the emit ack (which is flaky over the websocket transport in this lib).
function joinRoom(socket, roomId, selfId) {
  return new Promise((resolve) => {
    const onMsg = (m) => {
      if (m?.type === 'ROOM_MEMBER_JOINED' && m?.data?.roomId === roomId && m?.data?.userId === selfId) {
        cleanup(); resolve(true)
      }
    }
    // The room:join emit can be dropped during the polling→websocket upgrade,
    // so re-emit periodically until the join is confirmed by the broadcast.
    const retry = setInterval(() => socket.emit('room:join', { roomId }), 1200)
    const timer = setTimeout(() => { cleanup(); resolve(false) }, 10000)
    const cleanup = () => { clearTimeout(timer); clearInterval(retry); socket.off('message', onMsg) }
    socket.on('message', onMsg)
    socket.emit('room:join', { roomId })
  })
}

// Verifies the room realtime path after the Kafka migration:
//   HTTP POST /messages → API publishes CHAT.ROOM.MESSAGE.CREATED
//   → Chat service consumes → EmitToRoom → fanout to all socket members.
// Requires BOTH api (:8080) and chat (:8081) running (shared WS Redis adapter + Kafka).
async function main() {
  section('20 · ROOMS REALTIME (kafka fanout: API→Kafka→Chat→WS)')

  const adminR = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  const adminToken = data(adminR)?.token
  ok('admin login', !!adminToken)

  const u1 = await registerUser(uniqueUsername('rt1'), undefined, randomPassword())
  const u2 = await registerUser(uniqueUsername('rt2'), undefined, randomPassword())

  const r = await req('POST', '/admin/rooms', { name: 'RT ' + uniqueUsername('rm') }, adminToken)
  const roomId = data(r)?.id
  ok('room created', !!roomId)

  let wsA, wsB
  try {
    [wsA, wsB] = await Promise.all([connectWS(u1.token), connectWS(u2.token)])
    ok('both connected via WS', true)

    const CONTENT = 'realtime ' + uniqueUsername('x')
    const received = { a: false, b: false }
    wsA.on('message', (m) => { if (m?.type === 'NEW_ROOM_MESSAGE' && m?.data?.message?.content === CONTENT) received.a = true })
    wsB.on('message', (m) => { if (m?.type === 'NEW_ROOM_MESSAGE' && m?.data?.message?.content === CONTENT) received.b = true })

    const [jA, jB] = await Promise.all([joinRoom(wsA, roomId, u1.id), joinRoom(wsB, roomId, u2.id)])
    ok('both joined room via socket', jA && jB)

    const sr = await req('POST', `/rooms/${roomId}/messages`, { content: CONTENT }, u1.token)
    ok('send message accepted (2xx)', sr.status >= 200 && sr.status < 300)

    // Wait for the kafka round-trip (API publish → chat consume → fanout).
    const deadline = Date.now() + 15000
    while (Date.now() < deadline && !(received.a && received.b)) {
      await new Promise(r => setTimeout(r, 200))
    }

    ok('sender (u1) received NEW_ROOM_MESSAGE via kafka fanout', received.a)
    ok('other member (u2) received NEW_ROOM_MESSAGE via kafka fanout', received.b)
  } catch (e) {
    ok('websocket realtime', false)
    console.error('  WS error:', e.message)
  } finally {
    if (wsA) wsA.disconnect()
    if (wsB) wsB.disconnect()
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

'use strict'
const { ok, section, req, data, summary, registerUser, uniqueUsername, randomPassword, WS_BASE } = require('../helpers')
const { io } = require('socket.io-client')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

function connectWS(token) {
  return new Promise((resolve, reject) => {
    const socket = io(WS_BASE, { auth: { token }, transports: ['websocket'], timeout: 8000 })
    const timer = setTimeout(() => { socket.disconnect(); reject(new Error('WS connect timeout')) }, 8000)
    socket.on('connect', () => { clearTimeout(timer); resolve(socket) })
    socket.on('connect_error', (err) => { clearTimeout(timer); reject(err) })
  })
}

async function main() {
  section('20 · ROOMS REALTIME (websocket fanout)')

  const adminR = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  const adminToken = data(adminR)?.token
  ok('admin login', !!adminToken)

  const u1 = await registerUser(uniqueUsername('rt1'), undefined, randomPassword())
  const u2 = await registerUser(uniqueUsername('rt2'), undefined, randomPassword())

  let r = await req('POST', '/admin/rooms', { name: 'RT ' + uniqueUsername('rm') }, adminToken)
  const roomId = data(r)?.id
  ok('room created', !!roomId)

  await req('POST', `/rooms/${roomId}/join`, undefined, u1.token)
  await req('POST', `/rooms/${roomId}/join`, undefined, u2.token)
  ok('both joined', true)

  let wsA, wsB
  try {
    [wsA, wsB] = await Promise.all([connectWS(u1.token), connectWS(u2.token)])
    ok('both connected via WS', true)

    const CONTENT = 'realtime ' + uniqueUsername('x')
    const result = await new Promise((resolve) => {
      const received = { a: false, b: false }
      const timer = setTimeout(() => resolve(received), 7000)
      const check = () => { if (received.a && received.b) { clearTimeout(timer); resolve(received) } }
      wsA.on('message', (m) => { if (m?.type === 'NEW_ROOM_MESSAGE' && m?.data?.message?.content === CONTENT) { received.a = true; check() } })
      wsB.on('message', (m) => { if (m?.type === 'NEW_ROOM_MESSAGE' && m?.data?.message?.content === CONTENT) { received.b = true; check() } })

      setTimeout(() => { req('POST', `/rooms/${roomId}/messages`, { content: CONTENT }, u1.token) }, 500)
    })

    ok('sender (u1) received NEW_ROOM_MESSAGE', result.a)
    ok('other member (u2) received NEW_ROOM_MESSAGE', result.b)
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

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
    socket.on('connect_error', reject)
  })
}

function emitJoin(socket, payload) {
  return new Promise((resolve) => {
    const timer = setTimeout(() => resolve({ ok: false, error: 'ack timeout' }), 6000)
    socket.emit('ROOM:JOIN', payload, (resp) => { clearTimeout(timer); resolve(resp || { ok: false }) })
  })
}

async function main() {
  section('21 · ROOMS JOIN (ticket + capacity)')

  const adminR = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  const adminToken = data(adminR)?.token
  ok('admin login', !!adminToken)

  const u1 = await registerUser(uniqueUsername('j1'), undefined, randomPassword())
  const u2 = await registerUser(uniqueUsername('j2'), undefined, randomPassword())
  const u3 = await registerUser(uniqueUsername('j3'), undefined, randomPassword())

  // room with capacity 1
  const r = await req('POST', '/admin/rooms', { name: 'JC ' + uniqueUsername('rm'), maxMembers: 1 }, adminToken)
  const roomId = data(r)?.id
  ok('room (maxMembers=1) created', !!roomId)

  const sockets = []
  try {
    // u1 requests a ticket
    const t1 = await req('POST', `/rooms/${roomId}/join`, undefined, u1.token)
    ok('u1 request join → 2xx', t1.status >= 200 && t1.status < 300)
    ok('u1 got ticket', !!data(t1)?.ticket)

    // u1 joins via socket with ticket
    const wsA = await connectWS(u1.token); sockets.push(wsA)
    const ackA = await emitJoin(wsA, { roomId, ticket: data(t1)?.ticket })
    ok('u1 socket join ok', ackA?.ok === true)
    ok('u1 memberCount = 1', ackA?.data?.memberCount === 1)

    // u2 requests a ticket → room is full (u1 online, max=1)
    const t2 = await req('POST', `/rooms/${roomId}/join`, undefined, u2.token)
    ok('u2 request join → 403 room full', t2.status === 403)

    // invalid ticket is rejected at socket
    const wsC = await connectWS(u3.token); sockets.push(wsC)
    const ackBad = await emitJoin(wsC, { roomId, ticket: 'bogus-ticket' })
    ok('invalid ticket rejected', ackBad?.ok === false && /ticket/i.test(ackBad?.error || ''))

    // ticket bound to room: u1 ticket for another room is invalid
    const r2 = await req('POST', '/admin/rooms', { name: 'JC2 ' + uniqueUsername('rm') }, adminToken)
    const room2 = data(r2)?.id
    const t1b = await req('POST', `/rooms/${room2}/join`, undefined, u3.token)
    const ackWrongRoom = await emitJoin(wsC, { roomId, ticket: data(t1b)?.ticket }) // ticket is for room2, used on roomId
    ok('ticket bound to its room (cross-room rejected)', ackWrongRoom?.ok === false)
  } catch (e) {
    ok('join flow', false)
    console.error('  error:', e.message)
  } finally {
    sockets.forEach(s => s.disconnect())
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

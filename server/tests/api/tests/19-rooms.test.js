'use strict'
const { ok, section, req, data, summary, registerUser, uniqueUsername, randomPassword } = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  return data(r)?.token
}

async function main() {
  section('19 · ROOMS (admin create, user join & chat)')

  const adminToken = await adminLogin()
  ok('admin login', !!adminToken)

  const u1 = await registerUser(uniqueUsername('r1'), undefined, randomPassword())
  const u2 = await registerUser(uniqueUsername('r2'), undefined, randomPassword())
  const u3 = await registerUser(uniqueUsername('r3'), undefined, randomPassword())
  ok('seed 3 users', !!u1.id && !!u2.id && !!u3.id)

  // only admin creates: a user token must be rejected on admin route → 403
  let r = await req('POST', '/admin/rooms', { name: 'Hack' }, u1.token)
  ok('user cannot create room → 403', r.status === 403)

  // admin creates a room
  const roomName = 'Phòng ' + uniqueUsername('rm')
  r = await req('POST', '/admin/rooms', { name: roomName, description: 'demo', maxMembers: 3 }, adminToken)
  ok('admin create room → 201', r.status === 201)
  const room = data(r)
  ok('room has id', !!room?.id)
  ok('room enabled by default', room?.enabled === true)
  const roomId = room.id

  // admin list shows the room
  r = await req('GET', '/admin/rooms', undefined, adminToken)
  ok('admin list rooms → 200', r.status === 200)
  ok('admin list contains room', !!data(r)?.items?.find(x => x.id === roomId))

  // user browses public rooms and sees it
  r = await req('GET', `/rooms?q=${encodeURIComponent(roomName)}`, undefined, u1.token)
  ok('browse rooms → 200', r.status === 200)
  ok('browse finds room', !!data(r)?.items?.find(x => x.id === roomId))

  // detail before join: isMember false
  r = await req('GET', `/rooms/${roomId}`, undefined, u1.token)
  ok('room detail → 200', r.status === 200)
  ok('not member yet', data(r)?.isMember === false)

  // non-member cannot send → 403
  r = await req('POST', `/rooms/${roomId}/messages`, { content: 'hi' }, u1.token)
  ok('non-member send → 403', r.status === 403)

  // non-member cannot read history → 403
  r = await req('GET', `/rooms/${roomId}/messages`, undefined, u1.token)
  ok('non-member history → 403', r.status === 403)

  // u1 and u2 join
  r = await req('POST', `/rooms/${roomId}/join`, undefined, u1.token)
  ok('u1 join → 200', r.status === 200)
  ok('join sets isMember true', data(r)?.isMember === true)
  ok('member_count = 1', data(r)?.memberCount === 1)

  r = await req('POST', `/rooms/${roomId}/join`, undefined, u2.token)
  ok('u2 join → 200', r.status === 200)
  ok('member_count = 2', data(r)?.memberCount === 2)

  // idempotent join
  r = await req('POST', `/rooms/${roomId}/join`, undefined, u1.token)
  ok('re-join idempotent → 200', r.status === 200 && data(r)?.memberCount === 2)

  // u1 sends a message
  r = await req('POST', `/rooms/${roomId}/messages`, { content: 'Xin chào phòng!' }, u1.token)
  ok('u1 send message → 201', r.status === 201)
  const msg = data(r)
  ok('message has id', !!msg?.id)
  ok('message content correct', msg?.content === 'Xin chào phòng!')

  // u2 sends a message
  r = await req('POST', `/rooms/${roomId}/messages`, { content: 'Chào u1' }, u2.token)
  ok('u2 send message → 201', r.status === 201)

  // member reads history (DESC newest first)
  r = await req('GET', `/rooms/${roomId}/messages?limit=10`, undefined, u2.token)
  ok('history → 200', r.status === 200)
  const items = data(r)?.items || []
  ok('history has 2 messages', items.length === 2)
  ok('history newest first', items[0]?.content === 'Chào u1')

  // members list
  r = await req('GET', `/rooms/${roomId}/members`, undefined, u1.token)
  ok('members → 200', r.status === 200)
  ok('members total = 2', data(r)?.total === 2)

  // max members = 3: u3 joins ok, a 4th would be full
  r = await req('POST', `/rooms/${roomId}/join`, undefined, u3.token)
  ok('u3 join → 200 (count 3)', r.status === 200 && data(r)?.memberCount === 3)
  const u4 = await registerUser(uniqueUsername('r4'), undefined, randomPassword())
  r = await req('POST', `/rooms/${roomId}/join`, undefined, u4.token)
  ok('u4 join → 403 room full', r.status === 403)

  // u1 leaves, then cannot send
  r = await req('POST', `/rooms/${roomId}/leave`, undefined, u1.token)
  ok('u1 leave → 200', r.status === 200)
  r = await req('POST', `/rooms/${roomId}/messages`, { content: 'still here?' }, u1.token)
  ok('left user send → 403', r.status === 403)

  // admin disables room → browse hides it, join blocked
  r = await req('PATCH', `/admin/rooms/${roomId}`, { enabled: false }, adminToken)
  ok('admin disable → 200', r.status === 200 && data(r)?.enabled === false)
  r = await req('GET', `/rooms?q=${encodeURIComponent(roomName)}`, undefined, u1.token)
  ok('disabled room hidden from browse', !data(r)?.items?.find(x => x.id === roomId))
  r = await req('POST', `/rooms/${roomId}/join`, undefined, u1.token)
  ok('join disabled room → 403', r.status === 403)

  // admin deletes room → detail 404
  r = await req('DELETE', `/admin/rooms/${roomId}`, undefined, adminToken)
  ok('admin delete → 200', r.status === 200)
  r = await req('GET', `/rooms/${roomId}`, undefined, u2.token)
  ok('deleted room detail → 404', r.status === 404)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

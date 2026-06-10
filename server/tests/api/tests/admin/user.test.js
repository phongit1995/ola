'use strict'
const { ok, section, req, data, summary, registerUser, uniqueUsername, randomPassword } = require('../../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  return data(r)?.token
}

async function main() {
  section('ADMIN · USER MANAGEMENT')

  const adminToken = await adminLogin()
  ok('admin login', !!adminToken)

  // seed a normal user to manage
  const pw = randomPassword()
  const user = await registerUser(uniqueUsername('mu'), undefined, pw)
  ok('seed user created', !!user.id)

  // list: no token → 401
  let r = await req('GET', '/admin/users')
  ok('list no token → 401', r.status === 401)

  // list: normal user token → 403
  r = await req('GET', '/admin/users', undefined, user.token)
  ok('list with user token → 403', r.status === 403)

  // list: admin → 200 with pagination shape
  r = await req('GET', '/admin/users?limit=5', undefined, adminToken)
  ok('list with admin → 200', r.status === 200)
  const list = data(r)
  ok('list returns items array', Array.isArray(list?.items))
  ok('list returns total', typeof list?.total === 'number')
  ok('list respects limit', list?.items.length <= 5)

  // search finds the seeded user
  r = await req('GET', `/admin/users?q=${user.username}`, undefined, adminToken)
  const found = data(r)?.items?.find(u => u.id === user.id)
  ok('search finds seeded user', !!found)

  // detail → 200
  r = await req('GET', `/admin/users/${user.id}`, undefined, adminToken)
  ok('detail → 200', r.status === 200)
  ok('detail isActive=true', data(r)?.isActive === true)

  // detail invalid id → 400
  r = await req('GET', '/admin/users/not-a-uuid', undefined, adminToken)
  ok('detail invalid id → 400', r.status === 400)

  // detail unknown id → 404
  r = await req('GET', '/admin/users/00000000-0000-0000-0000-000000000000', undefined, adminToken)
  ok('detail unknown id → 404', r.status === 404)

  // ban user
  r = await req('PATCH', `/admin/users/${user.id}/status`, { isActive: false }, adminToken)
  ok('ban → 200', r.status === 200)
  ok('ban sets isActive=false', data(r)?.isActive === false)

  // banned user cannot login → 403
  r = await req('POST', '/auth/login', { username: user.username, password: pw })
  ok('banned user login → 403', r.status === 403)

  // unban
  r = await req('PATCH', `/admin/users/${user.id}/status`, { isActive: true }, adminToken)
  ok('unban → 200', r.status === 200)
  ok('unban sets isActive=true', data(r)?.isActive === true)

  // unbanned user can login again → 200/201
  r = await req('POST', '/auth/login', { username: user.username, password: pw })
  ok('unbanned user login → 200/201', r.status === 200 || r.status === 201)

  // status without body field → 400
  r = await req('PATCH', `/admin/users/${user.id}/status`, {}, adminToken)
  ok('status missing isActive → 400', r.status === 400)

  // delete (soft)
  r = await req('DELETE', `/admin/users/${user.id}`, undefined, adminToken)
  ok('delete → 200', r.status === 200)

  // deleted user → detail 404
  r = await req('GET', `/admin/users/${user.id}`, undefined, adminToken)
  ok('deleted user detail → 404', r.status === 404)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

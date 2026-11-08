'use strict'
const {
  ok, section, req, data, summary,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function main() {
  section('36 · ADMIN DELETE USER (thu hồi phiên và xoá cache)')

  const adminToken = await adminLogin()
  const password = randomPassword()
  const target = await registerUser(uniqueUsername('delT'), undefined, password)
  const viewer = await registerUser(uniqueUsername('delV'), undefined, randomPassword())

  let r = await req('GET', '/user/me', undefined, target.token)
  ok('token works before delete', r.status === 200)

  r = await req('GET', `/user/${target.id}`, undefined, viewer.token)
  ok('profile is readable before delete', r.status === 200)

  r = await req('DELETE', `/admin/users/${target.id}`, undefined, adminToken)
  ok('admin deletes user', r.status === 200 || r.status === 204)

  r = await req('GET', '/user/me', undefined, target.token)
  ok('old token is rejected right after delete', r.status === 401)

  r = await req('POST', '/auth/login', { username: target.username, password })
  ok('deleted user cannot log in', r.status === 401)

  r = await req('GET', `/user/${target.id}`, undefined, viewer.token)
  ok('profile is gone right after delete', r.status === 404)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})

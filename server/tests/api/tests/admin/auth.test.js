'use strict'
const { ok, section, req, data, summary, registerUser, uniqueUsername, randomPassword } = require('../../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function main() {
  section('ADMIN · AUTH')

  // wrong password → 401
  let r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: randomPassword() })
  ok('admin wrong password → 401', r.status === 401)

  // unknown admin → 401
  r = await req('POST', '/admin/auth/login', { username: uniqueUsername('nadmin'), password: randomPassword() })
  ok('unknown admin → 401', r.status === 401)

  // login success
  r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  ok('admin login → 200', r.status === 200)
  const ld = data(r)
  ok('admin login returns token', !!ld?.token)
  ok('admin login returns refreshToken', !!ld?.refreshToken)
  ok('admin login returns admin object', !!ld?.admin)
  ok('admin has role', !!ld?.admin?.role)
  ok('admin role is SUPER_ADMIN', ld?.admin?.role === 'SUPER_ADMIN')
  const adminToken = ld?.token

  // login case-insensitive
  r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME.toUpperCase(), password: ADMIN_PASSWORD })
  ok('admin login (case-insensitive) → 200', r.status === 200)

  // me with admin token → 200
  r = await req('GET', '/admin/auth/me', undefined, adminToken)
  ok('admin /me → 200', r.status === 200)
  const me = data(r)
  ok('admin /me returns role', me?.role === 'SUPER_ADMIN')
  ok('admin /me returns id', !!me?.id)

  // me without token → 401
  r = await req('GET', '/admin/auth/me')
  ok('admin /me no token → 401', r.status === 401)

  // a normal user token must NOT access admin route → 403
  const user = await registerUser(uniqueUsername('uu'), undefined, randomPassword())
  r = await req('GET', '/admin/auth/me', undefined, user.token)
  ok('user token on admin route → 403', r.status === 403)

  // admin token must NOT pass normal user auth → 401
  r = await req('GET', '/user/me', undefined, adminToken)
  ok('admin token on user route → 401', r.status === 401)

  // fresh login to get a valid (non-rotated) refresh token
  r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  const freshRefresh = data(r)?.refreshToken

  // refresh rotates token
  r = await req('POST', '/admin/auth/refresh', { refreshToken: freshRefresh })
  ok('admin refresh → 200', r.status === 200)
  const rd = data(r)
  ok('refresh returns new token', !!rd?.token)
  ok('refresh returns new refreshToken', !!rd?.refreshToken)

  // old refresh token revoked after rotation → 401
  r = await req('POST', '/admin/auth/refresh', { refreshToken: freshRefresh })
  ok('reused old refresh token → 401', r.status === 401)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

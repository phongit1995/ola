'use strict'
const { ok, section, req, data, summary, uniqueUsername, randomPassword } = require('../helpers')

async function main() {
  section('02 · AUTH')

  const u1 = uniqueUsername('a1')
  const pw1 = randomPassword()
  const u2 = uniqueUsername('a2')
  const pw2 = randomPassword()
  const wrongPw = randomPassword()
  console.log(`  → u1=${u1} u2=${u2}`)

  // register
  let r = await req('POST', '/auth/register', { username: u1, password: pw1 })
  ok('register → 200/201', r.status === 200 || r.status === 201)
  const d1 = data(r)
  ok('register returns user', !!d1?.user || !!d1?.message)

  r = await req('POST', '/auth/register', { username: u2, password: pw2 })
  ok('register user2 → 200/201', r.status === 200 || r.status === 201)

  // duplicate username → 409
  r = await req('POST', '/auth/register', { username: u1, password: randomPassword() })
  ok('duplicate username → 409', r.status === 409)

  // duplicate username case-insensitive → 409
  r = await req('POST', '/auth/register', { username: u1.toUpperCase(), password: randomPassword() })
  ok('duplicate username (case-insensitive) → 409', r.status === 409)

  // short password → 400
  r = await req('POST', '/auth/register', { username: uniqueUsername('wk'), password: 'abc' })
  ok('short password → 400', r.status === 400)

  // short username → 400
  r = await req('POST', '/auth/register', { username: 'ab', password: randomPassword() })
  ok('short username → 400', r.status === 400)

  // login success
  r = await req('POST', '/auth/login', { username: u1, password: pw1 })
  ok('login → 200/201', r.status === 200 || r.status === 201)
  const ld = data(r)
  ok('login returns token', !!ld?.token)
  ok('login returns refreshToken', !!ld?.refreshToken)
  ok('login returns user', !!ld?.user)
  const token1 = ld?.token

  // login case-insensitive username
  r = await req('POST', '/auth/login', { username: u1.toUpperCase(), password: pw1 })
  ok('login (case-insensitive username) → 200/201', r.status === 200 || r.status === 201)

  // wrong password → 401
  r = await req('POST', '/auth/login', { username: u1, password: wrongPw })
  ok('wrong password → 401', r.status === 401)

  // non-existent user → 401
  r = await req('POST', '/auth/login', { username: uniqueUsername('nx'), password: randomPassword() })
  ok('unknown user → 401', r.status === 401)

  // no auth header → 401
  r = await req('GET', '/user/me')
  ok('no token → 401', r.status === 401)

  // bad token → 401
  r = await req('GET', '/user/me', undefined, 'not.a.jwt')
  ok('malformed token → 401', r.status === 401)

  // valid token works
  r = await req('GET', '/user/me', undefined, token1)
  ok('valid token → 200', r.status === 200)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

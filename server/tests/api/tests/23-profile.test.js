'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx } = require('../helpers')

const FAKE_UUID = '00000000-0000-0000-0000-000000000000'
const NOT_UUID  = 'not-a-uuid'

const me        = (u)            => req('GET',    '/user/me',            undefined, u.token)
const updateMe  = (u, body)      => req('PUT',    '/user/me',            body,      u.token)
const publicOf  = (u, id)        => req('GET',    `/user/${id}`,         undefined, u.token)
const kiss      = (u, id)        => req('POST',   `/user/${id}/kiss`,    undefined, u.token)

async function main() {
  section('23 · PROFILE FIELDS + KISS')

  const [alice, bob] = await createUserSet(2, 'pf')

  console.log('\n── new fields defaults on GET /user/me ──')
  {
    const d = data(await me(alice))
    ok('me.marriage default = single', d?.marriage === 'single')
    ok('me.verified default = false', d?.verified === false)
    ok('me.kisses default = 0', d?.kisses === 0)
    ok('me.coverPhoto empty by default', !d?.coverPhoto)
  }

  console.log('\n── PUT /user/me marriage + coverPhoto ──')
  {
    let r = await updateMe(alice, { marriage: 'married', coverPhoto: 'https://cdn.test/cover.jpg' })
    ok('PUT married + coverPhoto → 200', r.status === 200)
    const d = data(r)
    ok('marriage = married', d?.marriage === 'married')
    ok('coverPhoto persisted', d?.coverPhoto === 'https://cdn.test/cover.jpg')

    const after = data(await me(alice))
    ok('marriage persisted', after?.marriage === 'married')

    r = await updateMe(alice, { marriage: 'single' })
    ok('PUT back to single → 200', r.status === 200 && data(r)?.marriage === 'single')
  }

  console.log('\n── validation ──')
  {
    let r = await updateMe(alice, { marriage: 'divorced' })
    ok('invalid marriage → 400', r.status === 400)

    r = await updateMe(alice, { coverPhoto: 'not-a-url' })
    ok('invalid coverPhoto (not url) → 400', r.status === 400)
  }

  console.log('\n── verified is read-only (cannot self-set) ──')
  {
    const r = await updateMe(alice, { verified: true })
    ok('PUT verified:true accepted (ignored) → 200', r.status === 200)
    const after = data(await me(alice))
    ok('verified still false (not settable)', after?.verified === false)
  }

  console.log('\n── public profile returns new fields ──')
  {
    const d = data(await publicOf(bob, alice.id))
    ok('public has marriage', d?.marriage === 'single')
    ok('public has verified', d?.verified === false)
    ok('public has kisses (number)', typeof d?.kisses === 'number')
    ok('public has gender', typeof d?.gender === 'string')
    ok('public has followerCount (number)', typeof d?.followerCount === 'number')
  }

  console.log('\n── KISS ──')
  {
    let r = await kiss(alice, bob.id)
    ok('alice kiss bob → 2xx', is2xx(r.status))
    ok('kisses = 1', data(r)?.kisses === 1)

    r = await kiss(alice, bob.id)
    ok('kiss again → kisses = 2 (increments)', data(r)?.kisses === 2)

    const pub = data(await publicOf(alice, bob.id))
    ok('public profile reflects kisses = 2', pub?.kisses === 2)

    r = await kiss(alice, alice.id)
    ok('self-kiss → 400', r.status === 400)
    ok('self-kiss error message', /yourself/i.test(JSON.stringify(r.body)))

    r = await kiss(alice, FAKE_UUID)
    ok('kiss missing user → 404', r.status === 404)

    r = await kiss(alice, NOT_UUID)
    ok('kiss invalid uuid → 400', r.status === 400)

    r = await req('POST', `/user/${bob.id}/kiss`)
    ok('kiss no auth → 401', r.status === 401)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

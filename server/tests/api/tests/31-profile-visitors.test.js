'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx } = require('../helpers')

const FAKE_UUID = '00000000-0000-0000-0000-000000000000'

const profile = (viewer, id) => req('GET', `/user/${id}`, undefined, viewer.token)
const recordView = (viewer, id) => req('POST', `/user/${id}/view`, undefined, viewer.token)
const visitors = (owner) => req('GET', '/user/me/visitors', undefined, owner.token)
const block = (owner, viewerId) =>
  req('POST', '/relationships/block', { userId: viewerId }, owner.token)

async function main() {
  section('31 · PROFILE VISITORS')

  const [alice, bob, carol] = await createUserSet(3, 'pv')

  console.log('\n── reading public profile does not record a visit ──')
  {
    ok('bob reads alice by id → 200', (await profile(bob, alice.id)).status === 200)
    ok('bob reads alice by username → 200', (await profile(bob, alice.username)).status === 200)
    const list = data(await visitors(alice))?.users ?? []
    ok('alice visitors does not contain bob', !list.some((item) => item.id === bob.id))
  }

  console.log('\n── explicit profile view is recorded once ──')
  {
    let r = await recordView(bob, alice.id)
    ok('bob records alice profile view → 2xx', is2xx(r.status))
    ok('recorded = true', data(r)?.recorded === true)

    r = await recordView(bob, alice.id)
    ok('repeated view remains successful', is2xx(r.status))

    const list = data(await visitors(alice))?.users ?? []
    ok('alice visitors contains bob', list.some((item) => item.id === bob.id))
    ok('bob appears only once', list.filter((item) => item.id === bob.id).length === 1)
  }

  console.log('\n── self and blocked views are ignored or rejected ──')
  {
    let r = await recordView(alice, alice.id)
    ok('self view → 2xx', is2xx(r.status))
    ok('self view recorded = false', data(r)?.recorded === false)

    await block(alice, carol.id)
    r = await recordView(carol, alice.id)
    ok('viewer blocked by profile owner → 404', r.status === 404)

    const list = data(await visitors(alice))?.users ?? []
    ok('alice visitors does not contain herself', !list.some((item) => item.id === alice.id))
    ok('alice visitors does not contain blocked carol', !list.some((item) => item.id === carol.id))
  }

  console.log('\n── validation and authentication ──')
  {
    ok('missing target → 404', (await recordView(bob, FAKE_UUID)).status === 404)
    ok('invalid UUID → 400', (await recordView(bob, 'not-a-uuid')).status === 400)
    ok('no auth → 401', (await req('POST', `/user/${alice.id}/view`)).status === 401)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})

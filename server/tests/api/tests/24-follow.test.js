'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx } = require('../helpers')

const FAKE_UUID = '00000000-0000-0000-0000-000000000000'
const NOT_UUID  = 'not-a-uuid'

const follow    = (u, id)        => req('POST',   `/user/${id}/follow`,            undefined, u.token)
const unfollow  = (u, id)        => req('DELETE', `/user/${id}/follow`,            undefined, u.token)
const followers = (u, id, qs='') => req('GET',    `/user/${id}/followers${qs}`,    undefined, u.token)
const following = (u, id, qs='') => req('GET',    `/user/${id}/following${qs}`,    undefined, u.token)
const me        = (u)            => req('GET',    '/user/me',                      undefined, u.token)
const publicOf  = (u, id)        => req('GET',    `/user/${id}`,                   undefined, u.token)
const block     = (u, id)        => req('POST',   '/relationships/block',          { userId: id }, u.token)

const userList = (r) => data(r)?.users ?? []

async function main() {
  section('24 · FOLLOW')

  const [alice, bob, charlie] = await createUserSet(3, 'fo')

  console.log('\n── follow + counters ──')
  {
    let r = await follow(alice, bob.id)
    ok('alice follow bob → 2xx', is2xx(r.status))
    ok('following = true', data(r)?.following === true)
    ok('bob followerCount = 1', data(r)?.followerCount === 1)

    r = await follow(alice, bob.id)
    ok('follow again idempotent → followerCount still 1', data(r)?.followerCount === 1)

    ok('bob.followerCount persisted = 1', data(await me(bob))?.followerCount === 1)
    ok('alice.followingCount = 1', data(await me(alice))?.followingCount === 1)
  }

  console.log('\n── relationship enrichment on public profile ──')
  {
    const aSeesB = data(await publicOf(alice, bob.id))?.relationship
    ok('alice→bob isFollowing = true', aSeesB?.isFollowing === true)
    ok('alice→bob followsMe = false', aSeesB?.followsMe === false)

    const bSeesA = data(await publicOf(bob, alice.id))?.relationship
    ok('bob→alice isFollowing = false', bSeesA?.isFollowing === false)
    ok('bob→alice followsMe = true', bSeesA?.followsMe === true)
  }

  console.log('\n── follower / following lists ──')
  {
    const flw = await followers(bob, bob.id)
    ok('bob followers → 2xx', is2xx(flw.status))
    ok('bob followers total = 1', data(flw)?.total === 1)
    ok('bob followers contains alice', userList(flw).some(u => u.id === alice.id))

    const fwg = await following(alice, alice.id)
    ok('alice following total = 1', data(fwg)?.total === 1)
    ok('alice following contains bob', userList(fwg).some(u => u.id === bob.id))
  }

  console.log('\n── unfollow ──')
  {
    let r = await unfollow(alice, bob.id)
    ok('unfollow → 2xx', is2xx(r.status))
    ok('following = false', data(r)?.following === false)
    ok('bob followerCount = 0', data(r)?.followerCount === 0)

    r = await unfollow(alice, bob.id)
    ok('unfollow again idempotent → followerCount 0', data(r)?.followerCount === 0)

    ok('alice.followingCount back to 0', data(await me(alice))?.followingCount === 0)
    ok('bob followers list now empty', data(await followers(bob, bob.id))?.total === 0)
  }

  console.log('\n── block prevents follow (both directions) ──')
  {
    await block(alice, charlie.id)

    let r = await follow(alice, charlie.id)
    ok('blocker → follow blocked target → 400', r.status === 400)

    r = await follow(charlie, alice.id)
    ok('blocked user → follow blocker → 400', r.status === 400)
  }

  console.log('\n── error cases ──')
  {
    let r = await follow(alice, alice.id)
    ok('self-follow → 400', r.status === 400)

    r = await follow(alice, FAKE_UUID)
    ok('follow missing user → 404', r.status === 404)

    r = await follow(alice, NOT_UUID)
    ok('follow invalid uuid → 400', r.status === 400)

    r = await req('POST', `/user/${bob.id}/follow`)
    ok('follow no auth → 401', r.status === 401)
  }

  console.log('\n── pagination ──')
  {
    const target = bob
    const fans = await createUserSet(3, 'fan')
    for (const f of fans) await follow(f, target.id)

    const page1 = await followers(target, target.id, '?limit=2&offset=0')
    ok('followers limit=2 → 2 items', userList(page1).length === 2)
    ok('followers total = 3', data(page1)?.total === 3)

    const page2 = await followers(target, target.id, '?limit=2&offset=2')
    ok('followers offset=2 → 1 item', userList(page2).length === 1)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

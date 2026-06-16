'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx } = require('../helpers')

const sendReq  = (from, toId)     => req('POST',   '/relationships/request',   { userId: toId }, from.token)
const respond  = (u, id, action)  => req('PUT',    `/relationships/${id}/respond`, { action }, u.token)
const block    = (from, toId)     => req('POST',   '/relationships/block',     { userId: toId }, from.token)
const follow   = (u, id)          => req('POST',   `/user/${id}/follow`,       undefined, u.token)
const me       = (u)              => req('GET',    '/user/me',                 undefined, u.token)
const publicOf = (u, id)          => req('GET',    `/user/${id}`,              undefined, u.token)

const counts = async (u) => {
  const d = data(await me(u))
  return { following: d?.followingCount, follower: d?.followerCount }
}

async function main() {
  section('26 · FOLLOW ⇄ RELATIONSHIP interplay')

  console.log('\n── accept friend ⇒ mutual auto-follow ──')
  {
    const [a, b] = await createUserSet(2, 'ia')
    const sr = await sendReq(a, b.id)
    const relId = data(sr)?.id
    const ar = await respond(b, relId, 'accept')
    ok('accept → 2xx', is2xx(ar.status))

    const ca = await counts(a), cb = await counts(b)
    ok('a following = 1', ca.following === 1)
    ok('a follower  = 1', ca.follower === 1)
    ok('b following = 1', cb.following === 1)
    ok('b follower  = 1', cb.follower === 1)

    const rel = data(await publicOf(a, b.id))?.relationship
    ok('a→b status = friend', rel?.status === 'friend')
    ok('a→b isFollowing = true', rel?.isFollowing === true)
    ok('a→b followsMe = true', rel?.followsMe === true)
  }

  console.log('\n── mutual-pending auto-accept ⇒ mutual auto-follow ──')
  {
    const [c, d] = await createUserSet(2, 'ic')
    await sendReq(c, d.id)
    const back = await sendReq(d, c.id)
    ok('mutual send auto-accept → 2xx', is2xx(back.status))
    ok('status = accepted', data(back)?.status === 'accepted')

    const cc = await counts(c), cd = await counts(d)
    ok('both follow each other (c)', cc.following === 1 && cc.follower === 1)
    ok('both follow each other (d)', cd.following === 1 && cd.follower === 1)
  }

  console.log('\n── accept is idempotent on existing follow ──')
  {
    const [g, h] = await createUserSet(2, 'ig')
    await follow(g, h.id)
    const sr = await sendReq(g, h.id)
    await respond(h, data(sr)?.id, 'accept')

    const cg = await counts(g), ch = await counts(h)
    ok('g following still 1 (no double count)', cg.following === 1)
    ok('h follower  still 1 (no double count)', ch.follower === 1)
    ok('h now follows g back', ch.following === 1)
    ok('g now followed by h', cg.follower === 1)
  }

  console.log('\n── block removes ONLY the blocker’s follow ──')
  {
    const [e, f] = await createUserSet(2, 'ie')
    await follow(e, f.id)
    await follow(f, e.id)

    let ce = await counts(e), cf = await counts(f)
    ok('precondition: mutual follow', ce.following === 1 && cf.following === 1)

    const br = await block(e, f.id)
    ok('block → 2xx', is2xx(br.status))

    ce = await counts(e); cf = await counts(f)
    ok('blocker e no longer follows f (following 0)', ce.following === 0)
    ok('f loses a follower (follower 0)', cf.follower === 0)
    ok('blocked f still follows e (following 1)', cf.following === 1)
    ok('e still followed by f (follower 1)', ce.follower === 1)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx, envInt } = require('../helpers')

const sendReq = (from, toId)       => req('POST',   '/relationships/request',       { userId: toId }, from.token)
const block   = (from, toId)       => req('POST',   '/relationships/block',         { userId: toId }, from.token)
const blocked = (u)                => req('GET',    '/relationships/blocked',       undefined, u.token)
const friends = (u)                => req('GET',    '/relationships/friends',       undefined, u.token)
const sent    = (u)                => req('GET',    '/relationships/sent',          undefined, u.token)
const pending = (u)                => req('GET',    '/relationships/pending',       undefined, u.token)
const publicOf= (u, id)            => req('GET',    `/user/${id}`,                  undefined, u.token)

const friendListOf = (r) => data(r)?.friends ?? []
const relListOf    = (r) => data(r)?.relationships ?? []

async function main() {
  section('25 · RELATIONSHIP INTEGRITY (transaction + advisory lock)')

  const RACE_PAIRS = envInt('RACE_PAIRS', 6, 1, 50)

  console.log(`\n── mutual-pending RACE × ${RACE_PAIRS} (A→B & B→A in parallel) ──`)
  {
    let allFriends = true
    let noDuplicateEdge = true
    let noLeftoverPending = true

    for (let i = 0; i < RACE_PAIRS; i++) {
      const [a, b] = await createUserSet(2, `ri${i}`)

      const [r1, r2] = await Promise.all([sendReq(a, b.id), sendReq(b, a.id)])
      if (!is2xx(r1.status) || !is2xx(r2.status)) allFriends = false

      const rel = data(await publicOf(a, b.id))?.relationship
      if (rel?.status !== 'friend') allFriends = false

      const aFriendsB = friendListOf(await friends(a)).filter(f => f.id === b.id)
      const bFriendsA = friendListOf(await friends(b)).filter(f => f.id === a.id)
      if (aFriendsB.length !== 1 || bFriendsA.length !== 1) noDuplicateEdge = false

      const aSentToB = relListOf(await sent(a)).some(r => r.addresseeId === b.id)
      const aPendingFromB = relListOf(await pending(a)).some(r => r.requesterId === b.id)
      if (aSentToB || aPendingFromB) noLeftoverPending = false
    }

    ok('all races settle as 2xx + status=friend (serialized auto-accept)', allFriends)
    ok('exactly one friend-edge per pair (no duplicate rows)', noDuplicateEdge)
    ok('no leftover pending/sent after auto-accept', noLeftoverPending)
  }

  console.log('\n── block idempotency ──')
  {
    const [a, b] = await createUserSet(2, 'rib')

    let r = await block(a, b.id)
    ok('first block → 2xx', is2xx(r.status))
    ok('status = blocked', data(r)?.status === 'blocked')
    const firstId = data(r)?.id

    r = await block(a, b.id)
    ok('second block → 2xx (idempotent)', is2xx(r.status))
    ok('same relationship id returned', data(r)?.id === firstId)

    const list = relListOf(await blocked(a)).filter(x => x.addresseeId === b.id)
    ok('blocked list has b exactly once', list.length === 1)
  }

  console.log('\n── block then race friend-request (block must win) ──')
  {
    const [a, b] = await createUserSet(2, 'rbr')
    await block(a, b.id)

    const [r1, r2] = await Promise.all([sendReq(a, b.id), sendReq(b, a.id)])
    ok('blocker send → 400', r1.status === 400)
    ok('blocked send → 400', r2.status === 400)

    const aFriends = friendListOf(await friends(a)).filter(f => f.id === b.id)
    ok('no friendship created despite race', aFriends.length === 0)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

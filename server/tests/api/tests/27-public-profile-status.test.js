'use strict'
const { ok, section, req, data, summary, createUserSet, is2xx } = require('../helpers')

const sendReq  = (from, toId)    => req('POST', '/relationships/request',      { userId: toId }, from.token)
const respond  = (u, id, action) => req('PUT',  `/relationships/${id}/respond`, { action },       u.token)
const block    = (from, toId)    => req('POST', '/relationships/block',         { userId: toId }, from.token)
const publicOf = (u, id)         => req('GET',  `/user/${id}`,                  undefined, u.token)
const relOf    = async (u, id)   => data(await publicOf(u, id))?.relationship

async function main() {
  section('27 · PUBLIC PROFILE relationship.status MATRIX')

  const [alice, bob, charlie] = await createUserSet(3, 'ps')

  console.log('\n── self ──')
  {
    const rel = await relOf(alice, alice.id)
    ok('alice views self → status=self', rel?.status === 'self')
  }

  console.log('\n── none ──')
  {
    const rel = await relOf(alice, bob.id)
    ok('no relation → status=none', rel?.status === 'none')
    ok('none → no requestId', !rel?.requestId)
    ok('none → isFollowing=false', rel?.isFollowing === false)
    ok('none → followsMe=false', rel?.followsMe === false)
  }

  console.log('\n── pending_outgoing / pending_incoming ──')
  {
    const relId = data(await sendReq(alice, bob.id))?.id

    const aSee = await relOf(alice, bob.id)
    ok('sender sees pending_outgoing', aSee?.status === 'pending_outgoing')
    ok('outgoing requestId matches', aSee?.requestId === relId)

    const bSee = await relOf(bob, alice.id)
    ok('receiver sees pending_incoming', bSee?.status === 'pending_incoming')
    ok('incoming requestId matches (same row)', bSee?.requestId === relId)

    console.log('\n── friend (after accept) → also auto-follow ──')
    await respond(bob, relId, 'accept')
    const aFriend = await relOf(alice, bob.id)
    ok('status=friend', aFriend?.status === 'friend')
    ok('friend requestId matches', aFriend?.requestId === relId)
    ok('friend isFollowing=true (auto-follow)', aFriend?.isFollowing === true)
    ok('friend followsMe=true (auto-follow)', aFriend?.followsMe === true)
  }

  console.log('\n── blocked_by_me: blocker still sees target (to unblock) ──')
  {
    const blockId = data(await block(alice, charlie.id))?.id

    const aSee = await relOf(alice, charlie.id)
    ok('blocker sees blocked_by_me', aSee?.status === 'blocked_by_me')
    ok('blocked_by_me requestId matches block row', aSee?.requestId === blockId)

    console.log('\n── blocked_by_them: blocked user can no longer view blocker (404) ──')
    const cSee = await publicOf(charlie, alice.id)
    ok('blocked user → profile 404 (as if not exist)', cSee.status === 404)
    const cSeeName = await publicOf(charlie, alice.username)
    ok('blocked user by-username → 404 too', cSeeName.status === 404)
  }

  console.log('\n── fetch by USERNAME (same as by id) ──')
  {
    const byId = data(await publicOf(bob, charlie.id))
    const byName = data(await publicOf(bob, charlie.username))
    ok('GET /user/:username → 2xx with id', !!byName?.id)
    ok('by-username returns same user as by-id', byName?.id === byId?.id)
    ok('by-username username matches', byName?.username === charlie.username)

    const missing = await publicOf(bob, 'no_such_user_xyz_0000')
    ok('unknown username → 404', missing.status === 404)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

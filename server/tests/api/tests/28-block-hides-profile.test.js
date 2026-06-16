'use strict'
const { ok, section, req, data, summary, createUserSet } = require('../helpers')

const block     = (from, toId) => req('POST', '/relationships/block', { userId: toId }, from.token)
const profile   = (u, id)      => req('GET',  `/user/${id}`,             undefined, u.token)
const followers = (u, id)      => req('GET',  `/user/${id}/followers`,   undefined, u.token)
const following = (u, id)      => req('GET',  `/user/${id}/following`,   undefined, u.token)
const postsOf   = (u, id)      => req('GET',  `/me/users/${id}`,         undefined, u.token)

const NIL_UUID = '00000000-0000-0000-0000-000000000000'

async function main() {
  section('28 · BLOCK HIDES PROFILE (chỉ khi họ block mình → 404 như không tồn tại)')

  const [alice, bob] = await createUserSet(2, 'bh')

  console.log('\n── trước khi block: bob xem được mọi thứ của alice ──')
  {
    ok('bob → alice profile 2xx', (await profile(bob, alice.id)).status === 200)
    ok('bob → alice followers 2xx', (await followers(bob, alice.id)).status === 200)
    ok('bob → alice following 2xx', (await following(bob, alice.id)).status === 200)
    ok('bob → alice posts 2xx', (await postsOf(bob, alice.id)).status === 200)
  }

  console.log('\n── alice block bob → bob bị shut out hoàn toàn ──')
  {
    await block(alice, bob.id)

    ok('bob → alice profile by id → 404', (await profile(bob, alice.id)).status === 404)
    ok('bob → alice profile by username → 404', (await profile(bob, alice.username)).status === 404)
    ok('bob → alice followers → 404', (await followers(bob, alice.id)).status === 404)
    ok('bob → alice following → 404', (await following(bob, alice.id)).status === 404)
    ok('bob → alice posts feed → 404', (await postsOf(bob, alice.id)).status === 404)
  }

  console.log('\n── alice (người block) VẪN xem được bob để bỏ chặn ──')
  {
    const r = await profile(alice, bob.id)
    ok('alice → bob profile 2xx', r.status === 200)
    ok('alice → bob status=blocked_by_me', data(r)?.relationship?.status === 'blocked_by_me')
    ok('alice → bob followers 2xx', (await followers(alice, bob.id)).status === 200)
    ok('alice → bob following 2xx', (await following(alice, bob.id)).status === 200)
    ok('alice → bob posts 2xx', (await postsOf(alice, bob.id)).status === 200)
  }

  console.log('\n── user không tồn tại → profile 404 ──')
  {
    ok('unknown uuid → 404', (await profile(alice, NIL_UUID)).status === 404)
    ok('unknown username → 404', (await profile(alice, 'ghost_user_zzz_404')).status === 404)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

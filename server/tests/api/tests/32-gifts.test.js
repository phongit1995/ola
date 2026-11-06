'use strict'
const crypto = require('crypto')
const {
  ok, section, req, data, summary,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'
const RANDOM_UUID = '00000000-0000-4000-8000-000000000000'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function grantKen(adminToken, userId, amount) {
  const r = await req('POST', `/admin/ken/users/${userId}/adjust`, { action: 'grant', amount, description: 'gift test' }, adminToken)
  if (r.status !== 200 && r.status !== 201) throw new Error(`grant ken failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).balanceAfter
}

async function me(token) {
  return data(await req('GET', '/user/me', undefined, token))
}

function sendGift(token, body) {
  return req('POST', '/gifts/send', { source: 'profile', clientRequestId: crypto.randomUUID(), ...body }, token)
}

async function putGiftSetting(adminToken, value) {
  const r = await req('PUT', '/admin/settings/gift', { value }, adminToken)
  if (r.status !== 200) throw new Error(`put gift setting failed: ${r.status} ${JSON.stringify(r.body)}`)
}

const DEFAULT_SETTING = { enabled: true, quantityOptions: [1, 5, 10, 99], quantityMax: 99, noteMaxLength: 100, confirmOverKen: 1000 }

async function main() {
  section('32 · GIFTS (tặng quà)')

  const adminToken = await adminLogin()
  const A = await registerUser(uniqueUsername('giftA'), undefined, randomPassword())
  const B = await registerUser(uniqueUsername('giftB'), undefined, randomPassword())
  const C = await registerUser(uniqueUsername('giftC'), undefined, randomPassword())
  await grantKen(adminToken, A.id, 10000)

  // ── admin catalog ──
  let r = await req('POST', '/admin/gifts', { name: 'Hoa test', nameEn: 'Test rose', imageUrl: 'https://example.com/rose.png', kenPrice: 10, charmPoints: 12, sortOrder: 1 }, adminToken)
  ok('admin create gift → 201', r.status === 201)
  const rose = data(r)
  r = await req('POST', '/admin/gifts', { name: 'Xe test', imageUrl: 'https://example.com/car.png', kenPrice: 3000, charmPoints: 3000, sortOrder: 2 }, adminToken)
  const car = data(r)
  r = await req('POST', '/admin/gifts', { name: 'Ẩn test', imageUrl: 'https://example.com/hidden.png', kenPrice: 5, charmPoints: 5, isActive: false }, adminToken)
  const hidden = data(r)
  ok('admin create inactive gift', hidden && hidden.isActive === false)
  r = await req('POST', '/admin/gifts', { name: 'bad', imageUrl: 'not-a-url', kenPrice: 0 }, adminToken)
  ok('admin create invalid gift → 400', r.status === 400)
  r = await req('GET', '/admin/gifts', undefined, A.token)
  ok('user token cannot list admin gifts', r.status === 401 || r.status === 403)

  // ── catalog ──
  r = await req('GET', '/gifts')
  ok('catalog no token → 401', r.status === 401)
  r = await req('GET', '/gifts', undefined, A.token)
  ok('catalog → 200', r.status === 200)
  const catalog = data(r)
  ok('catalog contains active gift', catalog.items.some((g) => g.id === rose.id && g.charmPoints === 12 && g.nameEn === 'Test rose'))
  ok('catalog hides inactive gift', !catalog.items.some((g) => g.id === hidden.id))
  ok('catalog returns settings', Array.isArray(catalog.settings.quantityOptions) && catalog.settings.quantityMax >= 1)

  // ── validation ──
  r = await sendGift(A.token, { giftId: rose.id, receiverId: A.id, quantity: 1 })
  ok('gift to self → 400 GIFT_SELF', r.status === 400 && r.body.code === 'GIFT_SELF')
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 0 })
  ok('quantity 0 → 400', r.status === 400)
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1000 })
  ok('quantity above max → 400 GIFT_INVALID_QUANTITY', r.status === 400 && r.body.code === 'GIFT_INVALID_QUANTITY')
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1, note: 'x'.repeat(101) })
  ok('note too long → 400 GIFT_NOTE_TOO_LONG', r.status === 400 && r.body.code === 'GIFT_NOTE_TOO_LONG')
  r = await sendGift(A.token, { giftId: hidden.id, receiverId: B.id, quantity: 1 })
  ok('inactive gift → 404 GIFT_NOT_FOUND', r.status === 404 && r.body.code === 'GIFT_NOT_FOUND')
  r = await sendGift(A.token, { giftId: RANDOM_UUID, receiverId: B.id, quantity: 1 })
  ok('unknown gift → 404', r.status === 404)
  r = await sendGift(A.token, { giftId: rose.id, receiverId: RANDOM_UUID, quantity: 1 })
  ok('unknown receiver → 404 GIFT_RECEIVER_UNAVAILABLE', r.status === 404 && r.body.code === 'GIFT_RECEIVER_UNAVAILABLE')
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1, source: 'room' })
  ok('invalid source → 400', r.status === 400)
  r = await sendGift(C.token, { giftId: car.id, receiverId: B.id, quantity: 1 })
  ok('insufficient ken → 400 GIFT_INSUFFICIENT_KEN', r.status === 400 && r.body.code === 'GIFT_INSUFFICIENT_KEN')
  ok('failed gift does not touch balance', (await me(C.token)).ken === 0)

  // ── disabled ──
  await putGiftSetting(adminToken, { ...DEFAULT_SETTING, enabled: false })
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1 })
  ok('disabled → 403 GIFT_DISABLED', r.status === 403 && r.body.code === 'GIFT_DISABLED')
  await putGiftSetting(adminToken, DEFAULT_SETTING)
  r = await req('PUT', '/admin/settings/gift', { value: { ...DEFAULT_SETTING, quantityOptions: [5, 1] } }, adminToken)
  ok('admin rejects bad gift setting → 400', r.status === 400)

  // ── send from profile ──
  const requestId = crypto.randomUUID()
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 5, note: '  chúc mừng  ', clientRequestId: requestId })
  ok('send gift → 201', r.status === 201)
  const sent = data(r)
  ok('send returns totals', sent.totalKen === 50 && sent.charmPoints === 60 && sent.quantity === 5)
  ok('send trims note', sent.note === 'chúc mừng')
  ok('send returns new balance', sent.kenBalance === 9950)
  ok('send returns receiver charm', sent.receiverCharm === 60)
  ok('profile gift has no chat message', !sent.messageId)

  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 5, clientRequestId: requestId })
  ok('replay same clientRequestId → 201', r.status === 201)
  ok('replay returns same transaction', data(r).transactionId === sent.transactionId)
  ok('replay does not charge twice', (await me(A.token)).ken === 9950)
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 2, clientRequestId: requestId })
  ok('reuse clientRequestId for another gift → 409', r.status === 409 && r.body.code === 'GIFT_REQUEST_CONFLICT')

  const raceId = crypto.randomUUID()
  const race = await Promise.all([1, 2, 3].map(() => sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1, clientRequestId: raceId })))
  ok('concurrent same request all succeed', race.every((x) => x.status === 201))
  ok('concurrent same request → one transaction', new Set(race.map((x) => data(x).transactionId)).size === 1)
  ok('concurrent same request charged once', (await me(A.token)).ken === 9940)

  const meB = await me(B.token)
  ok('receiver /user/me has charm', meB.charm === 72)
  ok('receiver ken unchanged', meB.ken === 0)
  r = await req('GET', `/user/${B.id}`, undefined, A.token)
  ok('public profile has charm', data(r).charm === 72)

  // ── wall ──
  r = await req('GET', `/gifts/users/${B.id}/wall`, undefined, C.token)
  ok('wall → 200', r.status === 200)
  const wall = data(r)
  ok('wall totals', wall.charm === 72 && wall.totalGifts === 6)
  ok('wall groups by gift', wall.items.length === 1 && wall.items[0].gift.id === rose.id && wall.items[0].quantity === 6)
  r = await req('GET', `/gifts/users/${RANDOM_UUID}/wall`, undefined, C.token)
  ok('wall unknown user → 404', r.status === 404)

  // ── notification ──
  r = await req('GET', '/notifications', undefined, B.token)
  const notifItems = data(r)?.items || []
  ok('receiver gets gift notification', notifItems.some((n) => n.type === 'gift_received' && n.actor?.id === A.id))

  // ── send from chat ──
  r = await req('POST', '/conversations/direct', { recipientId: B.id }, A.token)
  const conversationId = data(r)?.id
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1, source: 'chat', note: 'hi' })
  ok('chat gift → 201', r.status === 201)
  const chatGift = data(r)
  ok('chat gift returns message id', !!chatGift.messageId && chatGift.conversationId === conversationId)
  r = await req('GET', `/messages/${conversationId}`, undefined, B.token)
  const msgs = data(r)?.messages || []
  const giftMsg = msgs.find((m) => m.id === chatGift.messageId)
  ok('receiver sees gift message', !!giftMsg && giftMsg.type === 'gift')
  let meta = {}
  try { meta = JSON.parse(giftMsg?.metadata || '{}') } catch { meta = {} }
  ok('gift message metadata', meta.transactionId === chatGift.transactionId && meta.quantity === 1 && meta.note === 'hi')
  ok('gift message has text fallback', typeof giftMsg?.content === 'string' && giftMsg.content.includes('Hoa test'))
  r = await req('PATCH', `/messages/${conversationId}/${chatGift.messageId}`, { content: 'hack' }, A.token)
  ok('cannot edit gift message', r.status >= 400)
  r = await req('POST', '/messages', { conversationId, type: 'gift', content: 'fake', metadata: '{}' }, A.token)
  ok('client cannot send gift-type message → 400', r.status === 400)

  // ── ken history ──
  r = await req('GET', '/ken/transactions?direction=debit', undefined, A.token)
  const kenItems = data(r).items || []
  ok('ken history shows GIFT_SENT with receiver', kenItems.some((t) => t.type === 'GIFT_SENT' && t.counterpartyId === B.id && t.amount === 50))

  // ── history ──
  r = await req('GET', '/gifts/received?limit=2', undefined, B.token)
  const page1 = data(r)
  ok('received history page 1', page1.items.length === 2 && !!page1.nextCursor)
  ok('received history newest first', page1.items[0].source === 'chat' && page1.items[0].counterparty.id === A.id)
  r = await req('GET', `/gifts/received?limit=2&cursor=${encodeURIComponent(page1.nextCursor)}`, undefined, B.token)
  const page2 = data(r)
  ok('received history page 2', page2.items.length === 1 && !page2.nextCursor)
  ok('pages do not overlap', !page2.items.some((x) => page1.items.some((y) => y.id === x.id)))
  r = await req('GET', '/gifts/sent', undefined, A.token)
  ok('sent history lists receiver', data(r).items.length === 3 && data(r).items.every((x) => x.counterparty.id === B.id))
  r = await req('GET', '/gifts/received?cursor=garbage', undefined, B.token)
  ok('bad cursor → 400', r.status === 400)

  // ── leaderboard ──
  r = await req('GET', '/gifts/leaderboard?type=receiver&period=week', undefined, B.token)
  ok('leaderboard → 200', r.status === 200)
  ok('receiver week me value', data(r).me.value === 84 && data(r).me.rank >= 1)
  r = await req('GET', '/gifts/leaderboard?type=sender&period=month', undefined, A.token)
  ok('sender month me value', data(r).me.value === 70 && data(r).me.rank >= 1)
  r = await req('GET', '/gifts/leaderboard?type=receiver&period=all', undefined, B.token)
  ok('receiver all me value = charm', data(r).me.value === 84)
  r = await req('GET', '/gifts/leaderboard?type=receiver&period=week', undefined, C.token)
  ok('unranked user has rank 0', data(r).me.rank === 0 && data(r).me.value === 0)

  // ── block ──
  await req('POST', '/relationships/block', { userId: A.id }, B.token)
  r = await sendGift(A.token, { giftId: rose.id, receiverId: B.id, quantity: 1 })
  ok('blocked → 403 GIFT_BLOCKED', r.status === 403 && r.body.code === 'GIFT_BLOCKED')

  // ── admin ledger ──
  r = await req('GET', `/admin/gifts/transactions?userId=${A.id}`, undefined, adminToken)
  ok('admin ledger → 200', r.status === 200)
  ok('admin ledger totals', data(r).total === 3 && data(r).totalKen === 70 && data(r).items[0].sender.id === A.id)

  r = await req('PATCH', `/admin/gifts/${rose.id}`, { kenPrice: 20 }, adminToken)
  ok('admin update gift price', r.status === 200 && data(r).kenPrice === 20)
  r = await req('GET', '/gifts', undefined, A.token)
  ok('catalog reflects new price immediately', data(r).items.some((g) => g.id === rose.id && g.kenPrice === 20))

  for (const g of [rose, car, hidden]) {
    await req('DELETE', `/admin/gifts/${g.id}`, undefined, adminToken)
  }
  r = await req('GET', '/gifts', undefined, A.token)
  ok('deleted gifts leave catalog', !data(r).items.some((g) => [rose.id, car.id].includes(g.id)))
  r = await req('GET', `/gifts/users/${B.id}/wall`, undefined, A.token)
  ok('wall keeps deleted gift', data(r).items.some((x) => x.gift.id === rose.id))

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch((e) => { console.error(e); process.exit(1) })

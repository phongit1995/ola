'use strict'
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

async function pickFreeTypeIds(adminToken, count) {
  const r = await req('GET', '/admin/vip/shop', undefined, adminToken)
  const used = new Set((data(r)?.items || []).map((it) => it.vipTypeId))
  const ids = []
  for (let id = 120; id >= 1 && ids.length < count; id--) {
    if (!used.has(id)) ids.push(id)
  }
  return ids
}

async function main() {
  section('18 · VIP / KEN')

  const adminToken = await adminLogin()
  const u = await registerUser(uniqueUsername('vip'), undefined, randomPassword())
  console.log(`  → user=${u.username} (ken=0)`)

  const [freeType, paidType] = await pickFreeTypeIds(adminToken, 2)

  let r = await req('POST', '/admin/vip/shop', { vipTypeId: freeType, kenPrice: 0, sortOrder: 1 }, adminToken)
  ok('admin create free shop item → 2xx', r.status === 200 || r.status === 201)
  const freeItem = data(r)

  r = await req('POST', '/admin/vip/shop', { vipTypeId: paidType, kenPrice: 100, sortOrder: 2 }, adminToken)
  ok('admin create paid shop item → 2xx', r.status === 200 || r.status === 201)
  const paidItem = data(r)

  r = await req('POST', '/admin/vip/packages', { name: 'TestFree30', days: 30, kenPrice: 0, sortOrder: 1 }, adminToken)
  ok('admin create free package → 2xx', r.status === 200 || r.status === 201)
  const freePkg = data(r)

  r = await req('POST', '/admin/vip/packages', { name: 'TestPaid30', days: 30, kenPrice: 100, sortOrder: 2 }, adminToken)
  ok('admin create paid package → 2xx', r.status === 200 || r.status === 201)
  const paidPkg = data(r)

  r = await req('POST', '/admin/vip/shop', { vipTypeId: freeType, kenPrice: 0 }, adminToken)
  ok('admin create duplicate shop type → 409', r.status === 409)

  // auth guards
  r = await req('GET', '/vip/store')
  ok('store no token → 401', r.status === 401)
  r = await req('POST', '/vip/buy', { shopItemId: freeItem.id })
  ok('buy no token → 401', r.status === 401)
  r = await req('POST', '/admin/vip/shop', { vipTypeId: 1, kenPrice: 0 })
  ok('admin shop no token → 401', r.status === 401)
  r = await req('POST', '/admin/vip/shop', { vipTypeId: 1, kenPrice: 0 }, u.token)
  ok('admin shop with user token → 401/403', r.status === 401 || r.status === 403)

  // catalog + packages reflect created items
  r = await req('GET', '/vip/icons/catalog', undefined, u.token)
  ok('catalog → 200', r.status === 200)
  const catalog = data(r)?.items || []
  ok('catalog includes free item', catalog.some((c) => c.id === freeItem.id))
  ok('catalog includes paid item', catalog.some((c) => c.id === paidItem.id && c.kenPrice === 100))

  r = await req('GET', '/vip/packages', undefined, u.token)
  ok('packages → 200', r.status === 200)
  const pkgs = data(r)?.items || []
  ok('packages include free package', pkgs.some((p) => p.id === freePkg.id))

  // initial store
  r = await req('GET', '/vip/store', undefined, u.token)
  ok('store → 200', r.status === 200)
  let store = data(r)
  ok('store starts with no VIP duration', store.days == null)
  ok('store privacy default 0', store.privacy === 0)
  const initialItems = (store.items || []).length

  // privacy
  r = await req('PUT', '/vip/store/privacy', { privacy: 1 }, u.token)
  ok('set privacy=1 → 2xx', r.status === 200 || r.status === 201)
  r = await req('GET', '/vip/store', undefined, u.token)
  ok('privacy reflects 1', data(r).privacy === 1)
  r = await req('PUT', '/vip/store/privacy', { privacy: 5 }, u.token)
  ok('invalid privacy=5 → 400', r.status === 400)

  // buy free package (extends VIP days) — user has 0 ken, price 0
  r = await req('POST', `/vip/packages/${freePkg.id}/buy`, undefined, u.token)
  ok('buy free package → 2xx', r.status === 200 || r.status === 201)
  ok('buy package returns 30 days', data(r)?.days === 30)
  ok('buy package keeps ken balance 0', data(r)?.kenBalance === 0)

  // buy paid package with 0 ken → insufficient
  r = await req('POST', `/vip/packages/${paidPkg.id}/buy`, undefined, u.token)
  ok('buy paid package (0 ken) → 400 insufficient', r.status === 400)

  // buy free icon (price 0)
  r = await req('POST', '/vip/buy', { shopItemId: freeItem.id }, u.token)
  ok('buy free icon → 2xx', r.status === 200 || r.status === 201)
  const bought = data(r)
  ok('buy returns item instance', !!bought?.item?.instanceId)
  ok('buy returns ken balance 0', bought?.kenBalance === 0)
  ok('bought icon type matches', bought?.item?.typeId === freeType)
  const instanceId = bought?.item?.instanceId

  // buy paid icon with 0 ken → insufficient
  r = await req('POST', '/vip/buy', { shopItemId: paidItem.id }, u.token)
  ok('buy paid icon (0 ken) → 400 insufficient', r.status === 400)

  // buy non-existent shop item → 404
  r = await req('POST', '/vip/buy', { shopItemId: RANDOM_UUID }, u.token)
  ok('buy unknown shop item → 404', r.status === 404)

  // buy invalid uuid body → 400
  r = await req('POST', '/vip/buy', { shopItemId: 'not-a-uuid' }, u.token)
  ok('buy invalid uuid → 400', r.status === 400)

  // store now has the bought icon
  r = await req('GET', '/vip/store', undefined, u.token)
  store = data(r)
  ok('store has new icon after buy', (store.items || []).length === initialItems + 1)
  ok('store has VIP days after package', (store.days ?? 0) > 0)

  // use the icon (costs 1 day, requires active VIP)
  r = await req('POST', `/vip/icons/${instanceId}/use`, undefined, u.token)
  ok('use icon → 2xx', r.status === 200 || r.status === 201)
  r = await req('GET', '/vip/store', undefined, u.token)
  ok('store shows icon in use', (data(r).items || []).some((it) => it.instanceId === instanceId && it.isUsing))

  // lock → cannot delete → unlock → delete
  r = await req('POST', `/vip/icons/${instanceId}/lock`, undefined, u.token)
  ok('lock icon → 2xx', r.status === 200 || r.status === 201)
  r = await req('DELETE', `/vip/icons/${instanceId}`, undefined, u.token)
  ok('delete locked icon → 403', r.status === 403)
  r = await req('POST', `/vip/icons/${instanceId}/unlock`, undefined, u.token)
  ok('unlock icon → 2xx', r.status === 200 || r.status === 201)
  r = await req('DELETE', `/vip/icons/${instanceId}`, undefined, u.token)
  ok('delete unlocked icon → 2xx', r.status === 200 || r.status === 201)

  // transfer rules
  const recipient = await registerUser(uniqueUsername('vipr'), undefined, randomPassword())
  r = await req('POST', `/vip/icons/${RANDOM_UUID}/transfer`, { toUserId: u.id }, u.token)
  ok('transfer to self → 400', r.status === 400)
  r = await req('POST', `/vip/icons/${RANDOM_UUID}/transfer`, { toUserId: recipient.id }, u.token)
  ok('transfer unknown icon → 404', r.status === 404)

  // history records purchases
  r = await req('GET', '/vip/history', undefined, u.token)
  ok('history → 200', r.status === 200)
  ok('history has entries', (data(r)?.items || []).length >= 1)

  // cleanup
  await req('DELETE', `/admin/vip/shop/${freeItem.id}`, undefined, adminToken)
  await req('DELETE', `/admin/vip/shop/${paidItem.id}`, undefined, adminToken)
  await req('DELETE', `/admin/vip/packages/${freePkg.id}`, undefined, adminToken)
  await req('DELETE', `/admin/vip/packages/${paidPkg.id}`, undefined, adminToken)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch((e) => { console.error(e); process.exit(1) })

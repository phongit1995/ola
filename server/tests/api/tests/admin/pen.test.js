'use strict'
const {
  ok, section, req, data, summary,
  registerUser, uniqueUsername, randomPassword,
} = require('../../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function grantKen(adminToken, userId, amount) {
  const r = await req('POST', `/admin/ken/users/${userId}/adjust`, { action: 'grant', amount, description: 'pen test' }, adminToken)
  if (r.status !== 200 && r.status !== 201) throw new Error(`grant ken failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).balanceAfter
}

function createShot(token, betAmount, side) {
  return req('POST', '/pen/shots', { betAmount, side }, token)
}

async function main() {
  section('ADMIN · PEN')

  const adminToken = await adminLogin()
  const A = await registerUser(uniqueUsername('apenA'), undefined, randomPassword())
  const B = await registerUser(uniqueUsername('apenB'), undefined, randomPassword())
  await grantKen(adminToken, A.id, 100000)
  await grantKen(adminToken, B.id, 100000)

  // seed data: one saved, one goal, one still open
  let r = await createShot(A.token, 1000, 'left')
  const s1 = data(r).shot.id
  await req('POST', `/pen/shots/${s1}/catch`, { side: 'left' }, B.token) // saved
  r = await createShot(A.token, 1000, 'left')
  const s2 = data(r).shot.id
  await req('POST', `/pen/shots/${s2}/catch`, { side: 'right' }, B.token) // goal
  r = await createShot(A.token, 2000, 'right')
  const s3 = data(r).shot.id // open

  // ── auth guards ──
  r = await req('GET', '/admin/pen/shots')
  ok('admin list no token → 401', r.status === 401)
  r = await req('GET', '/admin/pen/shots', undefined, A.token)
  ok('admin list with user token → 403', r.status === 403)
  r = await req('GET', '/admin/pen/stats', undefined, A.token)
  ok('admin stats with user token → 403', r.status === 403)

  // ── list all shots ──
  r = await req('GET', '/admin/pen/shots', undefined, adminToken)
  ok('admin list → 200', r.status === 200)
  const all = data(r)
  ok('list has items + total', Array.isArray(all.items) && typeof all.total === 'number')
  const item = (all.items || []).find((s) => s.id === s1)
  ok('item carries shooter + keeper', !!item && !!item.shooter && !!item.keeper)
  ok('admin reveals shooterSide', !!item && item.shooterSide === 'left')
  ok('settled item has pot/commission/payout', !!item && item.pot === 2000 && item.commission === 100 && item.payout === 1900)

  // ── filters ──
  r = await req('GET', '/admin/pen/shots?status=settled', undefined, adminToken)
  ok('filter status=settled → all settled', (data(r).items || []).every((s) => s.status === 'settled'))
  r = await req('GET', '/admin/pen/shots?result=saved', undefined, adminToken)
  ok('filter result=saved → all saved', (data(r).items || []).every((s) => s.result === 'saved'))
  r = await req('GET', `/admin/pen/shots?shooterId=${A.id}`, undefined, adminToken)
  ok('filter shooterId → all by A', (data(r).items || []).every((s) => s.shooter && s.shooter.id === A.id))
  r = await req('GET', '/admin/pen/shots?status=open', undefined, adminToken)
  ok('filter status=open includes s3', (data(r).items || []).some((s) => s.id === s3))
  r = await req('GET', '/admin/pen/shots?minBet=1500', undefined, adminToken)
  ok('filter minBet=1500 → all bet>=1500', (data(r).items || []).every((s) => s.betAmount >= 1500))
  r = await req('GET', '/admin/pen/shots?shooterId=not-a-uuid', undefined, adminToken)
  ok('filter invalid shooterId → 400', r.status === 400)

  // ── stats ──
  r = await req('GET', '/admin/pen/stats', undefined, adminToken)
  ok('admin stats → 200', r.status === 200)
  const stats = data(r)
  const o = stats.overview
  ok('overview present', !!o)
  ok('settled == saved + goal', o.settledShots === o.savedCount + o.goalCount)
  ok('keeperWinRate consistent', Math.abs(o.keeperWinRate - (o.settledShots ? (o.savedCount / o.settledShots) * 100 : 0)) < 0.01)
  ok('houseTake covers our 2 settled (>=200)', o.houseTake >= 200)
  ok('totalVolume covers our 2 pots (>=4000)', o.totalVolume >= 4000)
  ok('byResult counts sum to settled', (stats.byResult || []).reduce((acc, x) => acc + x.count, 0) === o.settledShots)
  ok('byStatus counts sum to total', (stats.byStatus || []).reduce((acc, x) => acc + x.count, 0) === o.totalShots)
  ok('timeseries is array', Array.isArray(stats.timeseries))
  ok('topPlayers is array', Array.isArray(stats.topPlayers))
  ok('bucket is day|month', stats.bucket === 'day' || stats.bucket === 'month')

  // cleanup the open shot
  await req('POST', `/pen/shots/${s3}/cancel`, undefined, A.token)

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch((e) => { console.error(e); process.exit(1) })

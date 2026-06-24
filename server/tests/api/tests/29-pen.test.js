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

async function grantKen(adminToken, userId, amount) {
  const r = await req('POST', `/admin/ken/users/${userId}/adjust`, { action: 'grant', amount, description: 'pen test' }, adminToken)
  if (r.status !== 200 && r.status !== 201) throw new Error(`grant ken failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).balanceAfter
}

async function getKen(token) {
  const r = await req('GET', '/user/me', undefined, token)
  return data(r).ken
}

function createShot(token, betAmount, side) {
  return req('POST', '/pen/shots', { betAmount, side }, token)
}

async function main() {
  section('29 · PEN (sút / chụp)')

  const adminToken = await adminLogin()
  const A = await registerUser(uniqueUsername('penA'), undefined, randomPassword())
  const B = await registerUser(uniqueUsername('penB'), undefined, randomPassword())
  const C = await registerUser(uniqueUsername('penC'), undefined, randomPassword())
  await grantKen(adminToken, A.id, 100000)
  await grantKen(adminToken, B.id, 100000)
  await grantKen(adminToken, C.id, 100000)

  // ── auth guards ──
  let r = await createShot(undefined, 1000, 'left')
  ok('create shot no token → 401', r.status === 401)
  r = await req('GET', '/pen/shots')
  ok('list shots no token → 401', r.status === 401)

  // ── validation ──
  r = await createShot(A.token, 500, 'left')
  ok('bet below min → 400', r.status === 400)
  r = await createShot(A.token, 6000000, 'left')
  ok('bet above max → 400', r.status === 400)
  r = await createShot(A.token, 1000, 'up')
  ok('invalid side → 400', r.status === 400)
  r = await req('POST', '/pen/shots', { betAmount: 1000 }, A.token)
  ok('missing side → 400', r.status === 400)

  const poor = await registerUser(uniqueUsername('penPoor'), undefined, randomPassword())
  r = await createShot(poor.token, 1000, 'left')
  ok('insufficient ken to shoot → 400', r.status === 400)

  // ── create shot deducts ken (escrow) ──
  const aBefore = await getKen(A.token)
  r = await createShot(A.token, 1000, 'left')
  ok('create shot → 201', r.status === 201)
  const shot1 = data(r)
  ok('shot status open', shot1.shot.status === 'open')
  ok('owner sees own side', shot1.shot.shooterSide === 'left')
  ok('ken deducted by 1000', shot1.kenBalance === aBefore - 1000)
  ok('me ken reflects deduction', (await getKen(A.token)) === aBefore - 1000)
  const shot1Id = shot1.shot.id

  // ── lobby: B sees it (side hidden), A excluded from own lobby ──
  r = await req('GET', '/pen/shots', undefined, B.token)
  ok('B lobby → 200', r.status === 200)
  const seen = (data(r).items || []).find((s) => s.id === shot1Id)
  ok('B sees A shot in lobby', !!seen)
  ok('lobby hides shooterSide', !!seen && seen.shooterSide === undefined)
  r = await req('GET', '/pen/shots', undefined, A.token)
  ok('A lobby excludes own shot', !(data(r).items || []).some((s) => s.id === shot1Id))

  r = await req('GET', '/pen/mine', undefined, A.token)
  ok('A /mine has open shot with side', (data(r).items || []).some((s) => s.id === shot1Id && s.shooterSide === 'left'))

  // ── cancel refunds ──
  const aBeforeCancel = await getKen(A.token)
  r = await req('POST', `/pen/shots/${shot1Id}/cancel`, undefined, A.token)
  ok('cancel own open shot → 200', r.status === 200)
  ok('cancel refunds 1000', data(r).kenBalance === aBeforeCancel + 1000)
  r = await req('POST', `/pen/shots/${shot1Id}/cancel`, undefined, A.token)
  ok('cancel again (not open) → 409', r.status === 409)
  r = await req('POST', `/pen/shots/${RANDOM_UUID}/cancel`, undefined, A.token)
  ok('cancel unknown shot → 404', r.status === 404)

  // ── catch SAVED (keeper guesses same side → thủ môn thắng) ──
  r = await createShot(A.token, 1000, 'left')
  const sSaved = data(r).shot.id
  r = await req('POST', `/pen/shots/${sSaved}/cancel`, undefined, B.token)
  ok('cancel not-your shot → 403', r.status === 403)
  r = await req('POST', `/pen/shots/${sSaved}/catch`, { side: 'left' }, A.token)
  ok('self-catch → 403', r.status === 403)

  const bBefore = await getKen(B.token)
  const aAfterShootSaved = await getKen(A.token)
  r = await req('POST', `/pen/shots/${sSaved}/catch`, { side: 'left' }, B.token)
  ok('catch (saved) → 200', r.status === 200)
  const saved = data(r)
  ok('result = saved', saved.result === 'saved')
  ok('keeper (B) wins', saved.winnerId === B.id && saved.win === true)
  ok('pot/commission/payout = 2000/100/1900', saved.pot === 2000 && saved.commission === 100 && saved.payout === 1900)
  ok('keeper net +900', saved.kenBalance === bBefore - 1000 + 1900)
  ok('shooter (A) gets nothing on loss', (await getKen(A.token)) === aAfterShootSaved)

  r = await req('POST', `/pen/shots/${sSaved}/catch`, { side: 'right' }, C.token)
  ok('catch already-settled → 409', r.status === 409)
  r = await req('POST', `/pen/shots/${RANDOM_UUID}/catch`, { side: 'left' }, C.token)
  ok('catch unknown shot → 404', r.status === 404)

  // invalid catch side
  r = await createShot(A.token, 1000, 'left')
  const sBad = data(r).shot.id
  r = await req('POST', `/pen/shots/${sBad}/catch`, { side: 'middle' }, B.token)
  ok('catch invalid side → 400', r.status === 400)
  await req('POST', `/pen/shots/${sBad}/cancel`, undefined, A.token)

  // ── catch GOAL (keeper guesses wrong side → người sút thắng) ──
  r = await createShot(A.token, 2000, 'left')
  const sGoal = data(r).shot.id
  const aAfterShootGoal = await getKen(A.token)
  const cBefore = await getKen(C.token)
  r = await req('POST', `/pen/shots/${sGoal}/catch`, { side: 'right' }, C.token)
  ok('catch (goal) → 200', r.status === 200)
  const goal = data(r)
  ok('result = goal', goal.result === 'goal')
  ok('shooter (A) wins, caller(C) lost', goal.winnerId === A.id && goal.win === false)
  ok('pot/commission/payout = 4000/200/3800', goal.pot === 4000 && goal.commission === 200 && goal.payout === 3800)
  ok('keeper (C) net -2000', goal.kenBalance === cBefore - 2000)
  ok('shooter (A) credited payout 3800', (await getKen(A.token)) === aAfterShootGoal + 3800)

  // ── insufficient ken to catch ──
  const poor2 = await registerUser(uniqueUsername('penPoor2'), undefined, randomPassword())
  r = await createShot(A.token, 1000, 'left')
  const sPoor = data(r).shot.id
  r = await req('POST', `/pen/shots/${sPoor}/catch`, { side: 'left' }, poor2.token)
  ok('catch with insufficient ken → 400', r.status === 400)
  await req('POST', `/pen/shots/${sPoor}/cancel`, undefined, A.token)

  // ── race: 2 keepers catch the same shot, exactly one wins ──
  r = await createShot(A.token, 1000, 'left')
  const sRace = data(r).shot.id
  const [rb, rc] = await Promise.all([
    req('POST', `/pen/shots/${sRace}/catch`, { side: 'left' }, B.token),
    req('POST', `/pen/shots/${sRace}/catch`, { side: 'right' }, C.token),
  ])
  const successes = [rb, rc].filter((x) => x.status === 200).length
  const conflicts = [rb, rc].filter((x) => x.status === 409).length
  ok('race: exactly one catch succeeds', successes === 1)
  ok('race: the loser gets 409 (no longer open)', conflicts === 1)

  // ── history ──
  r = await req('GET', '/pen/history?role=all', undefined, A.token)
  ok('A history → 200', r.status === 200)
  ok('A history has entries', (data(r).items || []).length >= 1)
  r = await req('GET', '/pen/history?role=shoot', undefined, A.token)
  ok('A history (shoot) shows goal win', (data(r).items || []).some((s) => s.id === sGoal && s.result === 'goal'))
  r = await req('GET', '/pen/history?role=catch', undefined, B.token)
  ok('B history (catch) shows a saved result', (data(r).items || []).some((s) => s.result === 'saved'))

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch((e) => { console.error(e); process.exit(1) })

'use strict'
const crypto = require('crypto')
const { io } = require('socket.io-client')
const {
  ok, section, req, data, sleep, summary, WS_BASE,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'
const RANDOM_UUID = '00000000-0000-4000-8000-000000000000'
const PRICE = 100

const BASE_SETTING = {
  enabled: true,
  kenPrice: PRICE,
  maxLength: 80,
  displaySeconds: 3,
  cooldownSeconds: 0,
  dailyLimit: 50,
  maxQueueSeconds: 600,
}

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function grantKen(adminToken, userId, amount) {
  const r = await req('POST', `/admin/ken/users/${userId}/adjust`, { action: 'grant', amount, description: 'megaphone test' }, adminToken)
  if (r.status !== 200 && r.status !== 201) throw new Error(`grant ken failed: ${r.status} ${JSON.stringify(r.body)}`)
}

async function kenOf(token) {
  return data(await req('GET', '/user/me', undefined, token)).ken
}

function send(token, content, clientRequestId = crypto.randomUUID()) {
  return req('POST', '/megaphones', { content, clientRequestId }, token)
}

async function putSetting(adminToken, key, value) {
  const r = await req('PUT', `/admin/settings/${key}`, { value }, adminToken)
  if (r.status !== 200) throw new Error(`put ${key} failed: ${r.status} ${JSON.stringify(r.body)}`)
}

async function readSetting(adminToken, key) {
  const r = await req('GET', '/admin/settings', undefined, adminToken)
  return (data(r)?.items ?? []).find((item) => item.key === key)?.value ?? null
}

async function newUser(adminToken, prefix, ken) {
  const user = await registerUser(uniqueUsername(prefix), undefined, randomPassword())
  if (ken > 0) await grantKen(adminToken, user.id, ken)
  return user
}

function connectWS(token) {
  return new Promise((resolve, reject) => {
    const socket = io(WS_BASE, { auth: { token }, transports: ['websocket'], timeout: 8000 })
    const timer = setTimeout(() => { socket.disconnect(); reject(new Error('WS connect timeout')) }, 8000)
    socket.on('connect', () => { clearTimeout(timer); resolve(socket) })
    socket.on('connect_error', (err) => { clearTimeout(timer); reject(err) })
  })
}

function waitForEvent(socket, type, match, timeoutMs = 8000) {
  return new Promise((resolve) => {
    const timer = setTimeout(() => { socket.off('message', handler); resolve(null) }, timeoutMs)
    function handler(msg) {
      if (msg?.type !== type || !match(msg.data)) return
      clearTimeout(timer)
      socket.off('message', handler)
      resolve(msg.data)
    }
    socket.on('message', handler)
  })
}

async function main() {
  section('33 · MEGAPHONES (phát loa)')

  const adminToken = await adminLogin()
  const originalMegaphone = await readSetting(adminToken, 'megaphone')
  const originalFilter = await readSetting(adminToken, 'content_filter')
  const created = []

  await putSetting(adminToken, 'megaphone', BASE_SETTING)
  await putSetting(adminToken, 'content_filter', { bannedWords: ['nạp ken giá rẻ', 'địt'] })

  const A = await newUser(adminToken, 'loaA', 1000)
  const B = await newUser(adminToken, 'loaB', 1000)
  const Poor = await newUser(adminToken, 'loaP', 50)

  try {
    // ── settings validation ──
    let r = await req('PUT', '/admin/settings/megaphone', { value: { ...BASE_SETTING, displaySeconds: 1 } }, adminToken)
    ok('admin rejects display below min → 400', r.status === 400)
    r = await req('PUT', '/admin/settings/megaphone', { value: { ...BASE_SETTING, extra: 1 } }, adminToken)
    ok('admin rejects unknown megaphone field → 400', r.status === 400)
    r = await req('PUT', '/admin/settings/content_filter', { value: { bannedWords: ['  '] } }, adminToken)
    ok('admin rejects blank banned word → 400', r.status === 400)

    // ── auth ──
    r = await req('GET', '/megaphones/config')
    ok('config without token → 401', r.status === 401)
    r = await req('POST', '/megaphones', { content: 'x', clientRequestId: crypto.randomUUID() })
    ok('send without token → 401', r.status === 401)

    // ── config ──
    r = await req('GET', '/megaphones/config', undefined, A.token)
    ok('config → 200', r.status === 200)
    const cfg = data(r)
    ok('config reflects setting', cfg.enabled === true && cfg.kenPrice === PRICE && cfg.maxLength === 80 && cfg.displaySeconds === 3)
    ok('config has caller state', cfg.todayCount === 0 && cfg.cooldownRemaining === 0 && typeof cfg.queueWaitSeconds === 'number')

    // ── content validation, never charges ──
    r = await send(A.token, '   \n  ')
    ok('blank content → 400 MEGAPHONE_CONTENT_EMPTY', r.status === 400 && r.body.code === 'MEGAPHONE_CONTENT_EMPTY')
    r = await send(A.token, 'á'.repeat(81))
    ok('81 runes → 400 MEGAPHONE_CONTENT_TOO_LONG', r.status === 400 && r.body.code === 'MEGAPHONE_CONTENT_TOO_LONG')
    r = await send(A.token, 'vào https://abc.xyz chơi nhé')
    ok('url → 400 MEGAPHONE_LINK_NOT_ALLOWED', r.status === 400 && r.body.code === 'MEGAPHONE_LINK_NOT_ALLOWED')
    r = await send(A.token, 'ghé shop.vn đi mọi người')
    ok('bare domain → 400 MEGAPHONE_LINK_NOT_ALLOWED', r.status === 400 && r.body.code === 'MEGAPHONE_LINK_NOT_ALLOWED')
    r = await send(A.token, 'Ai cần NẠP KEN GIÁ RẺ ib')
    ok('banned phrase → 400 MEGAPHONE_CONTENT_BLOCKED', r.status === 400 && r.body.code === 'MEGAPHONE_CONTENT_BLOCKED')
    r = await send(A.token, 'đ.ị.t cả lũ')
    ok('spaced-out banned word → 400 MEGAPHONE_CONTENT_BLOCKED', r.status === 400 && r.body.code === 'MEGAPHONE_CONTENT_BLOCKED')
    r = await send(Poor.token, 'mình nghèo quá')
    ok('insufficient ken → 400 MEGAPHONE_INSUFFICIENT_KEN', r.status === 400 && r.body.code === 'MEGAPHONE_INSUFFICIENT_KEN')
    ok('poor user keeps balance', (await kenOf(Poor.token)) === 50)
    ok('rejected sends never charge', (await kenOf(A.token)) === 1000)

    // ── admin content check ──
    r = await req('POST', '/admin/content-filter/check', { text: 'nap-ken-gia-re' }, adminToken)
    ok('admin check flags banned word', r.status === 201 && data(r).blocked === true && data(r).reason === 'banned_word')
    r = await req('POST', '/admin/content-filter/check', { text: 'xem abc.com' }, adminToken)
    ok('admin check flags link', data(r).blocked === true && data(r).reason === 'link')
    r = await req('POST', '/admin/content-filter/check', { text: 'đi tắm thôi' }, adminToken)
    ok('admin check passes clean text', data(r).blocked === false)
    r = await req('POST', '/admin/content-filter/check', { text: 'x' }, A.token)
    ok('user token cannot use admin check', r.status === 401 || r.status === 403)

    // ── send + realtime ──
    const ws = await connectWS(B.token)
    const content = `Chào   cả nhà 🎉 ${Date.now()}`
    const normalized = content.replace(/\s+/g, ' ')
    const eventPromise = waitForEvent(ws, 'MEGAPHONE_NEW', (d) => d?.megaphone?.content === normalized)
    const requestId = crypto.randomUUID()
    r = await send(A.token, content, requestId)
    ok('send → 201', r.status === 201)
    const sent = data(r)
    created.push(sent.megaphone.id)
    ok('send normalizes whitespace', sent.megaphone.content === normalized)
    ok('send returns sender brief', sent.megaphone.sender.id === A.id && typeof sent.megaphone.sender.username === 'string')
    ok('send returns schedule', sent.megaphone.displaySeconds === 3 && !Number.isNaN(Date.parse(sent.megaphone.showAt)))
    ok('send returns balance', sent.kenBalance === 1000 - PRICE)
    ok('balance charged once', (await kenOf(A.token)) === 1000 - PRICE)
    r = await req('GET', '/megaphones/active', undefined, B.token)
    ok('active → 200 with serverTime', r.status === 200 && typeof data(r).serverTime === 'string')
    ok('active lists playing megaphone', data(r).items.some((m) => m.id === sent.megaphone.id))
    const event = await eventPromise
    ok('other users receive MEGAPHONE_NEW', event != null && event.megaphone.id === sent.megaphone.id && typeof event.serverTime === 'string')

    r = await send(A.token, content, requestId)
    ok('replay same clientRequestId → 201 same megaphone', r.status === 201 && data(r).megaphone.id === sent.megaphone.id)
    ok('replay does not charge twice', (await kenOf(A.token)) === 1000 - PRICE)
    r = await send(A.token, 'nội dung khác', requestId)
    ok('reuse clientRequestId with other content → 409', r.status === 409 && r.body.code === 'MEGAPHONE_REQUEST_CONFLICT')

    const parallelId = crypto.randomUUID()
    const results = await Promise.all([1, 2, 3].map(() => send(B.token, 'gửi song song', parallelId)))
    const ids = new Set(results.filter((x) => x.status === 201).map((x) => data(x).megaphone.id))
    ok('parallel retries create one megaphone', results.every((x) => x.status === 201) && ids.size === 1)
    created.push(...ids)
    ok('parallel retries charge once', (await kenOf(B.token)) === 1000 - PRICE)

    r = await req('GET', '/ken/transactions', undefined, A.token)
    const kenItems = data(r)?.items ?? data(r)?.transactions ?? []
    ok('ken history shows MEGAPHONE debit', kenItems.some((t) => t.type === 'MEGAPHONE' && t.amount === PRICE))

    // ── active + history ──
    r = await req('GET', '/megaphones/active', undefined, B.token)
    const active = data(r).items
    ok('active sorted by showAt', active.every((m, i) => i === 0 || Date.parse(active[i - 1].showAt) <= Date.parse(m.showAt)))

    const firstShowAt = Date.parse(sent.megaphone.showAt)
    await sleep(Math.max(0, firstShowAt - Date.now()) + 300)
    r = await req('GET', '/megaphones?limit=50', undefined, B.token)
    ok('history → 200', r.status === 200)
    ok('history includes played megaphone', data(r).items.some((m) => m.id === sent.megaphone.id))

    // ── report ──
    r = await req('POST', '/reports', { targetType: 'megaphone', targetId: sent.megaphone.id, reason: 'spam' }, B.token)
    ok('report megaphone → 2xx', r.status >= 200 && r.status < 300)
    r = await req('POST', '/reports', { targetType: 'megaphone', targetId: sent.megaphone.id, reason: 'spam' }, A.token)
    ok('cannot report own megaphone → 400', r.status === 400)
    r = await req('POST', '/reports', { targetType: 'megaphone', targetId: RANDOM_UUID, reason: 'spam' }, B.token)
    ok('report unknown megaphone → 404', r.status === 404)
    r = await req('GET', `/admin/reports?targetType=megaphone&reportedUserId=${A.id}`, undefined, adminToken)
    ok('admin sees megaphone report with snapshot', data(r).items.some((x) => x.targetId === sent.megaphone.id && x.snapshot?.text === normalized))

    // ── admin list + remove ──
    r = await req('GET', `/admin/megaphones?senderId=${A.id}`, undefined, adminToken)
    ok('admin list → 200', r.status === 200 && data(r).total >= 1 && data(r).totalKen >= PRICE)
    ok('admin list item has sender', data(r).items.some((m) => m.id === sent.megaphone.id && m.sender.id === A.id))

    const removedPromise = waitForEvent(ws, 'MEGAPHONE_REMOVED', (d) => d?.id === sent.megaphone.id)
    r = await req('POST', `/admin/megaphones/${sent.megaphone.id}/remove`, {
      reason: 'test gỡ',
      penalty: { reason: 'spam', severity: 'violation', note: 'test' },
    }, adminToken)
    ok('admin remove → 201', r.status === 201 && data(r).item.status === 'removed' && data(r).item.removedReason === 'test gỡ')
    ok('admin remove counts a violation', data(r).penalty?.counted === true && data(r).penalty.points > 0)
    ok('clients receive MEGAPHONE_REMOVED', (await removedPromise) != null)
    ok('remove does not refund', (await kenOf(A.token)) === 1000 - PRICE)
    r = await req('GET', '/megaphones?limit=50', undefined, B.token)
    ok('history hides removed megaphone', !data(r).items.some((m) => m.id === sent.megaphone.id))
    r = await req('POST', `/admin/megaphones/${sent.megaphone.id}/remove`, {}, adminToken)
    ok('remove twice is a no-op', r.status === 201 && !data(r).penalty)
    r = await req('POST', `/admin/megaphones/${RANDOM_UUID}/remove`, {}, adminToken)
    ok('remove unknown → 404', r.status === 404)
    r = await req('GET', `/admin/users/${A.id}/violations`, undefined, adminToken)
    const violations = data(r)?.items ?? data(r) ?? []
    ok('violation recorded with megaphone source', Array.isArray(violations) && violations.some((v) => v.source === 'megaphone_remove' && v.targetType === 'megaphone'))
    ws.disconnect()

    // ── cooldown ──
    const C = await newUser(adminToken, 'loaC', 1000)
    await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, cooldownSeconds: 30 })
    r = await send(C.token, 'lần đầu')
    ok('first send with cooldown → 201', r.status === 201)
    created.push(data(r).megaphone.id)
    r = await send(C.token, 'lần hai')
    ok('second send → 429 MEGAPHONE_COOLDOWN', r.status === 429 && r.body.code === 'MEGAPHONE_COOLDOWN')
    ok('cooldown rejection does not charge', (await kenOf(C.token)) === 1000 - PRICE)
    r = await req('GET', '/megaphones/config', undefined, C.token)
    ok('config shows cooldown remaining', data(r).cooldownRemaining > 0 && data(r).todayCount === 1)

    const C2 = await newUser(adminToken, 'loaC2', 1000)
    const inflightId = crypto.randomUUID()
    const inflight = await Promise.all([1, 2, 3].map(() => send(C2.token, 'bấm hai lần', inflightId)))
    const inflightIds = new Set(inflight.filter((x) => x.status === 201).map((x) => data(x).megaphone.id))
    ok('duplicate retries in flight with cooldown all get the same megaphone', inflight.every((x) => x.status === 201) && inflightIds.size === 1)
    created.push(...inflightIds)
    ok('duplicate retries in flight charge once', (await kenOf(C2.token)) === 1000 - PRICE)

    // ── daily limit ──
    const D2 = await newUser(adminToken, 'loaD2', 1000)
    await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, dailyLimit: 2 })
    const burst = await Promise.all([1, 2, 3, 4].map((i) => send(D2.token, `song song ${i}`)))
    const burstOk = burst.filter((x) => x.status === 201)
    created.push(...burstOk.map((x) => data(x).megaphone.id))
    ok('parallel sends never exceed daily limit', burstOk.length === 2 && burst.filter((x) => x.body.code === 'MEGAPHONE_DAILY_LIMIT').length === 2)
    ok('parallel sends charge only accepted ones', (await kenOf(D2.token)) === 1000 - 2 * PRICE)

    const D = await newUser(adminToken, 'loaD', 1000)
    await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, dailyLimit: 2 })
    for (const text of ['một', 'hai']) {
      r = await send(D.token, `đếm ${text}`)
      if (r.status === 201) created.push(data(r).megaphone.id)
    }
    r = await send(D.token, 'đếm ba')
    ok('third send → 429 MEGAPHONE_DAILY_LIMIT', r.status === 429 && r.body.code === 'MEGAPHONE_DAILY_LIMIT')
    ok('daily limit rejection does not charge', (await kenOf(D.token)) === 1000 - 2 * PRICE)

    // ── queue full ──
    const E = await newUser(adminToken, 'loaE', 5000)
    await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, displaySeconds: 60, maxQueueSeconds: 60 })
    let full = null
    let spent = 0
    for (let i = 0; i < 6 && full == null; i += 1) {
      r = await send(E.token, `xếp hàng ${i}`)
      if (r.status === 201) { created.push(data(r).megaphone.id); spent += PRICE } else full = r
    }
    ok('queue overflow → 409 MEGAPHONE_QUEUE_FULL', full != null && full.status === 409 && full.body.code === 'MEGAPHONE_QUEUE_FULL')
    ok('queue full does not charge', (await kenOf(E.token)) === 5000 - spent)
    r = await req('GET', '/megaphones/config', undefined, E.token)
    ok('config reports queue wait', data(r).queueWaitSeconds > 0)

    // ── disabled ──
    await putSetting(adminToken, 'megaphone', BASE_SETTING)
    const F = await newUser(adminToken, 'loaF', 1000)
    const lateId = crypto.randomUUID()
    r = await send(F.token, 'gửi trước khi tắt', lateId)
    ok('send before disabling → 201', r.status === 201)
    const late = data(r).megaphone
    created.push(late.id)
    await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, enabled: false })
    r = await send(A.token, 'tắt rồi')
    ok('disabled → 403 MEGAPHONE_DISABLED', r.status === 403 && r.body.code === 'MEGAPHONE_DISABLED')
    r = await send(F.token, 'gửi trước khi tắt', lateId)
    ok('retry of a charged megaphone after disabling still replays', r.status === 201 && data(r).megaphone.id === late.id)
  } finally {
    for (const id of created) {
      await req('POST', `/admin/megaphones/${id}/remove`, { reason: 'test cleanup' }, adminToken)
    }
    if (originalMegaphone) await putSetting(adminToken, 'megaphone', originalMegaphone)
    else await putSetting(adminToken, 'megaphone', { ...BASE_SETTING, kenPrice: 2000, displaySeconds: 10, cooldownSeconds: 60, dailyLimit: 20, maxQueueSeconds: 300 })
    await putSetting(adminToken, 'content_filter', originalFilter ?? { bannedWords: [] })
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch((e) => { console.error(e); process.exit(1) })

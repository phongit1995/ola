'use strict'
const crypto = require('crypto')
const {
  ok, section, req, data, summary,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

const IOS = { 'X-Platform': 'ios', 'X-App-Version': '1.2.0 (45)' }
const ANDROID = { 'X-Platform': 'android', 'X-App-Version': '1.2.0 (45)' }
const ANDROID_OLD = { 'X-Platform': 'android', 'X-App-Version': '1.1.0 (40)' }

const OPEN_RULE = { enabled: true, disableVersions: [] }
const PLATFORMS = {
  web: OPEN_RULE,
  android: { enabled: true, disableVersions: ['1.1.0'] },
  ios: { enabled: false, disableVersions: [] },
}

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function currentSetting(adminToken, key) {
  const r = await req('GET', '/admin/settings', undefined, adminToken)
  const rows = Array.isArray(data(r)) ? data(r) : data(r).items
  return rows.find((row) => row.key === key)?.value
}

function putSetting(adminToken, key, value) {
  return req('PUT', `/admin/settings/${key}`, { value }, adminToken)
}

function appConfig(token, headers) {
  return req('GET', '/settings/app', undefined, token, headers)
}

function sendGift(token, giftId, receiverId, headers) {
  return req('POST', '/gifts/send', {
    giftId, receiverId, quantity: 1, source: 'profile', clientRequestId: crypto.randomUUID(),
  }, token, headers)
}

function sendMegaphone(token, headers) {
  return req('POST', '/megaphones', {
    content: `kiem tra ${Date.now()}`, clientRequestId: crypto.randomUUID(),
  }, token, headers)
}

async function main() {
  section('35 · GIFT + MEGAPHONE THEO NỀN TẢNG')

  const adminToken = await adminLogin()
  const originalGift = await currentSetting(adminToken, 'gift')
  const originalMegaphone = await currentSetting(adminToken, 'megaphone')
  const baseGift = originalGift ?? {
    enabled: true, quantityOptions: [1, 5, 10, 99], quantityMax: 99, noteMaxLength: 100, confirmOverKen: 1000,
  }
  const baseMegaphone = originalMegaphone ?? {
    enabled: true, kenPrice: 5000, maxLength: 80, displaySeconds: 12, cooldownSeconds: 60, dailyLimit: 20,
    liveMinutes: 30, gapSeconds: 3, repeatBaseSeconds: 720, messageWeight: 3,
    giftTiers: [{ minKen: 0, weight: 1 }, { minKen: 1000, weight: 3 }, { minKen: 20000, weight: 6 }],
  }

  try {
    const sender = await registerUser(uniqueUsername('gpA'), undefined, randomPassword())
    const receiver = await registerUser(uniqueUsername('gpB'), undefined, randomPassword())
    await req('POST', `/admin/ken/users/${sender.id}/adjust`, { action: 'grant', amount: 5000000, description: 'platform test' }, adminToken)

    let r = await putSetting(adminToken, 'gift', { ...baseGift, platforms: PLATFORMS })
    ok('save gift platforms', r.status === 200)
    r = await putSetting(adminToken, 'megaphone', { ...baseMegaphone, cooldownSeconds: 0, platforms: PLATFORMS })
    ok('save megaphone platforms', r.status === 200)

    r = await putSetting(adminToken, 'gift', { ...baseGift, platforms: { web: OPEN_RULE } })
    ok('reject incomplete platforms', r.status === 400)

    const { platforms: _dropped, ...giftFromOldAdmin } = await currentSetting(adminToken, 'gift')
    r = await putSetting(adminToken, 'gift', giftFromOldAdmin)
    ok('save without platforms keeps stored rules', r.status === 200 && (await currentSetting(adminToken, 'gift')).platforms?.ios?.enabled === false)

    const ios = data(await appConfig(sender.token, IOS)).configs
    const android = data(await appConfig(sender.token, ANDROID)).configs
    const androidOld = data(await appConfig(sender.token, ANDROID_OLD)).configs
    const web = data(await appConfig(sender.token, {})).configs

    ok('app config has gift', ios.gift != null && Array.isArray(ios.gift.quantityOptions))
    ok('app config has megaphone', ios.megaphone != null && ios.megaphone.maxLength > 0)
    ok('megaphone keeps personal data out of app config', ios.megaphone.todayCount === undefined)
    ok('gift never exposes platforms', ios.gift.platforms === undefined)
    ok('ios gift off', ios.gift.enabled === false)
    ok('ios megaphone off', ios.megaphone.enabled === false)
    ok('android gift on', android.gift.enabled === true)
    ok('android disabled build off', androidOld.gift.enabled === false && androidOld.megaphone.enabled === false)
    ok('web on', web.gift.enabled === true && web.megaphone.enabled === true)

    const catalogIos = data(await req('GET', '/gifts', undefined, sender.token, IOS))
    const catalogAndroid = data(await req('GET', '/gifts', undefined, sender.token, ANDROID))
    ok('old catalog api follows platform', catalogIos.settings.enabled === false && catalogAndroid.settings.enabled === true)
    const configIos = data(await req('GET', '/megaphones/config', undefined, sender.token, IOS))
    ok('old megaphone api follows platform', configIos.enabled === false)

    const giftId = catalogAndroid.items[0]?.id
    ok('has a gift to send', giftId != null)

    r = await sendGift(sender.token, giftId, receiver.id, IOS)
    ok('ios cannot send gift', r.status === 403 && r.body?.code === 'GIFT_DISABLED')
    r = await sendGift(sender.token, giftId, receiver.id, ANDROID)
    ok('android can send gift', r.status === 200 || r.status === 201)

    r = await sendMegaphone(sender.token, IOS)
    ok('ios cannot send megaphone', r.status === 403 && r.body?.code === 'MEGAPHONE_DISABLED')
    r = await sendMegaphone(sender.token, ANDROID)
    ok('android can send megaphone', r.status === 200 || r.status === 201)

    r = await putSetting(adminToken, 'gift', { ...baseGift, enabled: false, platforms: PLATFORMS })
    ok('turn master switch off', r.status === 200)
    const masterOff = data(await appConfig(sender.token, ANDROID)).configs
    ok('master switch beats platform', masterOff.gift.enabled === false)
  } finally {
    await putSetting(adminToken, 'gift', baseGift)
    await putSetting(adminToken, 'megaphone', baseMegaphone)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})

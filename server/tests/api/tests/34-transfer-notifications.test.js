'use strict'
const {
  ok, section, req, data, summary,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin@123'

async function adminLogin() {
  const r = await req('POST', '/admin/auth/login', { username: ADMIN_USERNAME, password: ADMIN_PASSWORD })
  if (r.status !== 200) throw new Error(`admin login failed: ${r.status} ${JSON.stringify(r.body)}`)
  return data(r).token
}

async function waitForNotification(token, type) {
  for (let attempt = 0; attempt < 30; attempt += 1) {
    const r = await req('GET', '/notifications', undefined, token)
    const item = (data(r).items || []).find((n) => n.type === type)
    if (item) return item
    await new Promise((resolve) => setTimeout(resolve, 100))
  }
  return null
}

async function main() {
  section('34 · TRANSFER NOTIFICATIONS (chữ đọc được cho app cũ)')

  const adminToken = await adminLogin()
  const password = randomPassword()
  const sender = await registerUser(uniqueUsername('tnA'), undefined, password)
  const receiver = await registerUser(uniqueUsername('tnB'), undefined, randomPassword())

  let r = await req('POST', `/admin/ken/users/${sender.id}/adjust`, { action: 'grant', amount: 2000000, description: 'transfer notification test' }, adminToken)
  ok('grant ken', r.status === 200 || r.status === 201)

  r = await req('POST', '/ken/transfer', { toUserId: receiver.id, amount: 1250000, password }, sender.token)
  ok('transfer ken', r.status === 200 || r.status === 201)

  const ken = await waitForNotification(receiver.token, 'ken_received')
  ok('ken notification exists', ken != null)
  ok('ken preview is readable text', ken?.preview === 'Đã chuyển cho bạn 1,250,000 Ken')
  ok('ken transfer keeps the amount', ken?.transfer?.amount === 1250000)

  r = await req('POST', '/admin/vip/packages', { name: `TransferNotif${Date.now()}`, days: 30, kenPrice: 100, sortOrder: 99 }, adminToken)
  ok('create vip package', r.status === 200 || r.status === 201)
  const packageId = data(r).id

  r = await req('POST', `/vip/packages/${packageId}/gift`, { toUsername: receiver.username, password }, sender.token)
  ok('gift vip package', r.status === 200 || r.status === 201)

  const vip = await waitForNotification(receiver.token, 'vip_received')
  ok('vip notification exists', vip != null)
  ok('vip preview is readable text', vip?.preview === 'Đã tặng bạn 30 ngày VIP')
  ok('vip transfer keeps the days', vip?.transfer?.days === 30)

  await req('DELETE', `/admin/vip/packages/${packageId}`, undefined, adminToken)
  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})

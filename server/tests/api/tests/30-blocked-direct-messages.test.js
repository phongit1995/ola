'use strict'

const {
  BASE,
  ok,
  section,
  req,
  data,
  sleep,
  summary,
  uniqueUsername,
  uniqueEmail,
  randomPassword,
  is2xx,
} = require('../helpers')

const send = (user, conversationId, content) =>
  req('POST', '/messages', { conversationId, type: 'text', content }, user.token)

const sendDirect = (user, recipientId, content) =>
  req('POST', '/messages/direct', { recipientId, type: 'text', content }, user.token)

async function registerUser(index) {
  const username = uniqueUsername('bm')
  const email = uniqueEmail('bm')
  const password = randomPassword()
  const response = await fetch(`${BASE}/auth/register`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Forwarded-For': `198.18.0.${index + 1}`,
    },
    body: JSON.stringify({
      username,
      email,
      password,
      full_name: username,
    }),
  })
  if (!is2xx(response.status)) {
    throw new Error(`register ${username} failed: ${response.status} ${await response.text()}`)
  }
  const login = await req('POST', '/auth/login', { username, password })
  if (!is2xx(login.status)) {
    throw new Error(`login ${username} failed: ${login.status} ${JSON.stringify(login.body)}`)
  }
  const token = data(login)?.token
  const me = data(await req('GET', '/user/me', undefined, token))
  return { id: me.id, username, token }
}

async function main() {
  section('30 · BLOCKED DIRECT MESSAGES')

  const [alice, bob] = await Promise.all([registerUser(0), registerUser(1)])

  let r = await req('POST', '/conversations/direct', { recipientId: bob.id }, alice.token)
  ok('create direct conversation → 2xx', is2xx(r.status))
  const conversationId = data(r)?.id

  r = await send(alice, conversationId, 'before block')
  ok('send before block → 2xx', is2xx(r.status))
  const messageId = data(r)?.id

  r = await req('POST', '/relationships/block', { userId: bob.id }, alice.token)
  ok('alice blocks bob → 2xx', is2xx(r.status))
  const relationshipId = data(r)?.id

  const blockedSend = await send(alice, conversationId, 'blocked alice')
  ok('blocker cannot send in existing conversation → 403',
    blockedSend.status === 403)
  ok('blocked send returns MESSAGE_BLOCKED code',
    blockedSend.body?.code === 'MESSAGE_BLOCKED')
  ok('blocked user cannot send in existing conversation → 403',
    (await send(bob, conversationId, 'blocked bob')).status === 403)
  ok('blocker cannot use direct shortcut → 403',
    (await sendDirect(alice, bob.id, 'blocked direct alice')).status === 403)
  ok('blocked user cannot use direct shortcut → 403',
    (await sendDirect(bob, alice.id, 'blocked direct bob')).status === 403)
  ok('blocker cannot create or reopen direct conversation → 403',
    (await req('POST', '/conversations/direct', { recipientId: bob.id }, alice.token)).status === 403)
  ok('blocked user cannot create or reopen direct conversation → 403',
    (await req('POST', '/conversations/direct', { recipientId: alice.id }, bob.token)).status === 403)
  ok('blocker cannot edit an old message → 403',
    (await req('PATCH', `/messages/${conversationId}/${messageId}`, { content: 'edited while blocked' }, alice.token)).status === 403)
  const blockedReaction = await req(
    'POST',
    `/messages/${conversationId}/${messageId}/reactions`,
    { type: 'LOVE' },
    bob.token,
  )
  ok('blocked user cannot react to an old message → 403', blockedReaction.status === 403)
  ok('blocked reaction returns MESSAGE_BLOCKED code',
    blockedReaction.body?.code === 'MESSAGE_BLOCKED')
  const blockedTyping = await req(
    'POST',
    '/conversations/typing',
    { conversationId },
    bob.token,
  )
  ok('blocked user cannot publish typing indicator → 403', blockedTyping.status === 403)
  ok('blocked typing returns MESSAGE_BLOCKED code',
    blockedTyping.body?.code === 'MESSAGE_BLOCKED')

  r = await req('GET', `/messages/${conversationId}`, undefined, alice.token)
  const blockedMessages = data(r)?.messages ?? []
  ok('blocked attempts create no messages',
    blockedMessages.filter(message => message.content.startsWith('blocked')).length === 0)
  const originalMessage = blockedMessages.find(message => message.id === messageId)
  ok('blocked edit does not change old message', originalMessage?.content === 'before block')
  ok('blocked reaction does not change old message',
    !originalMessage?.reactions?.LOVE?.includes(bob.id))

  r = await req('DELETE', `/relationships/${relationshipId}/unblock`, undefined, alice.token)
  ok('alice unblocks bob → 2xx', is2xx(r.status))

  await sleep(2200)

  ok('alice can send after unblock → 2xx',
    is2xx((await send(alice, conversationId, 'after unblock alice')).status))
  ok('bob can send after unblock → 2xx',
    is2xx((await send(bob, conversationId, 'after unblock bob')).status))

  const result = summary()
  process.exit(result.failed > 0 ? 1 : 0)
}

main().catch(error => {
  console.error(error)
  process.exit(1)
})

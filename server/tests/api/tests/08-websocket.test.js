'use strict'
const { ok, section, req, reqForm, data, sleep, summary, createUserSet, WS_BASE, audioForm } = require('../helpers')
const { io } = require('socket.io-client')

function connectWS(token) {
  return new Promise((resolve, reject) => {
    const socket = io(WS_BASE, {
      auth: { token },
      transports: ['websocket'],
      timeout: 8000,
    })
    const timer = setTimeout(() => {
      socket.disconnect()
      reject(new Error('WS connect timeout'))
    }, 8000)
    socket.on('connect', () => {
      clearTimeout(timer)
      resolve(socket)
    })
    socket.on('connect_error', (err) => {
      clearTimeout(timer)
      reject(err)
    })
  })
}

async function main() {
  section('08 · WEBSOCKET — connect + message fanout')

  const users = await createUserSet(3, 'ws')
  const [alice, bob, charlie] = users

  // 3-member group
  let r = await req('POST', '/conversations/group', {
    name: 'WS Test Group',
    participantIds: [bob.id, charlie.id],
  }, alice.token)
  const groupId = data(r)?.id

  let wsA, wsB, wsC
  try {
    // Connect all 3 users
    [wsA, wsB, wsC] = await Promise.all([
      connectWS(alice.token),
      connectWS(bob.token),
      connectWS(charlie.token),
    ])
    ok('alice connected', true)
    ok('bob connected', true)
    ok('charlie connected', true)

    // Wait for fanout of NEW_MESSAGE to all 3 members including sender
    const result = await new Promise((resolve) => {
      const received = { alice: false, bob: false, charlie: false }
      const timer = setTimeout(() => resolve(received), 7000)

      const check = () => {
        if (received.alice && received.bob && received.charlie) {
          clearTimeout(timer)
          resolve(received)
        }
      }

      wsA.on('message', (msg) => {
        if (msg?.type === 'NEW_MESSAGE' && msg?.data?.message?.content === 'WS fanout test') {
          received.alice = true; check()
        }
      })
      wsB.on('message', (msg) => {
        if (msg?.type === 'NEW_MESSAGE' && msg?.data?.message?.content === 'WS fanout test') {
          received.bob = true; check()
        }
      })
      wsC.on('message', (msg) => {
        if (msg?.type === 'NEW_MESSAGE' && msg?.data?.message?.content === 'WS fanout test') {
          received.charlie = true; check()
        }
      })

      // Wait a bit then send via REST
      sleep(300).then(() => {
        req('POST', '/messages', {
          conversationId: groupId,
          type: 'text',
          content: 'WS fanout test',
        }, alice.token)
      })
    })

    ok('bob received NEW_MESSAGE', result.bob)
    ok('charlie received NEW_MESSAGE', result.charlie)
    ok('alice receives own message (multi-device sync)', result.alice)

    r = await req('POST', '/conversations/direct', { recipientId: bob.id }, alice.token)
    const directId = data(r)?.id
    const audioClientMsgId = `ws-audio-${Date.now()}`
    const audioReceived = await new Promise((resolve) => {
      const timer = setTimeout(() => resolve(null), 7000)
      wsB.on('message', (msg) => {
        const message = msg?.data?.message
        if (
          msg?.type === 'NEW_MESSAGE' &&
          message?.conversationId === directId &&
          message?.clientMsgId === audioClientMsgId
        ) {
          clearTimeout(timer)
          resolve(message)
        }
      })
      sleep(300).then(() =>
        reqForm('POST', '/messages/audio', audioForm(directId, audioClientMsgId), alice.token)
      )
    })
    ok('bob received direct voice NEW_MESSAGE', audioReceived?.type === 'audio')
    const realtimeAudioMeta = JSON.parse(audioReceived?.metadata || '{}')
    ok('realtime voice contains playable URL', /^https?:\/\//.test(realtimeAudioMeta.url || ''))

  } catch (err) {
    console.error('  WS error:', err.message)
    ok('alice connected', false)
    ok('bob connected', false)
    ok('charlie connected', false)
    ok('bob received NEW_MESSAGE', false)
    ok('charlie received NEW_MESSAGE', false)
    ok('alice NOT fanout to herself', false)
    ok('bob received direct voice NEW_MESSAGE', false)
    ok('realtime voice contains playable URL', false)
  } finally {
    wsA?.disconnect()
    wsB?.disconnect()
    wsC?.disconnect()
  }

  // Message persisted in history
  await sleep(200)
  r = await req('GET', `/messages/${groupId}`, undefined, alice.token)
  const messages = data(r)?.messages ?? []
  ok('REST msg in history', messages.some(m => m.content === 'WS fanout test'))

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}
main().catch(e => { console.error(e); process.exit(1) })

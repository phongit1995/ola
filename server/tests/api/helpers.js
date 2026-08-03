'use strict'

const crypto = require('crypto')
const fs = require('fs')
const path = require('path')

const BASE    = process.env.API_BASE || 'http://localhost:8080/api/v1'
const WS_BASE = process.env.WS_BASE  || 'http://localhost:8080'

function localEnvValue(name) {
  try {
    const envFile = fs.readFileSync(path.resolve(__dirname, '../..', '.env'), 'utf8')
    const line = envFile.split(/\r?\n/).find((item) => item.startsWith(`${name}=`))
    return line?.slice(name.length + 1).trim().replace(/^(['"])(.*)\1$/, '$2') ?? ''
  } catch {
    return ''
  }
}

const API_GUARD_SECRET = process.env.API_GUARD_SECRET || localEnvValue('API_GUARD_SECRET')

function apiGuardHeaders(method, requestPath) {
  if (!API_GUARD_SECRET) return {}
  const timestamp = Date.now().toString()
  const nonce = crypto.randomUUID()
  const basePath = new URL(BASE).pathname.replace(/\/$/, '')
  const pathWithoutQuery = requestPath.split(/[?#]/, 1)[0]
  const fullPath = `${basePath}${pathWithoutQuery.startsWith('/') ? pathWithoutQuery : `/${pathWithoutQuery}`}`
  const canonical = [timestamp, nonce, method.toUpperCase(), fullPath].join('\n')
  const signature = crypto.createHmac('sha512', API_GUARD_SECRET).update(canonical).digest('hex')
  return { 'X-Timestamp': timestamp, 'X-Nonce': nonce, 'X-Signature': signature }
}

let _passed = 0
let _failed = 0

function ok(label, result) {
  if (result) {
    console.log(`  ✅ ${label}`)
    _passed++
  } else {
    console.error(`  ❌ ${label}`)
    _failed++
  }
}

function section(title) {
  console.log(`\n══════════════════════════════════════════`)
  console.log(`  ${title}`)
  console.log(`══════════════════════════════════════════`)
}

async function req(method, path, body, token, extraHeaders = {}) {
  const headers = {
    'Content-Type': 'application/json',
    ...apiGuardHeaders(method, path),
    ...extraHeaders,
  }
  if (token) headers['Authorization'] = `Bearer ${token}`
  const res = await fetch(`${BASE}${path}`, {
    method,
    headers,
    body: body !== undefined ? JSON.stringify(body) : undefined,
  })
  const text = await res.text()
  let json
  try { json = JSON.parse(text) } catch { json = text }
  return { status: res.status, body: json }
}

async function reqForm(method, path, form, token) {
  const headers = {}
  if (token) headers['Authorization'] = `Bearer ${token}`
  const res = await fetch(`${BASE}${path}`, { method, headers, body: form })
  const text = await res.text()
  let json
  try { json = JSON.parse(text) } catch { json = text }
  return { status: res.status, body: json }
}

function silentWav(durationSeconds = 1, sampleRate = 8000) {
  const samples = Math.max(1, Math.round(durationSeconds * sampleRate))
  const dataSize = samples * 2
  const wav = Buffer.alloc(44 + dataSize)
  wav.write('RIFF', 0)
  wav.writeUInt32LE(36 + dataSize, 4)
  wav.write('WAVE', 8)
  wav.write('fmt ', 12)
  wav.writeUInt32LE(16, 16)
  wav.writeUInt16LE(1, 20)
  wav.writeUInt16LE(1, 22)
  wav.writeUInt32LE(sampleRate, 24)
  wav.writeUInt32LE(sampleRate * 2, 28)
  wav.writeUInt16LE(2, 32)
  wav.writeUInt16LE(16, 34)
  wav.write('data', 36)
  wav.writeUInt32LE(dataSize, 40)
  return wav
}

function audioForm(conversationId, clientMsgId) {
  const form = new FormData()
  form.append('conversationId', conversationId)
  form.append('duration', '1')
  form.append('waveform', JSON.stringify([0.08, 0.2, 0.4, 0.2, 0.08]))
  form.append('clientMsgId', clientMsgId)
  form.append('file', new Blob([silentWav()], { type: 'audio/wav' }), 'voice.wav')
  return form
}

// Unwrap ApiResponse.data (Go server wraps all responses in { success, data, ... })
function data(r) {
  return r.body?.data ?? r.body
}

const sleep = (ms) => new Promise(r => setTimeout(r, ms))

const ALPHANUM = 'abcdefghijklmnopqrstuvwxyz0123456789'
function randStr(n) {
  let s = ''
  for (let i = 0; i < n; i++) s += ALPHANUM[Math.floor(Math.random() * ALPHANUM.length)]
  return s
}

function uniqueUsername(prefix = 'u') {
  return `${prefix}${Date.now().toString(36).slice(-5)}${randStr(4)}`
}

function uniqueEmail(prefix = 'u') {
  return `${prefix}${Date.now().toString(36).slice(-5)}${randStr(4)}@test.com`
}

function randomPassword() {
  let letters = ''
  for (let i = 0; i < 4; i++) letters += ALPHANUM[Math.floor(Math.random() * 26)]
  let digits = ''
  for (let i = 0; i < 4; i++) digits += Math.floor(Math.random() * 10)
  return letters + digits
}

async function registerUser(username, email, password, fullName) {
  const registrationIP = `198.18.${Math.floor(Math.random() * 254) + 1}.${Math.floor(Math.random() * 254) + 1}`
  let r
  for (let attempt = 0; attempt < 20; attempt++) {
    r = await req('POST', '/auth/register', {
      username,
      email,
      password,
      full_name: fullName || username,
    }, undefined, { 'X-Forwarded-For': registrationIP })
    if (r.status !== 429) break
    await new Promise((resolve) => setTimeout(resolve, 700))
  }
  if (r.status !== 200 && r.status !== 201) {
    throw new Error(`register ${username} failed: ${r.status} ${JSON.stringify(r.body)}`)
  }
  // login to get token
  const lr = await req('POST', '/auth/login', { username, password })
  if (lr.status !== 200 && lr.status !== 201) {
    throw new Error(`login ${username} failed: ${lr.status} ${JSON.stringify(lr.body)}`)
  }
  const d = data(lr)
  const meR = await req('GET', '/user/me', undefined, d.token)
  const me = data(meR)
  return {
    token: d.token,
    refreshToken: d.refreshToken,
    id: me.id,
    username,
    email,
    password,
  }
}

async function createUserSet(count = 5, prefix = 'u') {
  const NAMES = [
    'Alice','Bob','Charlie','Dana','Eve','Frank','Grace','Henry',
    'Ivy','Jack','Kate','Liam','Mia','Noah','Olivia','Pete',
  ]
  const users = []
  for (let i = 0; i < count; i++) {
    const uname = uniqueUsername(prefix)
    const email = uniqueEmail(prefix)
    const pw = randomPassword()
    const u = await registerUser(uname, email, pw, NAMES[i % NAMES.length])
    users.push(u)
  }
  return users
}

function envInt(name, def, min = 1, max = 1000) {
  const v = parseInt(process.env[name], 10)
  if (Number.isNaN(v)) return def
  return Math.max(min, Math.min(max, v))
}

function summary() {
  console.log('\n──────────────────────────────────────────')
  console.log(`  Results: ${_passed} passed, ${_failed} failed`)
  if (_failed === 0) console.log('  🎉 All tests passed!')
  else console.log(`  ⚠️  ${_failed} test(s) failed`)
  console.log('──────────────────────────────────────────\n')
  return { passed: _passed, failed: _failed }
}

function counts() { return { passed: _passed, failed: _failed } }
function reset() { _passed = 0; _failed = 0 }

const is2xx = (status) => status >= 200 && status < 300


async function becomeFriends(userA, userB) {
  await req('POST', '/relationships/request', { userId: userB.id }, userA.token)
  const pending = await req('GET', '/relationships/pending', undefined, userB.token)
  const list = data(pending)?.relationships ?? []
  const found = list.find(
    (rq) => rq.requesterId === userA.id || rq.requester?.id === userA.id
  )
  if (!found) return null
  const res = await req(
    'PUT', `/relationships/${found.id}/respond`, { action: 'accept' }, userB.token
  )
  return is2xx(res.status) ? found.id : null
}

async function sendFriendRequest(userA, userB) {
  const res = await req('POST', '/relationships/request', { userId: userB.id }, userA.token)
  return is2xx(res.status)
}

module.exports = {
  BASE, WS_BASE,
  ok, section, req, reqForm, data, sleep, is2xx,
  silentWav, audioForm,
  uniqueUsername, uniqueEmail, randomPassword, registerUser, createUserSet,
  becomeFriends, sendFriendRequest,
  envInt,
  summary, counts, reset,
}

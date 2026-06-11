'use strict'
const {
  BASE, ok, section, req, data, summary, is2xx,
  registerUser, uniqueUsername, randomPassword,
} = require('../helpers')

const FAKE_UUID = '00000000-0000-0000-0000-000000000000'

const createPost = (u, body) => req('POST', '/me', body, u.token)

async function makeFriends(a, b) {
  const sr = await req('POST', '/relationships/request', { userId: b.id }, a.token)
  const relId = data(sr)?.id
  await req('PUT', `/relationships/${relId}/respond`, { action: 'accept' }, b.token)
}

async function newUser(prefix) {
  return registerUser(uniqueUsername(prefix), undefined, randomPassword())
}

async function main() {
  section('22 · ME / POSTS (create, visibility, react, comment)')

  // ──────────────────────────────────────────────────────────
  // SECTION 1: Create & validation
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 1: Create & validation ──')
  {
    const u1 = await newUser('m1')

    let r = await createPost(u1, { content: 'hello world' })
    ok('1.1  create post → 201', r.status === 201)
    const post = data(r)
    ok('1.2  post has id', !!post?.id)
    ok('1.3  default visibility public', post?.visibility === 'public')
    ok('1.4  likeCount/dislikeCount/commentCount = 0',
      post?.likeCount === 0 && post?.dislikeCount === 0 && post?.commentCount === 0)
    ok('1.5  myReaction null', post?.myReaction === null)
    ok('1.6  author is creator', post?.author?.id === u1.id)

    r = await createPost(u1, {})
    ok('1.7  empty post (no content/images) → 400', r.status === 400)

    r = await createPost(u1, {
      content: 'too many',
      images: Array.from({ length: 6 }, (_, i) => ({ url: `http://x/${i}.jpg` })),
    })
    ok('1.8  more than 5 images → 400', r.status === 400)

    r = await createPost(u1, {
      content: 'with pics',
      images: [
        { url: 'http://x/a.jpg', width: 100, height: 200, mimeType: 'image/jpeg' },
        { url: 'http://x/b.png', width: 50, height: 60, mimeType: 'image/png' },
      ],
    })
    ok('1.9  create with 2 images → 201', r.status === 201)
    ok('1.10 response keeps 2 images', data(r)?.images?.length === 2)
    ok('1.11 image url preserved', data(r)?.images?.[0]?.url === 'http://x/a.jpg')

    r = await createPost(u1, { content: 'private one', visibility: 'private' })
    ok('1.12 create private → 201', r.status === 201 && data(r)?.visibility === 'private')

    r = await createPost(u1, { content: 'bad', visibility: 'secret' })
    ok('1.13 invalid visibility → 400', r.status === 400)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 2: Feed & own list
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 2: Feed & mine ──')
  {
    const u = await newUser('m2')
    const r1 = await createPost(u, { content: 'feed post A' })
    const pid = data(r1)?.id

    let r = await req('GET', '/me', undefined, u.token)
    ok('2.1  feed → 200', r.status === 200)
    ok('2.2  feed has pagination shape',
      Array.isArray(data(r)?.items) && typeof data(r)?.total === 'number' &&
      typeof data(r)?.limit === 'number' && typeof data(r)?.offset === 'number')
    ok('2.3  feed contains own post', data(r)?.items?.some(p => p.id === pid))

    r = await req('GET', '/me/mine', undefined, u.token)
    ok('2.4  mine → 200', r.status === 200)
    ok('2.5  mine contains own post', data(r)?.items?.some(p => p.id === pid))
    ok('2.6  mine only own posts', data(r)?.items?.every(p => p.author?.id === u.id))

    r = await req('GET', '/me?limit=999', undefined, u.token)
    ok('2.7  feed limit clamped to 100', data(r)?.limit === 100)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 3: Private visibility (self / friend / stranger)
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 3: Private visibility ──')
  {
    const author = await newUser('m3a')
    const friend = await newUser('m3b')
    const stranger = await newUser('m3c')

    const pub = data(await createPost(author, { content: 'public post' }))
    const priv = data(await createPost(author, { content: 'private post', visibility: 'private' }))

    let r = await req('GET', `/me/${priv.id}`, undefined, author.token)
    ok('3.1  author sees own private → 200', r.status === 200)

    r = await req('GET', `/me/${priv.id}`, undefined, stranger.token)
    ok('3.2  stranger sees private → 404', r.status === 404)

    await makeFriends(author, friend)
    r = await req('GET', `/me/${priv.id}`, undefined, friend.token)
    ok('3.3  friend sees private → 200', r.status === 200)

    r = await req('GET', `/me/users/${author.id}`, undefined, stranger.token)
    ok('3.4  stranger lists author: public only',
      r.status === 200 &&
      data(r)?.items?.some(p => p.id === pub.id) &&
      !data(r)?.items?.some(p => p.id === priv.id))

    r = await req('GET', `/me/users/${author.id}`, undefined, friend.token)
    ok('3.5  friend lists author: sees private too',
      r.status === 200 && data(r)?.items?.some(p => p.id === priv.id))

    r = await req('GET', `/me/${FAKE_UUID}`, undefined, author.token)
    ok('3.6  non-existent post → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 4: Update & delete (author only)
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 4: Update & delete ──')
  {
    const author = await newUser('m4a')
    const other = await newUser('m4b')
    const post = data(await createPost(author, { content: 'original' }))

    let r = await req('PUT', `/me/${post.id}`, { content: 'edited' }, other.token)
    ok('4.1  non-author update → 403', r.status === 403)

    r = await req('PUT', `/me/${post.id}`, { content: 'edited', visibility: 'private' }, author.token)
    ok('4.2  author update → 200', r.status === 200)
    ok('4.3  content updated', data(r)?.content === 'edited')
    ok('4.4  visibility updated', data(r)?.visibility === 'private')

    r = await req('DELETE', `/me/${post.id}`, undefined, other.token)
    ok('4.5  non-author delete → 403', r.status === 403)

    r = await req('DELETE', `/me/${post.id}`, undefined, author.token)
    ok('4.6  author delete → 200', r.status === 200)

    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('4.7  deleted post → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 5: Like / dislike
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 5: React (like/dislike) ──')
  {
    const author = await newUser('m5a')
    const viewer = await newUser('m5b')
    const post = data(await createPost(author, { content: 'react me' }))

    let r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    ok('5.1  like → 200', r.status === 200)
    ok('5.2  likeCount = 1', data(r)?.likeCount === 1)
    ok('5.3  myReaction = like', data(r)?.myReaction === 'like')

    r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    ok('5.4  like again toggles off', data(r)?.likeCount === 0 && data(r)?.myReaction === null)

    r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    r = await req('POST', `/me/${post.id}/react`, { type: 'dislike' }, viewer.token)
    ok('5.5  switch like→dislike',
      data(r)?.likeCount === 0 && data(r)?.dislikeCount === 1 && data(r)?.myReaction === 'dislike')

    r = await req('DELETE', `/me/${post.id}/react`, undefined, viewer.token)
    ok('5.6  remove reaction', data(r)?.dislikeCount === 0 && data(r)?.myReaction === null)

    r = await req('POST', `/me/${post.id}/react`, { type: 'love' }, viewer.token)
    ok('5.7  invalid reaction type → 400', r.status === 400)

    // detail reflects another viewer's own reaction
    await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    r = await req('GET', `/me/${post.id}`, undefined, viewer.token)
    ok('5.8  detail shows viewer myReaction=like', data(r)?.myReaction === 'like' && data(r)?.likeCount === 1)
    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('5.9  detail shows author myReaction=null but count=1',
      data(r)?.myReaction === null && data(r)?.likeCount === 1)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 6: Comments
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 6: Comments ──')
  {
    const author = await newUser('m6a')
    const commenter = await newUser('m6b')
    const stranger = await newUser('m6c')
    const post = data(await createPost(author, { content: 'comment me' }))

    let r = await req('POST', `/me/${post.id}/comments`, { content: 'nice!' }, commenter.token)
    ok('6.1  add comment → 201', r.status === 201)
    const comment = data(r)
    ok('6.2  comment content + author', comment?.content === 'nice!' && comment?.author?.id === commenter.id)

    r = await req('POST', `/me/${post.id}/comments`, {}, commenter.token)
    ok('6.3  empty comment → 400', r.status === 400)

    r = await req('GET', `/me/${post.id}/comments`, undefined, author.token)
    ok('6.4  list comments → 200, total 1', r.status === 200 && data(r)?.total === 1)

    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('6.5  post commentCount = 1', data(r)?.commentCount === 1)

    r = await req('DELETE', `/me/${post.id}/comments/${comment.id}`, undefined, stranger.token)
    ok('6.6  stranger delete comment → 403', r.status === 403)

    r = await req('DELETE', `/me/${post.id}/comments/${comment.id}`, undefined, commenter.token)
    ok('6.7  commenter delete own → 200', r.status === 200)

    r = await req('GET', `/me/${post.id}/comments`, undefined, author.token)
    ok('6.8  comments empty after delete', data(r)?.total === 0)

    // post author can delete others' comments
    const c2 = data(await req('POST', `/me/${post.id}/comments`, { content: 'second' }, commenter.token))
    r = await req('DELETE', `/me/${post.id}/comments/${c2.id}`, undefined, author.token)
    ok('6.9  post author deletes any comment → 200', r.status === 200)

    // private post: stranger cannot comment
    const priv = data(await createPost(author, { content: 'secret', visibility: 'private' }))
    r = await req('POST', `/me/${priv.id}/comments`, { content: 'sneak' }, stranger.token)
    ok('6.10 stranger comment on private → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 7: Auth & upload validation
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 7: Auth & upload ──')
  {
    const u = await newUser('m7')

    let r = await req('POST', '/me', { content: 'no auth' })
    ok('7.1  create without token → 401', r.status === 401)

    r = await req('GET', '/me')
    ok('7.2  feed without token → 401', r.status === 401)

    // upload with empty multipart form → 400
    const res = await fetch(`${BASE}/me/images`, {
      method: 'POST',
      headers: { Authorization: `Bearer ${u.token}` },
      body: new FormData(),
    })
    ok('7.3  upload with no images → 400', res.status === 400)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch(e => { console.error(e); process.exit(1) })

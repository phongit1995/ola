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
  section('22 · ME / POSTS (create, visibility, react, comment, mentions, check-in, sticker, likers)')

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

    r = await createPost(u1, { content: 'friend one', visibility: 'friend' })
    ok('1.12 create friend → 201', r.status === 201 && data(r)?.visibility === 'friend')

    r = await createPost(u1, { content: 'private one', visibility: 'private' })
    ok('1.13 create private → 201', r.status === 201 && data(r)?.visibility === 'private')

    r = await createPost(u1, { content: 'bad', visibility: 'secret' })
    ok('1.14 invalid visibility → 400', r.status === 400)

    r = await createPost(u1, { content: 'no clan', visibility: 'clan' })
    ok('1.15 clan visibility removed → 400', r.status === 400)
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
  // SECTION 3: Private visibility = ONLY author (self)
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 3: Private = self only ──')
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
    ok('3.3  friend does NOT see private → 404', r.status === 404)

    r = await req('GET', `/me/users/${author.id}`, undefined, stranger.token)
    ok('3.4  stranger lists author: public only',
      r.status === 200 &&
      data(r)?.items?.some(p => p.id === pub.id) &&
      !data(r)?.items?.some(p => p.id === priv.id))

    r = await req('GET', `/me/users/${author.id}`, undefined, friend.token)
    ok('3.5  friend lists author: still NOT private',
      r.status === 200 && !data(r)?.items?.some(p => p.id === priv.id))

    r = await req('GET', `/me/users/${author.id}`, undefined, author.token)
    ok('3.6  author lists self: sees private',
      r.status === 200 && data(r)?.items?.some(p => p.id === priv.id))

    r = await req('GET', `/me/${FAKE_UUID}`, undefined, author.token)
    ok('3.7  non-existent post → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 4: Friend visibility = author + friends
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 4: Friend visibility ──')
  {
    const author = await newUser('m4a')
    const friend = await newUser('m4b')
    const stranger = await newUser('m4c')

    const fr = data(await createPost(author, { content: 'friends only', visibility: 'friend' }))

    let r = await req('GET', `/me/${fr.id}`, undefined, author.token)
    ok('4.1  author sees own friend-post → 200', r.status === 200)

    r = await req('GET', `/me/${fr.id}`, undefined, stranger.token)
    ok('4.2  stranger sees friend-post → 404', r.status === 404)

    r = await req('GET', `/me/${fr.id}`, undefined, friend.token)
    ok('4.3  not-yet-friend sees friend-post → 404', r.status === 404)

    await makeFriends(author, friend)
    r = await req('GET', `/me/${fr.id}`, undefined, friend.token)
    ok('4.4  friend sees friend-post → 200', r.status === 200)

    r = await req('GET', '/me', undefined, friend.token)
    ok('4.5  friend-post appears in friend feed', data(r)?.items?.some(p => p.id === fr.id))

    r = await req('GET', '/me', undefined, stranger.token)
    ok('4.6  friend-post NOT in stranger feed', !data(r)?.items?.some(p => p.id === fr.id))

    r = await req('GET', `/me/users/${author.id}`, undefined, friend.token)
    ok('4.7  friend lists author: sees friend-post', data(r)?.items?.some(p => p.id === fr.id))
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 5: Update & delete (author only)
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 5: Update & delete ──')
  {
    const author = await newUser('m5a')
    const other = await newUser('m5b')
    const post = data(await createPost(author, { content: 'original' }))

    let r = await req('PUT', `/me/${post.id}`, { content: 'edited' }, other.token)
    ok('5.1  non-author update → 403', r.status === 403)

    r = await req('PUT', `/me/${post.id}`, { content: 'edited', visibility: 'private' }, author.token)
    ok('5.2  author update → 200', r.status === 200)
    ok('5.3  content updated', data(r)?.content === 'edited')
    ok('5.4  visibility updated', data(r)?.visibility === 'private')

    r = await req('DELETE', `/me/${post.id}`, undefined, other.token)
    ok('5.5  non-author delete → 403', r.status === 403)

    r = await req('DELETE', `/me/${post.id}`, undefined, author.token)
    ok('5.6  author delete → 200', r.status === 200)

    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('5.7  deleted post → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 6: Like / dislike
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 6: React (like/dislike) ──')
  {
    const author = await newUser('m6a')
    const viewer = await newUser('m6b')
    const post = data(await createPost(author, { content: 'react me' }))

    let r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    ok('6.1  like → 200', r.status === 200)
    ok('6.2  likeCount = 1', data(r)?.likeCount === 1)
    ok('6.3  myReaction = like', data(r)?.myReaction === 'like')

    r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    ok('6.4  like again toggles off', data(r)?.likeCount === 0 && data(r)?.myReaction === null)

    r = await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    r = await req('POST', `/me/${post.id}/react`, { type: 'dislike' }, viewer.token)
    ok('6.5  switch like→dislike',
      data(r)?.likeCount === 0 && data(r)?.dislikeCount === 1 && data(r)?.myReaction === 'dislike')

    r = await req('DELETE', `/me/${post.id}/react`, undefined, viewer.token)
    ok('6.6  remove reaction', data(r)?.dislikeCount === 0 && data(r)?.myReaction === null)

    r = await req('POST', `/me/${post.id}/react`, { type: 'love' }, viewer.token)
    ok('6.7  invalid reaction type → 400', r.status === 400)

    await req('POST', `/me/${post.id}/react`, { type: 'like' }, viewer.token)
    r = await req('GET', `/me/${post.id}`, undefined, viewer.token)
    ok('6.8  detail shows viewer myReaction=like', data(r)?.myReaction === 'like' && data(r)?.likeCount === 1)
    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('6.9  detail shows author myReaction=null but count=1',
      data(r)?.myReaction === null && data(r)?.likeCount === 1)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 7: Comments
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 7: Comments ──')
  {
    const author = await newUser('m7a')
    const commenter = await newUser('m7b')
    const stranger = await newUser('m7c')
    const post = data(await createPost(author, { content: 'comment me' }))

    let r = await req('POST', `/me/${post.id}/comments`, { content: 'nice!' }, commenter.token)
    ok('7.1  add comment → 201', r.status === 201)
    const comment = data(r)
    ok('7.2  comment content + author', comment?.content === 'nice!' && comment?.author?.id === commenter.id)

    r = await req('POST', `/me/${post.id}/comments`, {}, commenter.token)
    ok('7.3  empty comment → 400', r.status === 400)

    r = await req('GET', `/me/${post.id}/comments`, undefined, author.token)
    ok('7.4  list comments → 200, total 1', r.status === 200 && data(r)?.total === 1)

    r = await req('GET', `/me/${post.id}`, undefined, author.token)
    ok('7.5  post commentCount = 1', data(r)?.commentCount === 1)

    r = await req('DELETE', `/me/${post.id}/comments/${comment.id}`, undefined, stranger.token)
    ok('7.6  stranger delete comment → 403', r.status === 403)

    r = await req('DELETE', `/me/${post.id}/comments/${comment.id}`, undefined, commenter.token)
    ok('7.7  commenter delete own → 200', r.status === 200)

    r = await req('GET', `/me/${post.id}/comments`, undefined, author.token)
    ok('7.8  comments empty after delete', data(r)?.total === 0)

    const c2 = data(await req('POST', `/me/${post.id}/comments`, { content: 'second' }, commenter.token))
    r = await req('DELETE', `/me/${post.id}/comments/${c2.id}`, undefined, author.token)
    ok('7.9  post author deletes any comment → 200', r.status === 200)

    const priv = data(await createPost(author, { content: 'secret', visibility: 'private' }))
    r = await req('POST', `/me/${priv.id}/comments`, { content: 'sneak' }, stranger.token)
    ok('7.10 stranger comment on private → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 8: Mentions (@nick) + filter=mentions
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 8: Mentions ──')
  {
    const author = await newUser('m8a')
    const tagged = await newUser('m8b')
    const other = await newUser('m8c')

    const r1 = await createPost(author, { content: `Đi cà phê @${tagged.username} nhé! #ola` })
    const post = data(r1)
    ok('8.1  create post with @mention → 201', r1.status === 201)
    ok('8.2  mentions resolved to tagged user id',
      Array.isArray(post?.mentions) && post.mentions.includes(tagged.id))

    let r = await req('GET', '/me?filter=mentions', undefined, tagged.token)
    ok('8.3  tagged user mentions feed contains post',
      r.status === 200 && data(r)?.items?.some(p => p.id === post.id))

    r = await req('GET', '/me?filter=mentions', undefined, other.token)
    ok('8.4  non-tagged user mentions feed excludes post',
      r.status === 200 && !data(r)?.items?.some(p => p.id === post.id))

    const r2 = await createPost(author, { content: '@nobody_xyz_123 hello' })
    ok('8.5  unknown @nick → no mentions stored',
      r2.status === 201 && (data(r2)?.mentions === undefined || data(r2)?.mentions?.length === 0))

    const p3 = data(await createPost(author, { content: 'no tags yet' }))
    const r4 = await req('PUT', `/me/${p3.id}`, { content: `now tagging @${tagged.username}` }, author.token)
    ok('8.6  update re-resolves mentions', data(r4)?.mentions?.includes(tagged.id))
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 9: Check-in (object) & sticker
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 9: Check-in & sticker ──')
  {
    const u = await newUser('m9')

    let r = await createPost(u, {
      content: 'cafe sang',
      checkIn: { name: 'The Coffee House', address: '86-88 Cao Thang', lat: 10.771, lng: 106.682 },
      sticker: '🎉',
    })
    ok('9.1  create with check-in + sticker → 201', r.status === 201)
    const post = data(r)
    ok('9.2  checkIn object returned',
      post?.checkIn?.name === 'The Coffee House' && post?.checkIn?.address === '86-88 Cao Thang')
    ok('9.3  checkIn lat/lng preserved', post?.checkIn?.lat === 10.771 && post?.checkIn?.lng === 106.682)
    ok('9.4  sticker preserved', post?.sticker === '🎉')

    r = await req('GET', `/me/${post.id}`, undefined, u.token)
    ok('9.5  check-in persisted on GET', data(r)?.checkIn?.name === 'The Coffee House')

    r = await createPost(u, { content: 'no checkin' })
    ok('9.6  no check-in → checkIn omitted', data(r)?.checkIn == null)

    r = await createPost(u, { content: 'bad checkin', checkIn: { address: 'no name' } })
    ok('9.7  check-in without name → 400', r.status === 400)

    r = await createPost(u, { content: 'bad coord', checkIn: { name: 'X', lat: 999 } })
    ok('9.8  invalid latitude → 400', r.status === 400)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 10: Media filter (filter=media)
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 10: Media filter ──')
  {
    const u = await newUser('m10')
    const withMedia = data(await createPost(u, {
      content: 'has photo',
      images: [{ url: 'http://x/p.jpg', width: 10, height: 10, mimeType: 'image/jpeg' }],
    }))
    const noMedia = data(await createPost(u, { content: 'text only' }))

    const r = await req('GET', '/me?filter=media', undefined, u.token)
    ok('10.1 media filter → 200', r.status === 200)
    ok('10.2 contains post with images', data(r)?.items?.some(p => p.id === withMedia.id))
    ok('10.3 excludes text-only post', !data(r)?.items?.some(p => p.id === noMedia.id))
    ok('10.4 every item has images', data(r)?.items?.every(p => Array.isArray(p.images) && p.images.length > 0))
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 11: Likers endpoint
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 11: Likers ──')
  {
    const author = await newUser('m11a')
    const liker1 = await newUser('m11b')
    const liker2 = await newUser('m11c')
    const disliker = await newUser('m11d')
    const post = data(await createPost(author, { content: 'who likes me' }))

    await req('POST', `/me/${post.id}/react`, { type: 'like' }, liker1.token)
    await req('POST', `/me/${post.id}/react`, { type: 'like' }, liker2.token)
    await req('POST', `/me/${post.id}/react`, { type: 'dislike' }, disliker.token)

    let r = await req('GET', `/me/${post.id}/likers`, undefined, author.token)
    ok('11.1 likers → 200', r.status === 200)
    ok('11.2 total likers = 2 (dislike excluded)', data(r)?.total === 2)
    const usernames = (data(r)?.items || []).map(u => u.username)
    ok('11.3 likers include both likers',
      usernames.includes(liker1.username) && usernames.includes(liker2.username))
    ok('11.4 disliker not in likers', !usernames.includes(disliker.username))

    const priv = data(await createPost(author, { content: 'secret', visibility: 'private' }))
    r = await req('GET', `/me/${priv.id}/likers`, undefined, liker1.token)
    ok('11.5 stranger likers on private → 404', r.status === 404)
  }

  // ──────────────────────────────────────────────────────────
  // SECTION 12: Auth & upload validation
  // ──────────────────────────────────────────────────────────
  console.log('\n── SECTION 12: Auth & upload ──')
  {
    const u = await newUser('m12')

    let r = await req('POST', '/me', { content: 'no auth' })
    ok('12.1 create without token → 401', r.status === 401)

    r = await req('GET', '/me')
    ok('12.2 feed without token → 401', r.status === 401)

    const res = await fetch(`${BASE}/me/images`, {
      method: 'POST',
      headers: { Authorization: `Bearer ${u.token}` },
      body: new FormData(),
    })
    ok('12.3 upload with no images → 400', res.status === 400)
  }

  const s = summary()
  process.exit(s.failed > 0 ? 1 : 0)
}

main().catch(e => { console.error(e); process.exit(1) })

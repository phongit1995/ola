import type { Post, PostAuthor, PostReaction } from '../types';

const TOP_LIKERS_LIMIT = 3;

function applyTopLikers(
  likers: PostAuthor[] | undefined,
  wasLike: boolean,
  nowLike: boolean,
  self: PostAuthor
): PostAuthor[] {
  const current = likers ?? [];
  if (nowLike && !wasLike) {
    return [self, ...current.filter((u) => u.id !== self.id)].slice(0, TOP_LIKERS_LIMIT);
  }
  if (!nowLike && wasLike) {
    return current.filter((u) => u.id !== self.id);
  }
  return current;
}

export function reconcileTopLikers(server: Post, fallback: Post): Post {
  if ((server.topLikers?.length ?? 0) === 0 && server.likeCount > 0) {
    return { ...server, topLikers: fallback.topLikers };
  }
  return server;
}

export function applyPostReaction(post: Post, next: PostReaction | null, self?: PostAuthor): Post {
  let likeCount = post.likeCount;
  let dislikeCount = post.dislikeCount;
  if (post.myReaction === 'like') likeCount -= 1;
  if (post.myReaction === 'dislike') dislikeCount -= 1;
  if (next === 'like') likeCount += 1;
  if (next === 'dislike') dislikeCount += 1;
  const topLikers =
    self == null
      ? post.topLikers
      : applyTopLikers(post.topLikers, post.myReaction === 'like', next === 'like', self);
  return { ...post, likeCount, dislikeCount, myReaction: next, topLikers };
}

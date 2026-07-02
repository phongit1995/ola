import type { Post, PostReaction } from '../types';

export function applyPostReaction(post: Post, next: PostReaction | null): Post {
  let likeCount = post.likeCount;
  let dislikeCount = post.dislikeCount;
  if (post.myReaction === 'like') likeCount -= 1;
  if (post.myReaction === 'dislike') dislikeCount -= 1;
  if (next === 'like') likeCount += 1;
  if (next === 'dislike') dislikeCount += 1;
  return { ...post, likeCount, dislikeCount, myReaction: next };
}

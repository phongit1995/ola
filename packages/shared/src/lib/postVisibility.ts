import type { Post } from '../types';

function visible(post: Post, hidden: Set<string>, blocked: Set<string>): boolean {
  if (hidden.has(post.id)) return false;
  return post.author?.id == null || !blocked.has(post.author.id);
}

export function filterVisiblePosts(
  posts: Post[],
  hiddenPostIds: string[],
  blockedAuthorIds: string[]
): Post[] {
  if (hiddenPostIds.length === 0 && blockedAuthorIds.length === 0) return posts;
  const hidden = new Set(hiddenPostIds);
  const blocked = new Set(blockedAuthorIds);
  return posts.filter((post) => visible(post, hidden, blocked));
}

export function isPostVisible(
  post: Post,
  hiddenPostIds: string[],
  blockedAuthorIds: string[]
): boolean {
  return visible(post, new Set(hiddenPostIds), new Set(blockedAuthorIds));
}

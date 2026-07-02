import { colorForName } from '@lib';
import type { Post, PostReaction } from '@app-types';
import type { MePost } from './types';

export function applyPostReaction(post: Post, next: PostReaction | null): Post {
  let likeCount = post.likeCount;
  let dislikeCount = post.dislikeCount;
  if (post.myReaction === 'like') likeCount -= 1;
  if (post.myReaction === 'dislike') dislikeCount -= 1;
  if (next === 'like') likeCount += 1;
  if (next === 'dislike') dislikeCount += 1;
  return { ...post, likeCount, dislikeCount, myReaction: next };
}

export function applyMeReaction(post: MePost, type: PostReaction): MePost {
  if (type === 'like') {
    if (post.liked) return { ...post, liked: false, likes: Math.max(0, post.likes - 1) };
    return { ...post, liked: true, disliked: false, likes: post.likes + 1 };
  }
  if (post.disliked) return { ...post, disliked: false };
  return {
    ...post,
    disliked: true,
    liked: false,
    likes: post.liked ? Math.max(0, post.likes - 1) : post.likes,
  };
}

export function toMePost(post: Post, formatTime: (iso: string) => string): MePost {
  const author = post.author?.username ?? '';
  const checkIn = post.checkIn
    ? {
        name: post.checkIn.name,
        address: post.checkIn.address,
        lat: post.checkIn.lat,
        lng: post.checkIn.lng,
        action: post.checkIn.action,
        actionIcon: post.checkIn.actionIcon,
      }
    : null;
  return {
    id: post.id,
    authorId: post.author?.id ?? '',
    author,
    fullName: post.author?.fullName ?? '',
    color: colorForName(author),
    time: formatTime(post.createdAt),
    createdAt: post.createdAt,
    content: post.content ?? '',
    visibility: post.visibility,
    image: post.sticker && post.sticker !== '' ? post.sticker : null,
    photos: post.images?.map((image) => image.url) ?? [],
    checkIn,
    comments: post.commentCount,
    likes: post.likeCount,
    liked: post.myReaction === 'like',
    disliked: post.myReaction === 'dislike',
    mention: (post.mentions?.length ?? 0) > 0,
    pinned: post.isPinned,
  };
}

import { AVATAR_PALETTE, colorForName } from '@lib';
import type { Post } from '@app-types';
import type { MePost } from './types';

export function toMePost(post: Post, formatTime: (iso: string) => string): MePost {
  const author = post.author?.username ?? '';
  const likerCount = Math.min(3, post.likeCount);
  const likers: string[] = [];
  for (let i = 0; i < likerCount; i++) {
    likers.push(AVATAR_PALETTE[(i * 5 + author.length) % AVATAR_PALETTE.length]);
  }
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
    author,
    color: colorForName(author),
    time: formatTime(post.createdAt),
    content: post.content ?? '',
    image: post.sticker && post.sticker !== '' ? post.sticker : null,
    photos: post.images?.map((image) => image.url) ?? [],
    checkIn,
    comments: post.commentCount,
    likes: post.likeCount,
    likers,
    liked: post.myReaction === 'like',
    disliked: post.myReaction === 'dislike',
    mention: (post.mentions?.length ?? 0) > 0,
  };
}

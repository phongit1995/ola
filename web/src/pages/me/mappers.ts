import { colorForName } from '@lib';
import type { Post } from '@app-types';
import type { MePost } from './types';

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
  };
}

import { AVATAR_PALETTE, RELATIVE_TIME_UNITS } from './constants';
import type { Post } from '@app-types';
import type { MePost } from './types';

export function colorFromName(name: string): string {
  let hash = 0;
  for (let i = 0; i < name.length; i++) {
    hash = (hash * 31 + name.charCodeAt(i)) >>> 0;
  }
  return AVATAR_PALETTE[hash % AVATAR_PALETTE.length];
}

export function createDateFormatter(locale: string): (iso: string) => string {
  const formatter = new Intl.DateTimeFormat(locale, {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  });
  return (iso: string) => {
    const date = new Date(iso);
    return Number.isNaN(date.getTime()) ? iso : formatter.format(date);
  };
}

export function createTimeFormatter(locale: string): (iso: string) => string {
  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: 'auto' });
  return (iso: string) => {
    const then = new Date(iso).getTime();
    if (Number.isNaN(then)) return '';
    const diffSeconds = Math.round((then - Date.now()) / 1000);
    const abs = Math.abs(diffSeconds);
    for (const [unit, secs] of RELATIVE_TIME_UNITS) {
      if (abs >= secs || unit === 'second') {
        return rtf.format(Math.round(diffSeconds / secs), unit);
      }
    }
    return '';
  };
}

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
    color: colorFromName(author),
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

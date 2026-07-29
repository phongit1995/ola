import { colorForName } from '@lib';
import type { Post, PostReaction } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import type { MePost } from './types';

export { applyPostReaction } from '@ola/shared/stores/postHelpers';

export function reconcileMeLikers(server: MePost, fallback: MePost): MePost {
  if (server.topLikers.length === 0 && server.likes > 0) {
    return { ...server, topLikers: fallback.topLikers };
  }
  return server;
}

export function meSelfLiker(): MePost['topLikers'][number] | undefined {
  const user = useAuthStore.getState().user;
  if (user == null) return undefined;
  return {
    name: user.fullName || user.username,
    avatar: user.avatar ?? null,
    color: colorForName(user.username),
  };
}

type MeLiker = MePost['topLikers'][number];

function withSelfLiker(
  post: MePost,
  nowLiked: boolean,
  self?: MeLiker
): MePost['topLikers'] {
  if (self == null) return post.topLikers;
  if (nowLiked && !post.liked) {
    return [
      self,
      ...post.topLikers.filter((liker) => liker.name !== self.name),
    ].slice(0, 3);
  }
  if (!nowLiked && post.liked) {
    return post.topLikers.filter((liker) => liker.name !== self.name);
  }
  return post.topLikers;
}

export function applyMeReaction(
  post: MePost,
  type: PostReaction,
  self?: MeLiker
): MePost {
  if (type === 'like') {
    const topLikers = withSelfLiker(post, !post.liked, self);
    if (post.liked) {
      return {
        ...post,
        liked: false,
        likes: Math.max(0, post.likes - 1),
        topLikers,
      };
    }
    return {
      ...post,
      liked: true,
      disliked: false,
      likes: post.likes + 1,
      topLikers,
    };
  }
  const topLikers = withSelfLiker(post, false, self);
  if (post.disliked) return { ...post, disliked: false };
  return {
    ...post,
    disliked: true,
    liked: false,
    likes: post.liked ? Math.max(0, post.likes - 1) : post.likes,
    topLikers,
  };
}

export function toMePost(
  post: Post,
  formatTime: (iso: string) => string
): MePost {
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
    clanId: post.clanId,
    clanHandle: post.clanHandle,
    authorId: post.author?.id ?? '',
    author,
    fullName: post.author?.fullName ?? '',
    avatar: post.author?.avatar ?? null,
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
    topLikers: (post.topLikers ?? []).map((liker) => ({
      name: liker.fullName || liker.username,
      avatar: liker.avatar ?? null,
      color: colorForName(liker.username),
    })),
  };
}

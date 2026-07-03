import type { RelationshipStatus } from './user.type';

export type PostVisibility = 'public' | 'friend' | 'private';

export type PostReaction = 'like' | 'dislike';

export type MeFeedFilter = 'tagged' | 'mentions' | 'media' | 'following';

export interface PostCheckIn {
  name: string;
  address?: string;
  lat?: number;
  lng?: number;
  action?: string;
  actionIcon?: string;
}

export interface PostImage {
  url: string;
  width?: number;
  height?: number;
  mimeType?: string;
}

export interface PostAuthor {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  isFriend?: boolean;
  isSelf?: boolean;
  relationship?: { status: RelationshipStatus; requestId?: string };
}

export interface Post {
  id: string;
  content?: string;
  images: PostImage[];
  mentions?: string[];
  checkIn?: PostCheckIn | null;
  sticker?: string;
  visibility: PostVisibility;
  likeCount: number;
  dislikeCount: number;
  commentCount: number;
  myReaction: PostReaction | null;
  isPinned: boolean;
  author?: PostAuthor;
  topLikers?: PostAuthor[];
  createdAt: string;
  updatedAt: string;
}

export interface PostListResult {
  items: Post[];
  total: number;
  limit: number;
  offset: number;
}

export interface MeFeedResult {
  items: Post[];
  nextCursor: string | null;
}

export interface PostComment {
  id: string;
  postId: string;
  content: string;
  author?: PostAuthor;
  createdAt: string;
}

export interface PostCommentListResult {
  items: PostComment[];
  total: number;
  limit: number;
  offset: number;
}

export interface PostLikerListResult {
  items: PostAuthor[];
  total: number;
  limit: number;
  offset: number;
}

export interface UploadedImage {
  url: string;
  width: number;
  height: number;
  mimeType: string;
}

export interface UploadImagesResult {
  images: UploadedImage[];
}

export interface CreatePostRequest {
  content?: string;
  images?: PostImage[];
  checkIn?: PostCheckIn;
  sticker?: string;
  visibility?: PostVisibility;
}

export interface UpdatePostRequest {
  content?: string;
  images?: PostImage[];
  checkIn?: PostCheckIn;
  sticker?: string;
  visibility?: PostVisibility;
}

export interface ReactRequest {
  type: PostReaction;
}

export interface CreateCommentRequest {
  content: string;
}

export type MeNotificationType = 'like' | 'comment' | 'mention';

export interface MeNotification {
  id: string;
  type: MeNotificationType;
  actor?: PostAuthor;
  postId: string;
  commentId?: string;
  preview?: string;
  isRead: boolean;
  createdAt: string;
}

export interface MeNotificationListResult {
  items: MeNotification[];
  unreadCount: number;
  nextCursor: string | null;
}

export interface MeNotificationUnreadResult {
  count: number;
}

export interface FeedParams {
  limit?: number;
  offset?: number;
  filter?: MeFeedFilter;
}

export interface FeedCursorParams {
  limit?: number;
  cursor?: string;
  filter?: MeFeedFilter;
}

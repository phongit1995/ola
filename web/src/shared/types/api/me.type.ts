export type PostVisibility = 'public' | 'private';

export type PostReaction = 'like' | 'dislike';

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
}

export interface Post {
  id: string;
  content?: string;
  images: PostImage[];
  visibility: PostVisibility;
  likeCount: number;
  dislikeCount: number;
  commentCount: number;
  myReaction: PostReaction | null;
  author?: PostAuthor;
  createdAt: string;
  updatedAt: string;
}

export interface PostListResult {
  items: Post[];
  total: number;
  limit: number;
  offset: number;
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
  visibility?: PostVisibility;
}

export interface UpdatePostRequest {
  content?: string;
  images?: PostImage[];
  visibility?: PostVisibility;
}

export interface ReactRequest {
  type: PostReaction;
}

export interface CreateCommentRequest {
  content: string;
}

export interface FeedParams {
  limit?: number;
  offset?: number;
}

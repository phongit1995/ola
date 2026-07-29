import type {
  CreatePostRequest,
  MeFeedFilter,
  Post,
  PostReaction,
} from '../api/me.type';
import type { UploadFile } from './upload.type';

export interface MeFeedState {
  posts: Post[];
  loading: boolean;
  loadingMore: boolean;
  error: boolean;
  nextCursor: string | null;
  reacting: Set<string>;
  refreshing: boolean;
  loadFeed: (filter?: MeFeedFilter) => Promise<void>;
  refreshFeed: (filter?: MeFeedFilter) => Promise<void>;
  loadMore: (filter?: MeFeedFilter) => Promise<void>;
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  createPost: (
    payload: CreatePostRequest,
    files: UploadFile[],
    imageUrls: string[]
  ) => Promise<Post | null>;
  prependPost: (post: Post) => void;
  updatePost: (
    id: string,
    payload: CreatePostRequest,
    files: UploadFile[],
    imageUrls: string[],
    existingImages?: Post['images']
  ) => Promise<Post | null>;
  removePost: (id: string) => Promise<boolean>;
  togglePin: (id: string, pinned: boolean) => Promise<void>;
  adjustCommentCount: (id: string, delta: number) => void;
  syncPost: (post: Post) => void;
}

export type PostsUpdater = (updater: (current: Post[]) => Post[]) => void;

export interface PostListActionsOptions {
  posts: Post[];
  setPosts: PostsUpdater;
  keepOnlyLiked?: boolean;
  reloadAfterPin?: () => Promise<unknown> | void;
}

export interface PostListActions {
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  adjustCommentCount: (id: string, delta: number) => void;
  deletePost: (id: string) => Promise<void>;
  togglePin: (id: string, pinned: boolean) => Promise<void>;
}

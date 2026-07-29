import type { Clan, UpdateClanRequest } from '../api/clan.type';
import type { CreatePostRequest, Post, PostReaction } from '../api/me.type';
import type { UploadFile } from './upload.type';

export interface ClanState {
  myClans: Clan[];
  mineLoading: boolean;
  mineLoaded: boolean;
  current: Clan | null;
  currentLoading: boolean;
  currentError: string | null;
  ensureMine: () => Promise<void>;
  refreshMine: () => Promise<void>;
  loadByHandle: (handle: string) => Promise<Clan | null>;
  loadById: (id: string) => Promise<Clan | null>;
  join: (id: string) => Promise<boolean>;
  leave: (id: string) => Promise<boolean>;
  update: (id: string, payload: UpdateClanRequest) => Promise<Clan | null>;
  setCurrent: (clan: Clan | null) => void;
  reset: () => void;
}

export interface ClanFeedState {
  clanId: string | null;
  pinned: Post | null;
  posts: Post[];
  loading: boolean;
  loadingMore: boolean;
  error: string | null;
  nextCursor: string | null;
  reacting: Set<string>;
  load: (clanId: string) => Promise<void>;
  refresh: (clanId: string) => Promise<void>;
  loadMore: () => Promise<void>;
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  createPost: (
    clanId: string,
    payload: CreatePostRequest,
    files: UploadFile[],
    imageUrls: string[]
  ) => Promise<Post | null>;
  removePost: (id: string) => void;
  removePostsByAuthor: (authorId: string) => void;
  syncPost: (post: Post) => void;
  setPinned: (post: Post | null) => void;
  adjustCommentCount: (id: string, delta: number) => void;
  reset: () => void;
}

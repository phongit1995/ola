import i18n from 'i18next';
import { useEffect } from 'react';
import { create } from 'zustand';
import { FRIEND_CONTENT_SOCKET_EVENT } from '../constants/socket';
import { SocketService } from '../services/socket.service';
import { useMomentStore } from './moment/momentStore';
import type { PostAuthor } from '../types/api/me.type';

export type FriendContentKind = 'post' | 'moment';

export interface FriendContentNotice {
  kind: FriendContentKind;
  contentId: string;
  author: PostAuthor;
  preview?: string;
}

export const FRIEND_CONTENT_BANNER_MS = 5000;

interface FriendContentState {
  notice: FriendContentNotice | null;
  openSeq: number;
  show: (notice: FriendContentNotice) => void;
  dismiss: () => void;
  open: () => void;
}

export const useFriendContentStore = create<FriendContentState>((set, get) => ({
  notice: null,
  openSeq: 0,
  show: (notice) => set({ notice }),
  dismiss: () => set({ notice: null }),
  open: () => {
    const kind = get().notice?.kind;
    set((state) => ({ notice: null, openSeq: state.openSeq + 1 }));
    if (kind === 'moment') void useMomentStore.getState().load();
  },
}));

function isNotice(data: unknown): data is FriendContentNotice {
  const notice = data as FriendContentNotice | null;
  return (
    notice != null &&
    (notice.kind === 'post' || notice.kind === 'moment') &&
    typeof notice.contentId === 'string' &&
    typeof notice.author?.id === 'string'
  );
}

export function useFriendContentRealtime(): void {
  useEffect(
    () =>
      SocketService.on<unknown>(FRIEND_CONTENT_SOCKET_EVENT, (data) => {
        if (isNotice(data)) useFriendContentStore.getState().show(data);
      }),
    []
  );
}

export function useFriendContentNotice(): FriendContentNotice | null {
  const notice = useFriendContentStore((state) => state.notice);
  useEffect(() => {
    if (notice == null) return;
    const timer = setTimeout(() => useFriendContentStore.getState().dismiss(), FRIEND_CONTENT_BANNER_MS);
    return () => clearTimeout(timer);
  }, [notice]);
  return notice;
}

export function friendContentName(notice: FriendContentNotice): string {
  return notice.author.fullName || notice.author.username;
}

export function friendContentLabel(kind: FriendContentKind): string {
  return kind === 'moment' ? i18n.t('friendContent.moment') : i18n.t('friendContent.post');
}

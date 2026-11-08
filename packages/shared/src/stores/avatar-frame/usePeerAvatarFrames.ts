import { useCallback, useEffect, useState } from 'react';
import { AVATAR_FRAME_STORE_PAGE_SIZE } from '../../constants/avatarFrame';
import { isAvatarFramePrivateStoreError } from '../../lib/avatarFrameErrors';
import { AvatarFrameService } from '../../services/avatarFrame.service';
import type { AvatarFrameStoreResult } from '../../types/api/avatarFrame.type';
import { mergeAvatarFramePage } from './mergeAvatarFramePage';

export interface PeerAvatarFramesState {
  store: AvatarFrameStoreResult | null;
  loading: boolean;
  loadingMore: boolean;
  isPrivate: boolean;
  failed: boolean;
  hasMore: boolean;
  loadMore: () => Promise<void>;
}

interface PeerFetchState {
  store: AvatarFrameStoreResult | null;
  loading: boolean;
  isPrivate: boolean;
  failed: boolean;
}

const INITIAL_STATE: PeerFetchState = { store: null, loading: false, isPrivate: false, failed: false };

export function usePeerAvatarFrames(userId: string, enabled: boolean): PeerAvatarFramesState {
  const [state, setState] = useState<PeerFetchState>(INITIAL_STATE);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    if (!enabled || userId === '') return;
    let cancelled = false;
    setState({ ...INITIAL_STATE, loading: true });
    AvatarFrameService.peerStore(userId, { limit: AVATAR_FRAME_STORE_PAGE_SIZE, offset: 0 })
      .then((store) => {
        if (!cancelled) setState({ store, loading: false, isPrivate: false, failed: false });
      })
      .catch((error: unknown) => {
        if (cancelled) return;
        const isPrivate = isAvatarFramePrivateStoreError(error);
        setState({ store: null, loading: false, isPrivate, failed: !isPrivate });
      });
    return () => {
      cancelled = true;
    };
  }, [userId, enabled]);

  const { store } = state;
  const hasMore = store != null && store.items.length < store.total;

  const loadMore = useCallback(async () => {
    if (store == null || loadingMore || store.items.length >= store.total) return;
    setLoadingMore(true);
    try {
      const next = await AvatarFrameService.peerStore(userId, {
        limit: AVATAR_FRAME_STORE_PAGE_SIZE,
        offset: store.items.length,
      });
      setState((prev) =>
        prev.store ? { ...prev, store: mergeAvatarFramePage(prev.store, next) } : prev,
      );
    } finally {
      setLoadingMore(false);
    }
  }, [store, loadingMore, userId]);

  return { ...state, loadingMore, hasMore, loadMore };
}

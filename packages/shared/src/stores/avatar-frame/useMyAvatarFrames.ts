import { useCallback, useEffect, useRef, useState } from 'react';
import { AVATAR_FRAME_STORE_PAGE_SIZE } from '../../constants/avatarFrame';
import { AvatarFrameService } from '../../services/avatarFrame.service';
import type { AvatarFramePrivacy, AvatarFrameStoreResult } from '../../types/api/avatarFrame.type';
import { useAuthStore } from '../auth/authStore';
import { mergeAvatarFramePage } from './mergeAvatarFramePage';

export interface MyAvatarFramesState {
  store: AvatarFrameStoreResult | null;
  loading: boolean;
  loadingMore: boolean;
  failed: boolean;
  busy: boolean;
  hasMore: boolean;
  reload: () => Promise<void>;
  loadMore: () => Promise<void>;
  equip: (frameId: string | null) => Promise<void>;
  transfer: (frameId: string, toUserId: string, password: string) => Promise<void>;
  setPrivacy: (privacy: AvatarFramePrivacy) => Promise<void>;
}

export function useMyAvatarFrames(): MyAvatarFramesState {
  const [store, setStore] = useState<AvatarFrameStoreResult | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [failed, setFailed] = useState(false);
  const [busy, setBusy] = useState(false);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime);
  const dataVersion = useRef(0);

  const reload = useCallback(async () => {
    dataVersion.current += 1;
    const version = dataVersion.current;
    setLoading(true);
    try {
      const result = await AvatarFrameService.myStore({ limit: AVATAR_FRAME_STORE_PAGE_SIZE, offset: 0 });
      if (version !== dataVersion.current) return;
      setStore(result);
      setFailed(false);
    } catch {
      if (version === dataVersion.current) setFailed(true);
    } finally {
      if (version === dataVersion.current) setLoading(false);
    }
  }, []);

  useEffect(() => {
    void reload();
  }, [reload, vipEndTime]);

  const hasMore = store != null && store.items.length < store.total;

  const loadMore = useCallback(async () => {
    if (store == null || loadingMore || store.items.length >= store.total) return;
    const version = dataVersion.current;
    setLoadingMore(true);
    try {
      const next = await AvatarFrameService.myStore({
        limit: AVATAR_FRAME_STORE_PAGE_SIZE,
        offset: store.items.length,
      });
      if (version !== dataVersion.current) return;
      setStore((prev) => (prev ? mergeAvatarFramePage(prev, next) : next));
    } finally {
      setLoadingMore(false);
    }
  }, [store, loadingMore]);

  const runAndReload = useCallback(
    async (action: () => Promise<unknown>, refreshProfile: boolean) => {
      setBusy(true);
      try {
        await action();
        await reload();
        if (refreshProfile) await useAuthStore.getState().refreshUser();
      } finally {
        setBusy(false);
      }
    },
    [reload],
  );

  const equip = useCallback(
    (frameId: string | null) => runAndReload(() => AvatarFrameService.equip(frameId), true),
    [runAndReload],
  );

  const transfer = useCallback(
    (frameId: string, toUserId: string, password: string) =>
      runAndReload(() => AvatarFrameService.transfer(frameId, toUserId, password), false),
    [runAndReload],
  );

  const setPrivacy = useCallback(
    (privacy: AvatarFramePrivacy) => runAndReload(() => AvatarFrameService.setPrivacy(privacy), false),
    [runAndReload],
  );

  return { store, loading, loadingMore, failed, busy, hasMore, reload, loadMore, equip, transfer, setPrivacy };
}

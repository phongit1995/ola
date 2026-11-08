import { useCallback, useEffect, useRef, useState } from 'react';
import { AVATAR_FRAME_HISTORY_PAGE_SIZE } from '../../constants/avatarFrame';
import { AvatarFrameService } from '../../services/avatarFrame.service';
import type {
  AvatarFrameHistoryTab,
  AvatarFramePurchaseItem,
  AvatarFrameTransferItem,
} from '../../types/api/avatarFrame.type';

export interface AvatarFrameHistoryState {
  purchases: AvatarFramePurchaseItem[];
  transfers: AvatarFrameTransferItem[];
  loading: boolean;
  hasMore: boolean;
  loadMore: () => Promise<void>;
}

export function useAvatarFrameHistory(tab: AvatarFrameHistoryTab, enabled: boolean): AvatarFrameHistoryState {
  const [purchases, setPurchases] = useState<AvatarFramePurchaseItem[]>([]);
  const [transfers, setTransfers] = useState<AvatarFrameTransferItem[]>([]);
  const [purchaseTotal, setPurchaseTotal] = useState(0);
  const [transferTotal, setTransferTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const latestRequest = useRef(0);

  const fetchPage = useCallback(
    async (offset: number) => {
      latestRequest.current += 1;
      const requestId = latestRequest.current;
      const params = { limit: AVATAR_FRAME_HISTORY_PAGE_SIZE, offset };
      setLoading(true);
      try {
        if (tab === 'purchases') {
          const page = await AvatarFrameService.history(params);
          if (requestId !== latestRequest.current) return;
          setPurchases((prev) => (offset === 0 ? page.items : [...prev, ...page.items]));
          setPurchaseTotal(page.total);
        } else {
          const page = await AvatarFrameService.transfers(params);
          if (requestId !== latestRequest.current) return;
          setTransfers((prev) => (offset === 0 ? page.items : [...prev, ...page.items]));
          setTransferTotal(page.total);
        }
      } finally {
        if (requestId === latestRequest.current) setLoading(false);
      }
    },
    [tab],
  );

  useEffect(() => {
    if (enabled) void fetchPage(0).catch(() => undefined);
  }, [enabled, fetchPage]);

  const loaded = tab === 'purchases' ? purchases.length : transfers.length;
  const hasMore = loaded < (tab === 'purchases' ? purchaseTotal : transferTotal);

  const loadMore = useCallback(async () => {
    if (loading || !hasMore) return;
    await fetchPage(loaded);
  }, [fetchPage, hasMore, loaded, loading]);

  return { purchases, transfers, loading, hasMore, loadMore };
}

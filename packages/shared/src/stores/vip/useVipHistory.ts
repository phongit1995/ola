import { useCallback, useEffect, useState } from 'react';
import type { VipHistoryTab } from '../../lib/vipHistory';
import { VipService } from '../../services/vip.service';
import type { VipPurchaseHistoryItem, VipTransferHistoryItem } from '../../types/api/vip.type';

const VIP_HISTORY_PAGE_SIZE = 20;

export function useVipHistory(open: boolean) {
  const [tab, setTab] = useState<VipHistoryTab>('purchases');
  const [purchases, setPurchases] = useState<VipPurchaseHistoryItem[]>([]);
  const [transfers, setTransfers] = useState<VipTransferHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  const loadPage = useCallback(async (offset: number, target: VipHistoryTab) => {
    setLoading(true);
    setError(false);
    if (offset === 0) {
      setPurchases([]);
      setTransfers([]);
      setTotal(0);
    }
    try {
      if (target === 'purchases') {
        const result = await VipService.getHistory({ limit: VIP_HISTORY_PAGE_SIZE, offset });
        setTotal(result.total);
        setPurchases((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
      } else {
        const result = await VipService.getTransfers({ limit: VIP_HISTORY_PAGE_SIZE, offset });
        setTotal(result.total);
        setTransfers((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
      }
    } catch {
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    if (!open) return;
    void loadPage(0, tab);
  }, [open, tab, loadPage]);

  const items: Array<VipPurchaseHistoryItem | VipTransferHistoryItem> =
    tab === 'purchases' ? purchases : transfers;

  return {
    tab,
    setTab,
    purchases,
    transfers,
    items,
    loading,
    error,
    hasMore: items.length < total,
    loadMore: () => void loadPage(items.length, tab),
  };
}

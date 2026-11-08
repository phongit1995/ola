import { useCallback, useEffect, useState } from 'react';
import { AVATAR_FRAME_ERROR_CODE } from '../../constants/avatarFrame';
import { toApiError } from '../../lib/apiError';
import { AvatarFrameService } from '../../services/avatarFrame.service';
import type {
  AvatarFrameShopItem,
  BuyAvatarFrameResult,
  GiftAvatarFrameResult,
} from '../../types/api/avatarFrame.type';
import { setAuthUserKen } from '../auth/authStore';

export interface AvatarFrameShopState {
  items: AvatarFrameShopItem[];
  loading: boolean;
  failed: boolean;
  busyItemId: string | null;
  reload: () => Promise<void>;
  buy: (item: AvatarFrameShopItem) => Promise<BuyAvatarFrameResult>;
  gift: (item: AvatarFrameShopItem, toUsername: string, password: string) => Promise<GiftAvatarFrameResult>;
}

export function useAvatarFrameShop(): AvatarFrameShopState {
  const [items, setItems] = useState<AvatarFrameShopItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [failed, setFailed] = useState(false);
  const [busyItemId, setBusyItemId] = useState<string | null>(null);

  const reload = useCallback(async () => {
    setLoading(true);
    try {
      const result = await AvatarFrameService.shop();
      setItems(result.items);
      setFailed(false);
    } catch {
      setFailed(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    void reload();
  }, [reload]);

  const reloadIfPriceChanged = useCallback(
    (error: unknown) => {
      if (toApiError(error).code === AVATAR_FRAME_ERROR_CODE.priceChanged) void reload();
    },
    [reload],
  );

  const buy = useCallback(
    async (item: AvatarFrameShopItem) => {
      setBusyItemId(item.id);
      try {
        const result = await AvatarFrameService.buy(item.id, item.kenPrice);
        setAuthUserKen(result.kenBalance);
        setItems((prev) => prev.map((it) => (it.id === item.id ? { ...it, owned: true } : it)));
        return result;
      } catch (error) {
        reloadIfPriceChanged(error);
        throw error;
      } finally {
        setBusyItemId(null);
      }
    },
    [reloadIfPriceChanged],
  );

  const gift = useCallback(
    async (item: AvatarFrameShopItem, toUsername: string, password: string) => {
      setBusyItemId(item.id);
      try {
        const result = await AvatarFrameService.gift(item.id, item.kenPrice, toUsername.trim(), password);
        setAuthUserKen(result.kenBalance);
        return result;
      } catch (error) {
        reloadIfPriceChanged(error);
        throw error;
      } finally {
        setBusyItemId(null);
      }
    },
    [reloadIfPriceChanged],
  );

  return { items, loading, failed, busyItemId, reload, buy, gift };
}

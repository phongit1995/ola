import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScrollView, Text, View, type NativeSyntheticEvent, type NativeScrollEvent } from 'react-native';
import { VipService } from '@ola/shared/services';
import { ApiError, vipName } from '@ola/shared/lib';
import type { VipIconInstance } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { PRIMARY, TEXT_SECONDARY } from '@constants';
import { PEER_VIP_PAGE_SIZE } from '../constants';

type LoadState = 'loading' | 'private' | 'error' | 'ready';

interface PeerVipStoreDialogProps {
  userId: string;
  name: string;
  onClose: () => void;
}

export function PeerVipStoreDialog({ userId, name, onClose }: PeerVipStoreDialogProps) {
  const { t } = useTranslation();
  const [items, setItems] = useState<VipIconInstance[]>([]);
  const [total, setTotal] = useState(0);
  const [state, setState] = useState<LoadState>('loading');
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    let active = true;
    VipService.userStore(userId, { limit: PEER_VIP_PAGE_SIZE, offset: 0 })
      .then((res) => {
        if (!active) return;
        setItems(res.items);
        setTotal(res.total);
        setState('ready');
      })
      .catch((err) => {
        if (!active) return;
        setState(err instanceof ApiError && err.status === 403 ? 'private' : 'error');
      });
    return () => {
      active = false;
    };
  }, [userId]);

  const hasMore = items.length < total;

  function loadMore() {
    if (loadingMore || !hasMore) return;
    setLoadingMore(true);
    VipService.userStore(userId, { limit: PEER_VIP_PAGE_SIZE, offset: items.length })
      .then((res) => setItems((prev) => [...prev, ...res.items]))
      .catch(() => {})
      .finally(() => setLoadingMore(false));
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    if (contentSize.height - contentOffset.y - layoutMeasurement.height > 200) return;
    loadMore();
  }

  return (
    <Dialog visible onClose={onClose} showClose title={t('vip.storeOf', { name })}>
      <View style={{ minHeight: 120, maxHeight: 360 }}>
        {state === 'loading' ? (
          <View className="items-center justify-center" style={{ height: 112 }}>
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('common.loading')}</Text>
          </View>
        ) : state === 'private' ? (
          <View className="items-center justify-center px-4" style={{ height: 112 }}>
            <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>{t('vip.storePrivate')}</Text>
          </View>
        ) : state === 'error' ? (
          <View className="items-center justify-center" style={{ height: 112 }}>
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('common.error')}</Text>
          </View>
        ) : (
          <ScrollView onScroll={handleScroll} scrollEventThrottle={16}>
            <Text className="mb-1 text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('vip.collection')} ({total})
            </Text>
            {items.length === 0 ? (
              <View className="items-center justify-center" style={{ height: 80 }}>
                <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('vip.empty')}</Text>
              </View>
            ) : (
              <View className="flex-row flex-wrap">
                {items.map((icon) => (
                  <View
                    key={icon.instanceId}
                    className="items-center"
                    style={{ width: '25%', paddingVertical: 4 }}
                  >
                    <View
                      style={{
                        padding: 2,
                        borderRadius: 6,
                        borderWidth: icon.isUsing ? 2 : 0,
                        borderColor: icon.isUsing ? PRIMARY : 'transparent',
                      }}
                    >
                      <VipIconImage typeId={icon.typeId} size={44} rounded />
                    </View>
                    <Text
                      numberOfLines={1}
                      className="w-full text-center text-[11px]"
                      style={{
                        marginTop: 2,
                        color: icon.isUsing ? PRIMARY : TEXT_SECONDARY,
                        fontWeight: icon.isUsing ? '700' : '400',
                      }}
                    >
                      {vipName(icon.typeId)}
                    </Text>
                  </View>
                ))}
              </View>
            )}
            {loadingMore && (
              <View className="items-center justify-center" style={{ height: 40 }}>
                <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{t('common.loading')}</Text>
              </View>
            )}
          </ScrollView>
        )}
      </View>
    </Dialog>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import { formatKen, isVipActive } from '@lib';
import type { AvatarFrameShopItem } from '@app-types';
import { useAvatarFrameShop } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import { useAuthStore } from '@/store/authStore';
import { AvatarFrameShopItemDialog } from './components/AvatarFrameShopItemDialog';
import { AvatarFrameTile } from './components/AvatarFrameTile';
import { VipRequiredHint } from './components/VipRequiredHint';

export function AvatarFrameShopPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const ken = useAuthStore((s) => s.user?.ken ?? 0);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime);
  const { items, loading, failed, busyItemId, reload, buy, gift } =
    useAvatarFrameShop();
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const selected: AvatarFrameShopItem | undefined = items.find(
    (item) => item.id === selectedId
  );
  const vipActive = isVipActive(vipEndTime);

  function renderContent() {
    if (loading && items.length === 0) {
      return (
        <div className="flex justify-center py-10">
          <Spinner size={24} />
        </div>
      );
    }
    if (failed && items.length === 0) {
      return (
        <button
          type="button"
          onClick={() => void reload()}
          className="w-full py-16 text-center text-sm text-black/54"
        >
          {t('common.error')}
        </button>
      );
    }
    if (items.length === 0) {
      return (
        <div className="py-16 text-center text-sm text-black/54">
          {t('avatarFrame.shopEmpty')}
        </div>
      );
    }
    return (
      <div className="grid grid-cols-3 gap-2 p-2">
        {items.map((item) => (
          <AvatarFrameTile
            key={item.id}
            frameId={item.frameId}
            subtitle={t('avatarFrame.price', {
              price: formatKen(item.kenPrice),
            })}
            badge={item.owned ? t('avatarFrame.owned') : undefined}
            onClick={() => setSelectedId(item.id)}
          />
        ))}
      </div>
    );
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('avatarFrame.shopTitle')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-ola-surface">
        <div className="flex items-center bg-white px-4 py-3">
          <span className="text-sm text-black/54">{t('vip.buy.balance')}</span>
          <span className="ml-2 text-lg font-bold text-ola-primary-ink">
            {t('avatarFrame.price', { price: formatKen(ken) })}
          </span>
        </div>
        {!vipActive && <VipRequiredHint />}
        {renderContent()}
      </div>

      {selected != null && (
        <AvatarFrameShopItemDialog
          key={selected.id}
          item={selected}
          busy={busyItemId === selected.id}
          buy={buy}
          gift={gift}
          onClose={() => setSelectedId(null)}
        />
      )}
    </FullScreenOverlay>
  );
}

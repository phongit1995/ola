import { useTranslation } from 'react-i18next';
import { useAppOverlayStore } from '@/store/appOverlayStore';

export function VipRequiredHint() {
  const { t } = useTranslation();
  const pushOverlay = useAppOverlayStore((s) => s.push);
  return (
    <div className="flex items-center gap-2 bg-ola-primary-light px-4 py-2">
      <span className="min-w-0 flex-1 text-sm text-black/70">
        {t('avatarFrame.vipRequiredHint')}
      </span>
      <button
        type="button"
        onClick={() => pushOverlay('vipBuy', 'extend')}
        className="shrink-0 rounded border border-ola-primary-dark bg-ola-button px-3 py-1 text-sm font-medium text-ola-on-primary active:opacity-90"
      >
        {t('avatarFrame.buyVip')}
      </button>
    </div>
  );
}

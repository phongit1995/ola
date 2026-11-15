import { useTranslation } from 'react-i18next';
import { socialLimitMessage, useSocialLimitStore } from '@ola/shared/stores/socialLimit';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useClanOverlayStore } from '@/store/clanOverlayStore';
import { ConfirmDialog } from './ui/ConfirmDialog';

export function SocialLimitDialog() {
  const { t } = useTranslation();
  const notice = useSocialLimitStore((state) => state.notice);
  const close = useSocialLimitStore((state) => state.close);
  const requestBuy = useSocialLimitStore((state) => state.requestBuy);

  if (notice == null) return null;
  const canBuy = !notice.isVip;

  function buyVip() {
    requestBuy();
    useClanOverlayStore.getState().reset();
    useAppOverlayStore.getState().push('vip');
  }

  return (
    <ConfirmDialog
      open
      title={t('socialLimit.title')}
      message={socialLimitMessage(notice)}
      confirmLabel={canBuy ? t('socialLimit.buyVip') : t('socialLimit.confirm')}
      cancelLabel={t('socialLimit.confirm')}
      hideCancel={!canBuy}
      onConfirm={canBuy ? buyVip : close}
      onCancel={close}
    />
  );
}

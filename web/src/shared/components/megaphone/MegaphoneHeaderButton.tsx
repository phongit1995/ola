import { useTranslation } from 'react-i18next';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { MegaphoneIcon } from './MegaphoneIcon';

export function MegaphoneHeaderButton() {
  const { t } = useTranslation();
  const openOverlay = useAppOverlayStore((s) => s.push);

  return (
    <button
      type="button"
      aria-label={t('megaphone.open')}
      onClick={() => openOverlay('megaphone')}
      className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full hover:bg-white/15"
    >
      <MegaphoneIcon />
    </button>
  );
}

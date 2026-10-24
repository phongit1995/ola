import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { ReelTray } from './components/ReelTray';

export function ReelGalleryView({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('reel.trayTitle')} onBack={onClose} />
      <div className="min-h-0 flex-1 overflow-y-auto bg-ola-surface">
        <ReelTray layout="grid" />
      </div>
    </FullScreenOverlay>
  );
}

import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { DownloadGuideContent } from './DownloadGuideContent';

export function DownloadGuideOverlay({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();

  return (
    <FullScreenOverlay z={50}>
      <ScreenHeader title={t('download.title')} align="center" onBack={onClose} />
      <div className="flex-1 overflow-y-auto px-4 pt-4 pb-8">
        <p className="pb-3.5 text-center text-[13px] leading-relaxed text-black/55">
          {t('download.subtitle')}
        </p>
        <DownloadGuideContent />
      </div>
    </FullScreenOverlay>
  );
}

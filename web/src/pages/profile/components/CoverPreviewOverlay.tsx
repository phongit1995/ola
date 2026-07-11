import { useTranslation } from 'react-i18next';
import { FullScreenOverlay } from '@components';

interface CoverPreviewOverlayProps {
  url: string;
  uploading: boolean;
  onCancel: () => void;
  onConfirm: () => void;
}

export function CoverPreviewOverlay({ url, uploading, onCancel, onConfirm }: CoverPreviewOverlayProps) {
  const { t } = useTranslation();

  return (
    <FullScreenOverlay z={50}>
      <div className="flex h-full w-full flex-col bg-black">
        <header className="flex h-12 shrink-0 items-center justify-center text-white">
          <span className="text-lg font-medium">{t('profileEdit.coverPreviewTitle')}</span>
        </header>

        <div className="flex min-h-0 flex-1 items-center justify-center p-4">
          <img src={url} alt="" className="max-h-full max-w-full object-contain" />
        </div>

        <footer className="flex shrink-0 gap-3 p-4 pb-[max(1rem,env(safe-area-inset-bottom))]">
          <button
            type="button"
            onClick={onCancel}
            disabled={uploading}
            className="h-11 flex-1 rounded-full bg-white/15 text-base font-medium text-white disabled:opacity-60"
          >
            {t('dialog.cancel')}
          </button>
          <button
            type="button"
            onClick={onConfirm}
            disabled={uploading}
            className="h-11 flex-1 rounded-full bg-ola-primary text-base font-bold text-white disabled:opacity-60"
          >
            {uploading ? t('common.loading') : t('profileEdit.coverConfirm')}
          </button>
        </footer>
      </div>
    </FullScreenOverlay>
  );
}

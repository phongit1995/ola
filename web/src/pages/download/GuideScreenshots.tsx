import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay } from '@components';
import { CloseIcon } from './platformIcons';

interface Screenshot {
  src: string;
  label: string;
}

export function GuideScreenshots({ shots }: { shots: Screenshot[] }) {
  const { t } = useTranslation();
  const [preview, setPreview] = useState<Screenshot | null>(null);

  return (
    <div className="mt-4">
      <p className="pb-2 text-[13px] font-semibold text-black/70">
        {t('download.screenshotsTitle')}
      </p>
      <div className="-mx-4 flex gap-2.5 overflow-x-auto px-4 pb-1">
        {shots.map((shot) => (
          <button
            key={shot.src}
            type="button"
            onClick={() => setPreview(shot)}
            className="shrink-0"
          >
            <img
              src={shot.src}
              alt={shot.label}
              loading="lazy"
              className="h-48 w-auto rounded-lg border border-black/10 object-contain"
            />
            <span className="mt-1 block text-center text-[11px] text-black/45">
              {shot.label}
            </span>
          </button>
        ))}
      </div>

      {preview != null && (
        <FullScreenOverlay z={60}>
          <div className="flex h-full flex-col bg-black">
            <header className="flex h-12 shrink-0 items-center justify-between px-3 text-white">
              <span className="text-sm font-medium">{preview.label}</span>
              <button
                type="button"
                aria-label={t('download.closePreview')}
                onClick={() => setPreview(null)}
                className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
              >
                <CloseIcon className="h-5 w-5" />
              </button>
            </header>
            <div className="flex min-h-0 flex-1 items-center justify-center p-4">
              <img
                src={preview.src}
                alt={preview.label}
                className="max-h-full max-w-full object-contain"
              />
            </div>
          </div>
        </FullScreenOverlay>
      )}
    </div>
  );
}

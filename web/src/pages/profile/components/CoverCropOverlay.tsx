import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import Cropper from 'react-easy-crop';
import type { Area, Point } from 'react-easy-crop';
import { FullScreenOverlay } from '@components';
import { getCroppedImageFile, toast } from '@lib';

interface CoverCropOverlayProps {
  src: string;
  aspect: number;
  busy?: boolean;
  onCancel: () => void;
  onApply: (file: File) => void | Promise<void>;
}

export function CoverCropOverlay({ src, aspect, busy, onCancel, onApply }: CoverCropOverlayProps) {
  const { t } = useTranslation();
  const [crop, setCrop] = useState<Point>({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [area, setArea] = useState<Area | null>(null);
  const [processing, setProcessing] = useState(false);

  const onCropComplete = useCallback((_: Area, pixels: Area) => setArea(pixels), []);

  const working = processing || (busy ?? false);

  async function apply() {
    if (!area || working) return;
    setProcessing(true);
    try {
      const file = await getCroppedImageFile(src, area);
      await onApply(file);
    } catch {
      toast.error(t('profileEdit.coverError'));
    } finally {
      setProcessing(false);
    }
  }

  return (
    <FullScreenOverlay z={50}>
      <div className="flex h-full w-full flex-col bg-black">
        <header className="flex h-12 shrink-0 items-center justify-between px-4 text-white">
          <button
            type="button"
            onClick={onCancel}
            disabled={working}
            className="text-base disabled:opacity-50"
          >
            {t('dialog.cancel')}
          </button>
          <button
            type="button"
            onClick={apply}
            disabled={working || area == null}
            className="text-base font-bold disabled:opacity-50"
          >
            {working ? t('common.loading') : t('profileEdit.coverApply')}
          </button>
        </header>

        <div className="relative min-h-0 flex-1">
          <Cropper
            image={src}
            crop={crop}
            zoom={zoom}
            aspect={aspect}
            minZoom={1}
            maxZoom={4}
            showGrid
            objectFit="contain"
            onCropChange={setCrop}
            onZoomChange={setZoom}
            onCropComplete={onCropComplete}
          />
        </div>

        <footer className="flex h-16 shrink-0 items-center px-6 pb-[max(0px,env(safe-area-inset-bottom))]">
          <input
            type="range"
            min={1}
            max={4}
            step={0.01}
            value={zoom}
            onChange={(event) => setZoom(Number(event.target.value))}
            disabled={working}
            aria-label={t('profileEdit.coverZoom')}
            className="w-full accent-ola-primary"
          />
        </footer>
      </div>
    </FullScreenOverlay>
  );
}

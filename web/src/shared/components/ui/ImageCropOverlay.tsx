import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import Cropper from 'react-easy-crop';
import type { Area, Point } from 'react-easy-crop';
import { getCroppedImageFile, toast } from '@lib';
import { FullScreenOverlay } from './FullScreenOverlay';

interface ImageCropOverlayProps {
  src: string;
  aspect: number;
  busy?: boolean;
  onCancel: () => void;
  onApply: (file: File) => void | Promise<void>;
}

function RotateIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-6 w-6"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M15.55 5.55 11 1v3.07C7.06 4.56 4 7.92 4 12s3.05 7.44 7 7.93v-2.02c-2.84-.48-5-2.94-5-5.91s2.16-5.43 5-5.91V10l4.55-4.45zM19.93 11c-.17-1.39-.72-2.73-1.62-3.89l-1.42 1.42c.54.75.88 1.6 1.02 2.47h2.02zM13 17.9v2.02c1.39-.17 2.74-.71 3.9-1.61l-1.44-1.44c-.75.54-1.59.89-2.46 1.03zm3.89-2.42 1.42 1.41c.9-1.16 1.45-2.5 1.62-3.89h-2.02c-.14.87-.48 1.72-1.02 2.48z" />
    </svg>
  );
}

export function ImageCropOverlay({
  src,
  aspect,
  busy,
  onCancel,
  onApply,
}: ImageCropOverlayProps) {
  const { t } = useTranslation();
  const [crop, setCrop] = useState<Point>({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [rotation, setRotation] = useState(0);
  const [area, setArea] = useState<Area | null>(null);
  const [processing, setProcessing] = useState(false);

  const onCropComplete = useCallback(
    (_: Area, pixels: Area) => setArea(pixels),
    []
  );

  const working = processing || (busy ?? false);

  async function apply() {
    if (!area || working) return;
    setProcessing(true);
    try {
      const file = await getCroppedImageFile(src, area, rotation);
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
            rotation={rotation}
            aspect={aspect}
            minZoom={1}
            maxZoom={4}
            showGrid
            objectFit="contain"
            onCropChange={setCrop}
            onZoomChange={setZoom}
            onRotationChange={setRotation}
            onCropComplete={onCropComplete}
          />
        </div>

        <footer className="flex h-16 shrink-0 items-center justify-center pb-[max(0px,env(safe-area-inset-bottom))]">
          <button
            type="button"
            onClick={() => setRotation((value) => (value + 90) % 360)}
            disabled={working}
            aria-label={t('profileEdit.coverRotate')}
            className="flex h-11 w-11 items-center justify-center rounded-full bg-white/15 text-white disabled:opacity-50"
          >
            <RotateIcon />
          </button>
        </footer>
      </div>
    </FullScreenOverlay>
  );
}

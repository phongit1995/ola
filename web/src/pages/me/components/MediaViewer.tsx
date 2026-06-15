import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { TransformWrapper, TransformComponent } from 'react-zoom-pan-pinch';

interface MediaViewerProps {
  photos: string[];
  index: number;
  onClose: () => void;
}

function fileNameFromUrl(url: string): string {
  try {
    const path = new URL(url, window.location.href).pathname;
    const name = path.split('/').pop();
    return name && name.length > 0 ? name : 'image';
  } catch {
    return 'image';
  }
}

async function downloadImage(url: string) {
  try {
    const res = await fetch(url, { mode: 'cors' });
    if (!res.ok) throw new Error('fetch failed');
    const blob = await res.blob();
    const objectUrl = URL.createObjectURL(blob);
    const anchor = document.createElement('a');
    anchor.href = objectUrl;
    anchor.download = fileNameFromUrl(url);
    document.body.appendChild(anchor);
    anchor.click();
    anchor.remove();
    URL.revokeObjectURL(objectUrl);
  } catch {
    window.open(url, '_blank', 'noopener');
  }
}

export function MediaViewer({ photos, index, onClose }: MediaViewerProps) {
  const { t } = useTranslation();
  const [current, setCurrent] = useState(index);

  const hasMany = photos.length > 1;

  const next = useCallback(
    () => setCurrent((c) => (c + 1) % photos.length),
    [photos.length],
  );
  const prev = useCallback(
    () => setCurrent((c) => (c - 1 + photos.length) % photos.length),
    [photos.length],
  );

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
      else if (e.key === 'ArrowRight') next();
      else if (e.key === 'ArrowLeft') prev();
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [next, prev, onClose]);

  const url = photos[current];

  return (
    <div className="fixed inset-0 z-50 bg-black/95">
      <TransformWrapper
        key={current}
        doubleClick={{ mode: 'toggle', step: 2 }}
        wheel={{ step: 0.15 }}
        pinch={{ step: 5 }}
        minScale={1}
        maxScale={6}
        centerZoomedOut
      >
        <TransformComponent
          wrapperStyle={{ width: '100%', height: '100%' }}
          contentStyle={{ width: '100%', height: '100%' }}
        >
          <div className="flex h-screen w-screen items-center justify-center">
            <img
              src={url}
              alt=""
              draggable={false}
              className="max-h-screen max-w-[100vw] object-contain select-none"
            />
          </div>
        </TransformComponent>
      </TransformWrapper>

      <div className="absolute top-0 right-0 left-0 z-10 flex items-center gap-2 p-4 text-white">
        <span className="flex-1 text-sm">
          {hasMany ? `${current + 1} / ${photos.length}` : ''}
        </span>
        <button
          type="button"
          aria-label={t('me.download')}
          onClick={(e) => {
            e.stopPropagation();
            void downloadImage(url);
          }}
          className="rounded-full p-2 hover:bg-white/15"
        >
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M12 3v12m0 0l-4-4m4 4l4-4" strokeLinecap="round" strokeLinejoin="round" />
            <path d="M5 21h14" strokeLinecap="round" />
          </svg>
        </button>
        <button
          type="button"
          aria-label={t('dialog.close')}
          onClick={onClose}
          className="rounded-full p-2 hover:bg-white/15"
        >
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
          </svg>
        </button>
      </div>

      {hasMany && (
        <>
          <button
            type="button"
            aria-label="prev"
            onClick={(e) => {
              e.stopPropagation();
              prev();
            }}
            className="absolute top-1/2 left-2 z-10 -translate-y-1/2 rounded-full bg-white/10 p-2 text-white hover:bg-white/20"
          >
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M15 6l-6 6 6 6" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </button>
          <button
            type="button"
            aria-label="next"
            onClick={(e) => {
              e.stopPropagation();
              next();
            }}
            className="absolute top-1/2 right-2 z-10 -translate-y-1/2 rounded-full bg-white/10 p-2 text-white hover:bg-white/20"
          >
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M9 6l6 6-6 6" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </button>
        </>
      )}
    </div>
  );
}

import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';

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
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/90"
      onClick={onClose}
    >
      <div className="absolute top-0 right-0 left-0 flex items-center gap-2 p-4 text-white">
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

      <img
        src={url}
        alt=""
        onClick={(e) => e.stopPropagation()}
        className="max-h-[85vh] max-w-[92vw] object-contain"
      />

      {hasMany && (
        <>
          <button
            type="button"
            aria-label="prev"
            onClick={(e) => {
              e.stopPropagation();
              prev();
            }}
            className="absolute left-2 rounded-full bg-white/10 p-2 text-white hover:bg-white/20"
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
            className="absolute right-2 rounded-full bg-white/10 p-2 text-white hover:bg-white/20"
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

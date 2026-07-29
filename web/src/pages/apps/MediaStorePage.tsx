import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService } from '@services';
import { ScreenHeader, FullScreenOverlay, Spinner } from '@components';
import type { MePhoto } from '@app-types';
import { useMediaViewerStore } from '@/store/mediaViewerStore';

const PAGE_SIZE = 50;

interface PhotoGroup {
  key: string;
  label: string;
  items: { url: string; index: number }[];
}

function monthKey(iso: string): string {
  const date = new Date(iso);
  return `${date.getFullYear()}-${date.getMonth()}`;
}

function monthLabel(iso: string, language: string): string {
  const date = new Date(iso);
  const text = new Intl.DateTimeFormat(language, {
    month: 'long',
    year: 'numeric',
  }).format(date);
  return text.charAt(0).toUpperCase() + text.slice(1);
}

function groupByMonth(photos: MePhoto[], language: string): PhotoGroup[] {
  const groups: PhotoGroup[] = [];
  photos.forEach((photo, index) => {
    const key = monthKey(photo.createdAt);
    let last = groups[groups.length - 1];
    if (last == null || last.key !== key) {
      last = { key, label: monthLabel(photo.createdAt, language), items: [] };
      groups.push(last);
    }
    last.items.push({ url: photo.url, index });
  });
  return groups;
}

function EmptyIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-14 w-14 text-black/20"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M21 19V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2zM8.5 13.5l2.5 3 3.5-4.5 4.5 6H5l3.5-4.5zM8 9a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
    </svg>
  );
}

function PhotoSkeleton() {
  return (
    <div className="grid grid-cols-3 gap-1 p-2">
      {Array.from({ length: 12 }).map((_, index) => (
        <div
          key={index}
          className="aspect-square animate-pulse rounded-sm bg-black/10"
        />
      ))}
    </div>
  );
}

function PhotoTile({
  url,
  label,
  onOpen,
}: {
  url: string;
  label?: string;
  onOpen: () => void;
}) {
  const [loaded, setLoaded] = useState(false);
  return (
    <button
      type="button"
      onClick={onOpen}
      className="group relative aspect-square overflow-hidden rounded-sm bg-black/5 shadow-sm active:opacity-90"
    >
      <img
        ref={(node) => {
          if (node?.complete) setLoaded(true);
        }}
        src={url}
        alt=""
        loading="lazy"
        decoding="async"
        onLoad={() => setLoaded(true)}
        className={`h-full w-full object-cover transition-[opacity,transform] duration-300 group-hover:scale-105 ${
          loaded ? 'opacity-100' : 'opacity-0'
        }`}
      />
      {label != null && (
        <span className="pointer-events-none absolute inset-x-0 bottom-0 bg-black/45 px-1.5 py-1 text-xs font-medium text-white">
          {label}
        </span>
      )}
    </button>
  );
}

export function MediaStorePage({ onClose }: { onClose: () => void }) {
  const { t, i18n } = useTranslation();
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const [photos, setPhotos] = useState<MePhoto[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(false);
  const [hasMore, setHasMore] = useState(false);
  const offsetRef = useRef(0);
  const loadingRef = useRef(false);
  const sentinelRef = useRef<HTMLDivElement>(null);

  const loadPage = useCallback(async (reset: boolean) => {
    if (loadingRef.current) return;
    loadingRef.current = true;
    const offset = reset ? 0 : offsetRef.current;
    try {
      const result = await MeService.photos({ limit: PAGE_SIZE, offset });
      setPhotos((prev) => (reset ? result.items : [...prev, ...result.items]));
      setTotal(result.total);
      const loaded = offset + result.items.length;
      offsetRef.current = loaded;
      setHasMore(loaded < result.total);
      setError(false);
    } catch {
      setError(true);
      setHasMore(false);
    } finally {
      loadingRef.current = false;
      setLoading(false);
      setLoadingMore(false);
    }
  }, []);

  useEffect(() => {
    loadPage(true);
  }, [loadPage]);

  useEffect(() => {
    const el = sentinelRef.current;
    if (el == null || !hasMore) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0]?.isIntersecting && !loadingRef.current) {
          setLoadingMore(true);
          loadPage(false);
        }
      },
      { rootMargin: '300px' }
    );
    observer.observe(el);
    return () => observer.disconnect();
  }, [hasMore, loadPage, photos.length]);

  const allUrls = useMemo(() => photos.map((photo) => photo.url), [photos]);
  const groups = useMemo(
    () => groupByMonth(photos, i18n.language),
    [photos, i18n.language]
  );
  const hasPhotos = photos.length > 0;

  return (
    <FullScreenOverlay>
      <ScreenHeader
        title={t('media.title')}
        subtitle={hasPhotos ? t('media.count', { count: total }) : undefined}
        onBack={onClose}
      />

      <div className="flex-1 overflow-y-auto bg-[#fafafa]">
        {loading ? (
          <PhotoSkeleton />
        ) : error && !hasPhotos ? (
          <div className="flex h-full items-center justify-center px-8 text-center text-sm text-ola-error">
            {t('common.error')}
          </div>
        ) : !hasPhotos ? (
          <div className="flex h-full flex-col items-center justify-center gap-3 px-8 text-center">
            <EmptyIcon />
            <span className="text-sm text-black/45">{t('media.empty')}</span>
          </div>
        ) : (
          <div className="space-y-3 p-2">
            {groups.map((group) => (
              <div key={group.key} className="grid grid-cols-3 gap-1">
                {group.items.map((item, position) => (
                  <PhotoTile
                    key={`${item.url}-${item.index}`}
                    url={item.url}
                    label={position === 0 ? group.label : undefined}
                    onOpen={() => openViewer(allUrls, item.index)}
                  />
                ))}
              </div>
            ))}
            <div ref={sentinelRef} className="h-1" />
            {loadingMore && (
              <div className="flex items-center justify-center py-2">
                <Spinner size={22} />
              </div>
            )}
          </div>
        )}
      </div>
    </FullScreenOverlay>
  );
}

import {
  useEffect,
  useRef,
  useState,
  type ChangeEvent,
  type TouchEvent,
} from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, ListOptionDialog } from '@components';
import {
  REEL_MAX_IMAGES,
  REEL_MAX_OVERLAYS,
  REEL_MAX_VIDEO_SECONDS,
  REEL_TYPE,
  REEL_VIDEO_ACCEPT,
  REEL_VIDEO_DURATION_TOLERANCE_S,
  REEL_VISIBILITY,
  REEL_VISIBILITY_LABEL,
} from '@constants';
import {
  createReelDraftSlide,
  createReelOverlay,
  hasReelOverlayText,
  isReelVideoFile,
  portalRoot,
  reelPublishError,
  toast,
} from '@lib';
import type { ReelDraftSlide, ReelVisibility } from '@app-types';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import { buildReelUpload } from '../reelUpload';
import { readVideoFile } from '../videoFile';
import { ReelCanvasEditor } from './ReelCanvasEditor';
import { ReelStage } from './ReelCanvas';
import {
  ReelBackgroundPicker,
  ReelModePicker,
  ReelSlideStrip,
  ReelVideoBar,
} from './ReelComposerParts';
import { ReelCloseIcon } from './ReelIcons';

type ComposerMode = 'text' | 'image' | 'video';

function keepTouchInComposer(event: TouchEvent) {
  event.stopPropagation();
}

function releaseSlides(slides: ReelDraftSlide[]) {
  slides.forEach((slide) => {
    if (slide.media) URL.revokeObjectURL(slide.media.url);
  });
}

export function ReelComposer({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const publish = useReelStore((s) => s.publish);
  const [submitting, setSubmitting] = useState(false);
  const [mode, setMode] = useState<ComposerMode | null>(null);
  const [slides, setSlides] = useState<ReelDraftSlide[]>([]);
  const [activeIndex, setActiveIndex] = useState(0);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [visibility, setVisibility] = useState<ReelVisibility>(REEL_VISIBILITY.friend);
  const [visibilityOpen, setVisibilityOpen] = useState(false);
  const [discardOpen, setDiscardOpen] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const videoInputRef = useRef<HTMLInputElement>(null);
  const slidesRef = useRef(slides);

  useEffect(() => {
    slidesRef.current = slides;
  }, [slides]);

  useEffect(() => () => releaseSlides(slidesRef.current), []);

  const active = slides[activeIndex] ?? slides[0];
  const dirty = slides.some((slide) => slide.media != null || hasReelOverlayText(slide));

  function startText() {
    const slide = createReelDraftSlide(null);
    const overlay = createReelOverlay();
    setSlides([{ ...slide, overlays: [overlay] }]);
    setActiveIndex(0);
    setMode('text');
    setEditingId(overlay.id);
  }

  function handleFiles(event: ChangeEvent<HTMLInputElement>) {
    const picked = Array.from(event.target.files ?? []).filter((file) =>
      file.type.startsWith('image/')
    );
    event.target.value = '';
    if (picked.length === 0) return;
    const existing = mode === 'image' ? slides.length : 0;
    const room = REEL_MAX_IMAGES - existing;
    if (picked.length > room) {
      toast.info(t('reel.maxImages', { count: REEL_MAX_IMAGES }));
    }
    const added = picked
      .slice(0, room)
      .map((file) =>
        createReelDraftSlide({ type: REEL_TYPE.image, url: URL.createObjectURL(file), file })
      );
    if (added.length === 0) return;
    if (mode === 'image') {
      setSlides((current) => [...current, ...added]);
    } else {
      releaseSlides(slides);
      setSlides(added);
      setMode('image');
    }
    setActiveIndex(existing);
  }

  async function handleVideoFile(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file == null) return;
    if (!isReelVideoFile(file)) {
      toast.info(t('reel.videoUnsupported'));
      return;
    }
    const url = URL.createObjectURL(file);
    const info = await readVideoFile(url).catch(() => null);
    if (info != null && info.duration > REEL_MAX_VIDEO_SECONDS + REEL_VIDEO_DURATION_TOLERANCE_S) {
      URL.revokeObjectURL(url);
      toast.info(t('reel.videoTooLong', { count: REEL_MAX_VIDEO_SECONDS }));
      return;
    }
    releaseSlides(slidesRef.current);
    setSlides([
      createReelDraftSlide({
        type: REEL_TYPE.video,
        url,
        file,
        posterUrl: info?.posterUrl,
        duration: info?.duration,
        playable: info != null,
      }),
    ]);
    setActiveIndex(0);
    setEditingId(null);
    setMode('video');
  }

  function updateSlide(next: ReelDraftSlide) {
    setSlides((current) =>
      current.map((slide) => (slide.id === next.id ? next : slide))
    );
  }

  function removeSlide(id: string) {
    const target = slides.find((slide) => slide.id === id);
    if (target) releaseSlides([target]);
    const remaining = slides.filter((slide) => slide.id !== id);
    setSlides(remaining);
    setActiveIndex((index) => Math.min(index, Math.max(0, remaining.length - 1)));
    setEditingId(null);
    if (remaining.length === 0) setMode(null);
  }

  function addText() {
    if (active == null) return;
    if (active.overlays.length >= REEL_MAX_OVERLAYS) {
      toast.info(t('reel.maxOverlays', { count: REEL_MAX_OVERLAYS }));
      return;
    }
    const overlay = createReelOverlay();
    updateSlide({ ...active, overlays: [...active.overlays, overlay] });
    setEditingId(overlay.id);
  }

  function requestClose() {
    if (submitting) return;
    if (dirty) setDiscardOpen(true);
    else onClose();
  }

  async function submit() {
    if (submitting) return;
    if (mode === 'text' && !slides.some(hasReelOverlayText)) {
      toast.info(t('reel.emptyText'));
      return;
    }
    setSubmitting(true);
    try {
      const posted = await publish(() =>
        buildReelUpload(
          visibility,
          slides.map((slide) => ({
            media: slide.media,
            background: slide.background,
            overlays: slide.overlays.filter((overlay) => overlay.text.trim() !== ''),
          }))
        )
      );
      if (posted) toast.success(t('reel.posted'));
    } catch (error) {
      const failure = reelPublishError(error);
      toast.error(t(failure.key, failure.params));
      setSubmitting(false);
      return;
    }
    onClose();
  }

  return createPortal(
    <div
      className="fixed inset-0 z-[100] flex flex-col bg-neutral-950 text-white"
      onTouchStart={keepTouchInComposer}
      onTouchMove={keepTouchInComposer}
      onTouchEnd={keepTouchInComposer}
    >
      <header className="flex h-14 shrink-0 items-center gap-2 px-2">
        <button
          type="button"
          aria-label={t('dialog.close')}
          onClick={requestClose}
          className="rounded-full p-2 hover:bg-white/10"
        >
          <ReelCloseIcon />
        </button>
        <h2 className="min-w-0 flex-1 truncate text-base font-semibold">
          {t('reel.createTitle')}
        </h2>
        {mode != null && (
          <>
            <button
              type="button"
              onClick={() => setVisibilityOpen(true)}
              className="rounded-full bg-white/12 px-3 py-1.5 text-sm hover:bg-white/20"
            >
              {t(REEL_VISIBILITY_LABEL[visibility])} ▾
            </button>
            <button
              type="button"
              onClick={() => void submit()}
              disabled={editingId != null || submitting}
              className="rounded-full bg-ola-primary px-4 py-1.5 text-sm font-semibold text-ola-on-primary disabled:opacity-50"
            >
              {t(submitting ? 'reel.posting' : 'reel.post')}
            </button>
          </>
        )}
      </header>

      {mode == null || active == null ? (
        <ReelModePicker
          onPickText={startText}
          onPickImage={() => fileInputRef.current?.click()}
          onPickVideo={() => videoInputRef.current?.click()}
        />
      ) : (
        <>
          <ReelStage className="mx-3">
            <ReelCanvasEditor
              key={active.id}
              slide={active}
              editingId={editingId}
              onChange={updateSlide}
              onEditingChange={setEditingId}
              onAddText={addText}
            />
          </ReelStage>
          <div className="shrink-0 px-3 pt-2 pb-4">
            {mode === 'text' && (
              <ReelBackgroundPicker
                value={active.background}
                onChange={(background) => updateSlide({ ...active, background })}
              />
            )}
            {mode === 'video' && (
              <ReelVideoBar
                duration={active.media?.duration}
                onChange={() => videoInputRef.current?.click()}
              />
            )}
            {mode === 'image' && (
              <ReelSlideStrip
                slides={slides}
                activeIndex={activeIndex}
                onSelect={(index) => {
                  setEditingId(null);
                  setActiveIndex(index);
                }}
                onRemove={removeSlide}
                onAdd={() => fileInputRef.current?.click()}
              />
            )}
          </div>
        </>
      )}

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        hidden
        onChange={handleFiles}
      />
      <input
        ref={videoInputRef}
        type="file"
        accept={REEL_VIDEO_ACCEPT}
        hidden
        onChange={(event) => void handleVideoFile(event)}
      />

      <ListOptionDialog
        open={visibilityOpen}
        title={t('reel.visibilityTitle')}
        options={Object.values(REEL_VISIBILITY).map((value) => ({
          key: value,
          label: t(REEL_VISIBILITY_LABEL[value]),
          onSelect: () => setVisibility(value),
        }))}
        onClose={() => setVisibilityOpen(false)}
      />
      <ConfirmDialog
        open={discardOpen}
        title={t('reel.discardTitle')}
        message={t('reel.discardMessage')}
        confirmLabel={t('reel.discard')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          setDiscardOpen(false);
          onClose();
        }}
        onCancel={() => setDiscardOpen(false)}
      />
    </div>,
    portalRoot()
  );
}

import {
  useEffect,
  useRef,
  useState,
  type ChangeEvent,
  type TouchEvent,
} from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, FullScreenOverlay, ScreenHeader } from '@components';
import {
  DEFAULT_MOMENT_VISIBILITY,
  MOMENT_MAX_OVERLAYS,
  MOMENT_MAX_SLIDES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_TYPE,
  MOMENT_VIDEO_ACCEPT,
  MOMENT_VIDEO_DURATION_TOLERANCE_S,
  MOMENT_VISIBILITY,
  MOMENT_VISIBILITY_LABEL,
} from '@constants';
import {
  createBlankMomentSlide,
  createMomentDraftSlide,
  createMomentOverlay,
  fillMomentSlidePhotos,
  hasMomentOverlayText,
  isMomentVideoFile,
  momentPhotoRoom,
  momentSlideIssue,
  portalRoot,
  momentPublishError,
  toast,
} from '@lib';
import type { MomentDraftSlide, MomentVisibility } from '@app-types';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentVideoLocked } from '@ola/shared/stores/moment/momentConfigStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { buildMomentUpload } from '../momentUpload';
import { readVideoFile } from '../videoFile';
import { MomentCanvasEditor } from './MomentCanvasEditor';
import { MomentCanvas, MomentStage } from './MomentCanvas';
import {
  MomentModePicker,
  MomentPhotoBar,
  MomentSlideChoice,
  MomentSlideStrip,
  MomentVideoBar,
} from './MomentComposerParts';

type ComposerMode = 'slides' | 'video';

const BLANK_SLIDE_BACKGROUND = 'ink';

function keepTouchInComposer(event: TouchEvent) {
  event.stopPropagation();
}

function releaseSlides(slides: MomentDraftSlide[]) {
  slides.forEach((slide) => {
    if (slide.media) URL.revokeObjectURL(slide.media.url);
  });
}

export function MomentComposer({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const publish = useMomentStore((s) => s.publish);
  const [submitting, setSubmitting] = useState(false);
  const [mode, setMode] = useState<ComposerMode | null>(null);
  const [slides, setSlides] = useState<MomentDraftSlide[]>([]);
  const [activeIndex, setActiveIndex] = useState(0);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [visibility, setVisibility] = useState<MomentVisibility>(
    DEFAULT_MOMENT_VISIBILITY
  );
  const [discardOpen, setDiscardOpen] = useState(false);
  const [vipPromptOpen, setVipPromptOpen] = useState(false);
  const videoLocked = useMomentVideoLocked();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const videoInputRef = useRef<HTMLInputElement>(null);
  const slidesRef = useRef(slides);

  useEffect(() => {
    slidesRef.current = slides;
  }, [slides]);

  useEffect(() => () => releaseSlides(slidesRef.current), []);

  const active = slides[activeIndex] ?? slides[0];
  const dirty = slides.some(
    (slide) => slide.media != null || hasMomentOverlayText(slide)
  );

  function startSlides() {
    setSlides([createBlankMomentSlide()]);
    setActiveIndex(0);
    setEditingId(null);
    setMode('slides');
  }

  function pickVideo() {
    if (videoLocked) {
      if (mode == null) setVipPromptOpen(true);
      else toast.info(t('moment.videoVipRequired'));
      return;
    }
    videoInputRef.current?.click();
  }

  function addSlide() {
    if (slides.length >= MOMENT_MAX_SLIDES) return;
    setSlides((current) => [...current, createBlankMomentSlide()]);
    setActiveIndex(slides.length);
    setEditingId(null);
  }

  function handleFiles(event: ChangeEvent<HTMLInputElement>) {
    const picked = Array.from(event.target.files ?? []).filter((file) =>
      file.type.startsWith('image/')
    );
    event.target.value = '';
    if (picked.length === 0 || active == null) return;
    const room = momentPhotoRoom(slides.length);
    if (picked.length > room) {
      toast.info(t('moment.maxSlides', { count: MOMENT_MAX_SLIDES }));
    }
    const photos = picked.slice(0, room).map((file) => ({
      type: MOMENT_TYPE.image,
      url: URL.createObjectURL(file),
      file,
    }));
    if (active.media) releaseSlides([active]);
    const index = slides.indexOf(active);
    setSlides(fillMomentSlidePhotos(slides, index, photos));
    setActiveIndex(index);
    setEditingId(null);
  }

  function pickPhotos() {
    fileInputRef.current?.click();
  }

  function chooseColor() {
    if (active == null) return;
    updateSlide({ ...active, blank: false });
  }

  async function handleVideoFile(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file == null) return;
    if (!isMomentVideoFile(file)) {
      toast.info(t('moment.videoUnsupported'));
      return;
    }
    const url = URL.createObjectURL(file);
    const info = await readVideoFile(url).catch(() => null);
    if (
      info != null &&
      info.duration >
        MOMENT_MAX_VIDEO_SECONDS + MOMENT_VIDEO_DURATION_TOLERANCE_S
    ) {
      URL.revokeObjectURL(url);
      toast.info(t('moment.videoTooLong', { count: MOMENT_MAX_VIDEO_SECONDS }));
      return;
    }
    releaseSlides(slidesRef.current);
    setSlides([
      createMomentDraftSlide({
        type: MOMENT_TYPE.video,
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

  function updateSlide(next: MomentDraftSlide) {
    setSlides((current) =>
      current.map((slide) => (slide.id === next.id ? next : slide))
    );
  }

  function removeSlide(id: string) {
    const target = slides.find((slide) => slide.id === id);
    if (target) releaseSlides([target]);
    const remaining = slides.filter((slide) => slide.id !== id);
    setSlides(remaining);
    setActiveIndex((index) =>
      Math.min(index, Math.max(0, remaining.length - 1))
    );
    setEditingId(null);
    if (remaining.length === 0) setMode(null);
  }

  function addText() {
    if (active == null) return;
    if (active.overlays.length >= MOMENT_MAX_OVERLAYS) {
      toast.info(t('moment.maxOverlays', { count: MOMENT_MAX_OVERLAYS }));
      return;
    }
    const overlay = createMomentOverlay();
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
    const issue = momentSlideIssue(slides);
    if (issue != null) {
      setEditingId(null);
      setActiveIndex(issue.index);
      toast.info(t(issue.messageKey));
      return;
    }
    setSubmitting(true);
    try {
      const posted = await publish(() =>
        buildMomentUpload(
          visibility,
          slides.map((slide) => ({
            media: slide.media,
            background: slide.background,
            overlays: slide.overlays.filter(
              (overlay) => overlay.text.trim() !== ''
            ),
          }))
        )
      );
      if (posted) toast.success(t('moment.posted'));
    } catch (error) {
      const failure = momentPublishError(error);
      toast.error(t(failure.key, failure.params));
      setSubmitting(false);
      return;
    }
    onClose();
  }

  return createPortal(
    <div
      className="contents"
      onTouchStart={keepTouchInComposer}
      onTouchMove={keepTouchInComposer}
      onTouchEnd={keepTouchInComposer}
    >
      {mode == null || active == null ? (
        <MomentModePicker
          videoLocked={videoLocked}
          onClose={onClose}
          onPickSlides={startSlides}
          onPickVideo={pickVideo}
        />
      ) : (
        <FullScreenOverlay z={60}>
          <ScreenHeader title={t('moment.createTitle')} onBack={requestClose}>
            <div className="flex shrink-0 items-center gap-2 pr-1">
              <label className="relative flex items-center">
                <select
                  value={visibility}
                  onChange={(event) =>
                    setVisibility(event.target.value as MomentVisibility)
                  }
                  aria-label={t('moment.visibilityTitle')}
                  className="cursor-pointer appearance-none rounded-full bg-white/15 py-1 pr-7 pl-3 text-sm font-medium outline-none transition-colors hover:bg-white/25 focus-visible:ring-2 focus-visible:ring-white/60"
                >
                  {Object.values(MOMENT_VISIBILITY).map((value) => (
                    <option key={value} value={value} className="text-black">
                      {t(MOMENT_VISIBILITY_LABEL[value])}
                    </option>
                  ))}
                </select>
                <span className="pointer-events-none absolute right-3 text-sm">
                  ▾
                </span>
              </label>
              <button
                type="button"
                onClick={() => void submit()}
                disabled={editingId != null || submitting}
                className="rounded-full bg-white px-4 py-1 text-sm font-semibold text-ola-primary-dark transition-opacity disabled:opacity-60"
              >
                {t(submitting ? 'moment.posting' : 'moment.post')}
              </button>
            </div>
          </ScreenHeader>
          <MomentStage className="mx-3 mt-2">
            {active.blank ? (
              <MomentCanvas
                fit
                background={BLANK_SLIDE_BACKGROUND}
                media={null}
                overlays={[]}
              >
                <MomentSlideChoice
                  onPickPhoto={pickPhotos}
                  onPickColor={chooseColor}
                />
              </MomentCanvas>
            ) : (
              <MomentCanvasEditor
                key={active.id}
                slide={active}
                editingId={editingId}
                onChange={updateSlide}
                onEditingChange={setEditingId}
                onAddText={addText}
              />
            )}
          </MomentStage>
          <div className="shrink-0 px-3 pt-2 pb-3">
            {mode === 'slides' && (
              <>
                {active.media != null && (
                  <MomentPhotoBar onChange={pickPhotos} />
                )}
                <MomentSlideStrip
                  slides={slides}
                  activeIndex={activeIndex}
                  onSelect={(index) => {
                    setEditingId(null);
                    setActiveIndex(index);
                  }}
                  onRemove={removeSlide}
                  onAdd={addSlide}
                />
              </>
            )}
            {mode === 'video' && (
              <MomentVideoBar
                duration={active.media?.duration}
                onChange={pickVideo}
              />
            )}
          </div>
        </FullScreenOverlay>
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
        accept={MOMENT_VIDEO_ACCEPT}
        hidden
        onChange={(event) => void handleVideoFile(event)}
      />

      <ConfirmDialog
        open={discardOpen}
        title={t('moment.discardTitle')}
        message={t('moment.discardMessage')}
        confirmLabel={t('moment.discard')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          setDiscardOpen(false);
          onClose();
        }}
        onCancel={() => setDiscardOpen(false)}
      />
      <ConfirmDialog
        open={vipPromptOpen}
        title={t('moment.videoVipTitle')}
        message={t('moment.videoVipRequired')}
        confirmLabel={t('moment.buyVip')}
        cancelLabel={t('common.cancel')}
        onConfirm={() => {
          setVipPromptOpen(false);
          onClose();
          useAppOverlayStore.getState().push('vipBuy', 'extend');
        }}
        onCancel={() => setVipPromptOpen(false)}
      />
    </div>,
    portalRoot()
  );
}

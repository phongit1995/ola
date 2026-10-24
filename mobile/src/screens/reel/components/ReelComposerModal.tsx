import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StatusBar, Text, useWindowDimensions, View } from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  REEL_MAX_IMAGES,
  REEL_MAX_OVERLAYS,
  REEL_MAX_VIDEO_SECONDS,
  REEL_VISIBILITY,
  REEL_VISIBILITY_LABEL,
} from '@ola/shared/constants';
import {
  createReelDraftSlide,
  createReelOverlay,
  hasReelOverlayText,
  patchReelOverlay,
  reelPublishError,
  removeReelOverlay,
  toast,
} from '@ola/shared/lib';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import type { ReelDraftSlide, ReelMediaDraft, ReelVisibility } from '@ola/shared/types';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ToastHost } from '@components/ui/ToastHost';
import { useThemeColors } from '@hooks/useThemeColors';
import { REEL_ASPECT_RATIO } from '../constants';
import { pickReelImages, pickReelVideo } from '../reelPicker';
import { buildReelUpload } from '../reelUpload';
import { ReelCanvasEditor } from './ReelCanvasEditor';
import {
  ReelBackgroundPicker,
  ReelModePicker,
  ReelSlideStrip,
  ReelVideoBar,
} from './ReelComposerParts';
import { ReelCloseIcon } from './ReelIcons';
import { ReelTextPanel } from './ReelTextPanel';

type ComposerMode = 'text' | 'image' | 'video';

const HEADER_HEIGHT = 56;
const FOOTER_HEIGHT = 76;
const CANVAS_MARGIN = 12;

interface ReelComposerContentProps {
  onClose: () => void;
  requestCloseRef: { current: () => void };
}

function ReelComposerContent({ onClose, requestCloseRef }: ReelComposerContentProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const window = useWindowDimensions();
  const publish = useReelStore((s) => s.publish);
  const [submitting, setSubmitting] = useState(false);
  const [mode, setMode] = useState<ComposerMode | null>(null);
  const [slides, setSlides] = useState<ReelDraftSlide[]>([]);
  const [activeIndex, setActiveIndex] = useState(0);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [visibility, setVisibility] = useState<ReelVisibility>(REEL_VISIBILITY.friend);
  const [visibilityOpen, setVisibilityOpen] = useState(false);
  const [discardOpen, setDiscardOpen] = useState(false);

  const active = slides[activeIndex] ?? slides[0];
  const editing = active?.overlays.find((overlay) => overlay.id === editingId) ?? null;
  const dirty = slides.some((slide) => slide.media != null || hasReelOverlayText(slide));
  const availableHeight =
    window.height - insets.top - insets.bottom - HEADER_HEIGHT - FOOTER_HEIGHT - CANVAS_MARGIN;
  const canvasWidth = Math.min(window.width - CANVAS_MARGIN * 2, availableHeight * REEL_ASPECT_RATIO);
  const canvasHeight = canvasWidth / REEL_ASPECT_RATIO;

  function updateSlide(next: ReelDraftSlide) {
    setSlides((current) => current.map((slide) => (slide.id === next.id ? next : slide)));
  }

  function updateSlideWith(id: string, update: (slide: ReelDraftSlide) => ReelDraftSlide) {
    setSlides((current) => current.map((slide) => (slide.id === id ? update(slide) : slide)));
  }

  function updateOverlay(id: string, patch: Partial<ReelDraftSlide['overlays'][number]>) {
    if (active == null) return;
    updateSlideWith(active.id, (slide) => patchReelOverlay(slide, id, patch));
  }

  function startText() {
    const slide = createReelDraftSlide(null);
    const overlay = createReelOverlay();
    setSlides([{ ...slide, overlays: [overlay] }]);
    setActiveIndex(0);
    setMode('text');
    setEditingId(overlay.id);
  }

  async function pickImages() {
    const existing = mode === 'image' ? slides.length : 0;
    const room = REEL_MAX_IMAGES - existing;
    if (room <= 0) {
      toast.info(t('reel.maxImages', { count: REEL_MAX_IMAGES }));
      return;
    }
    const picked = await pickReelImages(room).catch(() => [] as ReelMediaDraft[]);
    const added = picked.slice(0, room).map((media) => createReelDraftSlide(media));
    if (added.length === 0) return;
    if (mode === 'image') setSlides((current) => [...current, ...added]);
    else {
      setSlides(added);
      setMode('image');
    }
    setActiveIndex(existing);
    setEditingId(null);
  }

  async function pickVideo() {
    const result = await pickReelVideo().catch(() => ({ kind: 'cancelled' as const }));
    if (result.kind === 'cancelled') return;
    if (result.kind === 'unsupported') {
      toast.info(t('reel.videoUnsupported'));
      return;
    }
    if (result.kind === 'tooLong') {
      toast.info(t('reel.videoTooLong', { count: REEL_MAX_VIDEO_SECONDS }));
      return;
    }
    if (result.kind === 'tooLarge') {
      toast.info(t('reel.errorTooLarge'));
      return;
    }
    setSlides([createReelDraftSlide(result.media)]);
    setActiveIndex(0);
    setEditingId(null);
    setMode('video');
  }

  function markVideoUnplayable() {
    if (active?.media == null || active.media.playable === false) return;
    updateSlide({ ...active, media: { ...active.media, playable: false } });
  }

  function removeSlide(id: string) {
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

  function finishEditing() {
    if (active != null && editing != null && editing.text.trim() === '') {
      updateSlide(removeReelOverlay(active, editing.id));
    }
    setEditingId(null);
  }

  function requestClose() {
    if (submitting) return;
    if (editing != null) {
      finishEditing();
      return;
    }
    if (dirty) setDiscardOpen(true);
    else onClose();
  }

  useEffect(() => {
    requestCloseRef.current = requestClose;
  });

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

  return (
    <View style={{ flex: 1, backgroundColor: '#0a0a0a', paddingTop: insets.top, paddingBottom: insets.bottom }}>
      <StatusBar barStyle="light-content" />
      <View
        className="flex-row items-center gap-2 px-2"
        style={{ height: HEADER_HEIGHT, opacity: editing != null ? 0 : 1 }}
        pointerEvents={editing != null ? 'none' : 'auto'}
      >
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('dialog.close')}
          hitSlop={8}
          onPress={requestClose}
          className="rounded-full p-2"
        >
          <ReelCloseIcon />
        </Pressable>
        <Text numberOfLines={1} className="min-w-0 flex-1 text-base font-semibold" style={{ color: '#ffffff' }}>
          {t('reel.createTitle')}
        </Text>
        {mode != null && (
          <>
            <Pressable
              accessibilityRole="button"
              onPress={() => setVisibilityOpen(true)}
              className="rounded-full px-3 py-1.5"
              style={{ backgroundColor: 'rgba(255,255,255,0.12)' }}
            >
              <Text className="text-sm" style={{ color: '#ffffff' }}>
                {t(REEL_VISIBILITY_LABEL[visibility])} ▾
              </Text>
            </Pressable>
            <Pressable
              accessibilityRole="button"
              disabled={editingId != null || submitting}
              onPress={() => void submit()}
              className="rounded-full px-4 py-1.5"
              style={{ backgroundColor: colors.primary, opacity: editingId != null || submitting ? 0.5 : 1 }}
            >
              <Text className="text-sm font-semibold" style={{ color: colors.onPrimary }}>
                {t(submitting ? 'reel.posting' : 'reel.post')}
              </Text>
            </Pressable>
          </>
        )}
      </View>

      {mode == null || active == null ? (
        <ReelModePicker
          onPickText={startText}
          onPickImage={() => void pickImages()}
          onPickVideo={() => void pickVideo()}
        />
      ) : (
        <>
          <View className="flex-1 items-center justify-center">
            <ReelCanvasEditor
              key={active.id}
              slide={active}
              width={canvasWidth}
              height={canvasHeight}
              editingId={editingId}
              onChange={(update) => updateSlideWith(active.id, update)}
              onEditingChange={setEditingId}
              onAddText={addText}
              onMediaError={markVideoUnplayable}
            />
          </View>
          <View className="justify-center px-3" style={{ height: FOOTER_HEIGHT }}>
            {mode === 'text' && (
              <ReelBackgroundPicker
                value={active.background}
                onChange={(background) => updateSlide({ ...active, background })}
              />
            )}
            {mode === 'video' && (
              <ReelVideoBar duration={active.media?.duration} onChange={() => void pickVideo()} />
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
                onAdd={() => void pickImages()}
              />
            )}
          </View>
        </>
      )}

      {editing != null && (
        <ReelTextPanel
          overlay={editing}
          canvasWidth={canvasWidth}
          onChange={(patch) => updateOverlay(editing.id, patch)}
          onDone={finishEditing}
        />
      )}

      <ListOptionDialog
        visible={visibilityOpen}
        title={t('reel.visibilityTitle')}
        options={Object.values(REEL_VISIBILITY).map((value) => ({
          key: value,
          label: t(REEL_VISIBILITY_LABEL[value]),
          onSelect: () => setVisibility(value),
        }))}
        onClose={() => setVisibilityOpen(false)}
      />
      <ConfirmDialog
        visible={discardOpen}
        danger
        title={t('reel.discardTitle')}
        message={t('reel.discardMessage')}
        confirmLabel={t('reel.discard')}
        cancelLabel={t('common.cancel')}
        onConfirm={() => {
          setDiscardOpen(false);
          onClose();
        }}
        onCancel={() => setDiscardOpen(false)}
      />
    </View>
  );
}

interface ReelComposerModalProps {
  visible: boolean;
  onClose: () => void;
}

export function ReelComposerModal({ visible, onClose }: ReelComposerModalProps) {
  const requestCloseRef = useRef(onClose);
  return (
    <OlaModal
      visible={visible}
      animationType="slide"
      statusBarTranslucent
      navigationBarTranslucent
      onRequestClose={() => requestCloseRef.current()}
    >
      {visible && (
        <GestureHandlerRootView style={{ flex: 1 }}>
          <ReelComposerContent onClose={onClose} requestCloseRef={requestCloseRef} />
        </GestureHandlerRootView>
      )}
      <ToastHost />
    </OlaModal>
  );
}

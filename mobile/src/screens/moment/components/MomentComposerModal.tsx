import { useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Animated,
  Easing,
  Platform,
  Pressable,
  StatusBar,
  Text,
  useWindowDimensions,
  View,
  type ViewInstance,
} from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  DEFAULT_MOMENT_VISIBILITY,
  MOMENT_MAX_OVERLAYS,
  MOMENT_MAX_SLIDES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_VISIBILITY_LABEL,
} from '@ola/shared/constants';
import {
  createBlankMomentSlide,
  createMomentDraftSlide,
  createMomentOverlay,
  fillMomentSlidePhotos,
  hasMomentOverlayText,
  momentPhotoRoom,
  momentSlideIssue,
  patchMomentOverlay,
  momentPublishError,
  removeMomentOverlay,
  toast,
} from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentVideoLocked } from '@ola/shared/stores/moment/momentConfigStore';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import type { MomentDraftSlide, MomentMediaDraft, MomentVisibility } from '@ola/shared/types';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ToastHost } from '@components/ui/ToastHost';
import { useThemeColors } from '@hooks/useThemeColors';
import { MOMENT_ASPECT_RATIO } from '../constants';
import { pickMomentImages, pickMomentVideo } from '../momentPicker';
import { buildMomentUpload } from '../momentUpload';
import { MomentCanvasEditor } from './MomentCanvasEditor';
import {
  MomentModePicker,
  MomentPhotoBar,
  MomentSlideChoice,
  MomentSlideStrip,
  MomentVideoBar,
  MomentVisibilityMenu,
  type MomentMenuAnchor,
} from './MomentComposerParts';
import { MomentTextPanel } from './MomentTextPanel';

type ComposerMode = 'slides' | 'video';

const HEADER_HEIGHT = 48;
const SLIDES_FOOTER_HEIGHT = 92;
const VIDEO_FOOTER_HEIGHT = 76;
const PHOTO_BAR_HEIGHT = 48;
const CANVAS_MARGIN = 12;
const MENU_GAP = 6;
const SLIDE_UP_MS = 260;

function MomentSlideUp({ children }: { children: ReactNode }) {
  const window = useWindowDimensions();
  const progress = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(progress, {
      toValue: 1,
      duration: SLIDE_UP_MS,
      easing: Easing.out(Easing.cubic),
      useNativeDriver: true,
    }).start();
  }, [progress]);

  const translateY = progress.interpolate({ inputRange: [0, 1], outputRange: [window.height, 0] });
  return <Animated.View style={{ flex: 1, transform: [{ translateY }] }}>{children}</Animated.View>;
}

interface MomentComposerContentProps {
  ready: boolean;
  onClose: () => void;
  requestCloseRef: { current: () => void };
}

function MomentComposerContent({ ready, onClose, requestCloseRef }: MomentComposerContentProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const window = useWindowDimensions();
  const publish = useMomentStore((s) => s.publish);
  const [submitting, setSubmitting] = useState(false);
  const [mode, setMode] = useState<ComposerMode | null>(null);
  const [slides, setSlides] = useState<MomentDraftSlide[]>([]);
  const [activeIndex, setActiveIndex] = useState(0);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [visibility, setVisibility] = useState<MomentVisibility>(DEFAULT_MOMENT_VISIBILITY);
  const [visibilityMenu, setVisibilityMenu] = useState<MomentMenuAnchor | null>(null);
  const rootRef = useRef<ViewInstance>(null);
  const visibilityRef = useRef<ViewInstance>(null);
  const [discardOpen, setDiscardOpen] = useState(false);
  const [pickError, setPickError] = useState<string | null>(null);
  const [closePending, setClosePending] = useState(false);
  const [vipPrompt, setVipPrompt] = useState(false);
  const videoLocked = useMomentVideoLocked();
  const buyVipAfterCloseRef = useRef(false);
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();

  const active = slides[activeIndex] ?? slides[0];
  const editing = active?.overlays.find((overlay) => overlay.id === editingId) ?? null;
  const dirty = slides.some((slide) => slide.media != null || hasMomentOverlayText(slide));
  const footerHeight =
    mode === 'video'
      ? VIDEO_FOOTER_HEIGHT
      : SLIDES_FOOTER_HEIGHT + (active?.media != null ? PHOTO_BAR_HEIGHT : 0);
  const availableHeight =
    window.height - insets.top - insets.bottom - HEADER_HEIGHT - footerHeight - CANVAS_MARGIN;
  const canvasWidth = Math.min(window.width - CANVAS_MARGIN * 2, availableHeight * MOMENT_ASPECT_RATIO);
  const canvasHeight = canvasWidth / MOMENT_ASPECT_RATIO;

  function updateSlide(next: MomentDraftSlide) {
    setSlides((current) => current.map((slide) => (slide.id === next.id ? next : slide)));
  }

  function updateSlideWith(id: string, update: (slide: MomentDraftSlide) => MomentDraftSlide) {
    setSlides((current) => current.map((slide) => (slide.id === id ? update(slide) : slide)));
  }

  function updateOverlay(id: string, patch: Partial<MomentDraftSlide['overlays'][number]>) {
    if (active == null) return;
    updateSlideWith(active.id, (slide) => patchMomentOverlay(slide, id, patch));
  }

  function startSlides() {
    setSlides([createBlankMomentSlide()]);
    setActiveIndex(0);
    setEditingId(null);
    setMode('slides');
  }

  function addSlide() {
    if (slides.length >= MOMENT_MAX_SLIDES) return;
    setSlides((current) => [...current, createBlankMomentSlide()]);
    setActiveIndex(slides.length);
    setEditingId(null);
  }

  async function pickPhotos() {
    if (active == null) return;
    const index = slides.indexOf(active);
    const room = momentPhotoRoom(slides.length);
    const picked = await pickMomentImages(room).catch(() => [] as MomentMediaDraft[]);
    if (picked.length === 0) return;
    if (picked.length > room) toast.info(t('moment.maxSlides', { count: MOMENT_MAX_SLIDES }));
    setSlides((current) => fillMomentSlidePhotos(current, index, picked.slice(0, room)));
    setActiveIndex(index);
    setEditingId(null);
  }

  function chooseColor() {
    if (active == null) return;
    updateSlide({ ...active, blank: false });
  }

  function reportPickError(message: string) {
    if (mode == null) setPickError(message);
    else toast.info(message);
  }

  async function pickVideo() {
    setPickError(null);
    const result = await pickMomentVideo().catch(() => ({ kind: 'cancelled' as const }));
    if (result.kind === 'cancelled') return;
    if (result.kind === 'unsupported') {
      reportPickError(t('moment.videoUnsupported'));
      return;
    }
    if (result.kind === 'tooLong') {
      reportPickError(t('moment.videoTooLong', { count: MOMENT_MAX_VIDEO_SECONDS }));
      return;
    }
    if (result.kind === 'tooLarge') {
      reportPickError(t('moment.errorTooLarge'));
      return;
    }
    setSlides([createMomentDraftSlide(result.media)]);
    setActiveIndex(0);
    setEditingId(null);
    setMode('video');
  }

  function requestVideo() {
    if (!videoLocked) {
      void pickVideo();
      return;
    }
    if (mode == null) {
      setPickError(null);
      setVipPrompt(true);
    } else {
      toast.info(t('moment.videoVipRequired'));
    }
  }

  function buyVip() {
    buyVipAfterCloseRef.current = true;
    closeAfterDialog();
  }

  function finishClose() {
    onClose();
    if (!buyVipAfterCloseRef.current) return;
    buyVipAfterCloseRef.current = false;
    navigation.navigate(ROOT_ROUTES.BuyVip, { mode: 'extend' });
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
    if (active.overlays.length >= MOMENT_MAX_OVERLAYS) {
      toast.info(t('moment.maxOverlays', { count: MOMENT_MAX_OVERLAYS }));
      return;
    }
    const overlay = createMomentOverlay();
    updateSlide({ ...active, overlays: [...active.overlays, overlay] });
    setEditingId(overlay.id);
  }

  function finishEditing() {
    if (active != null && editing != null && editing.text.trim() === '') {
      updateSlide(removeMomentOverlay(active, editing.id));
    }
    setEditingId(null);
  }

  function closeAfterDialog() {
    setClosePending(true);
    if (Platform.OS !== 'ios') requestAnimationFrame(finishClose);
  }

  function closeIfPending() {
    if (closePending) finishClose();
  }

  function openVisibilityMenu() {
    const root = rootRef.current;
    if (root == null) return;
    visibilityRef.current?.measureLayout(root, (x, y, width, height) => {
      setVisibilityMenu({ top: y + height + MENU_GAP, right: window.width - x - width });
    });
  }

  function requestClose() {
    if (submitting) return;
    if (visibilityMenu != null) {
      setVisibilityMenu(null);
      return;
    }
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
            overlays: slide.overlays.filter((overlay) => overlay.text.trim() !== ''),
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

  if (mode == null || active == null) {
    return (
      <MomentModePicker
        visible={ready && !closePending}
        error={pickError}
        videoLocked={videoLocked}
        vipPrompt={vipPrompt}
        onClose={closeAfterDialog}
        onDismiss={closeIfPending}
        onPickSlides={startSlides}
        onPickVideo={requestVideo}
        onBuyVip={buyVip}
      />
    );
  }

  const postDisabled = editingId != null || submitting;

  return (
    <MomentSlideUp>
      <View ref={rootRef} className="flex-1 bg-ola-surface" style={{ paddingBottom: insets.bottom }}>
        <StatusBar barStyle="light-content" />
        <View style={{ opacity: editing != null ? 0 : 1 }} pointerEvents={editing != null ? 'none' : 'auto'}>
          <ScreenHeader
            title={t('moment.createTitle')}
            onBack={requestClose}
            right={
              <View className="flex-row items-center gap-2">
                <Pressable
                  ref={visibilityRef}
                  accessibilityRole="button"
                  accessibilityLabel={t('moment.visibilityTitle')}
                  onPress={openVisibilityMenu}
                  className="rounded-full px-3 py-1"
                  style={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
                >
                  <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
                    {t(MOMENT_VISIBILITY_LABEL[visibility])} ▾
                  </Text>
                </Pressable>
                <Pressable
                  accessibilityRole="button"
                  disabled={postDisabled}
                  onPress={() => void submit()}
                  className="rounded-full px-4 py-1"
                  style={{ backgroundColor: '#ffffff', opacity: postDisabled ? 0.6 : 1 }}
                >
                  <Text className="text-sm font-semibold" style={{ color: colors.primaryDark }}>
                    {t(submitting ? 'moment.posting' : 'moment.post')}
                  </Text>
                </Pressable>
              </View>
            }
          />
        </View>

        <View className="flex-1 items-center justify-center">
          {active.blank ? (
            <MomentSlideChoice
              width={canvasWidth}
              height={canvasHeight}
              onPickPhoto={() => void pickPhotos()}
              onPickColor={chooseColor}
            />
          ) : (
            <MomentCanvasEditor
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
          )}
        </View>
        <View className="justify-center px-3" style={{ height: footerHeight }}>
          {mode === 'slides' && (
            <>
              {active.media != null && <MomentPhotoBar onChange={() => void pickPhotos()} />}
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
            <MomentVideoBar duration={active.media?.duration} onChange={requestVideo} />
          )}
        </View>

        {editing != null && (
          <MomentTextPanel
            overlay={editing}
            canvasWidth={canvasWidth}
            onChange={(patch) => updateOverlay(editing.id, patch)}
            onDone={finishEditing}
            onDelete={() => {
              updateSlideWith(active.id, (slide) => removeMomentOverlay(slide, editing.id));
              setEditingId(null);
            }}
          />
        )}

        {visibilityMenu != null && (
          <MomentVisibilityMenu
            anchor={visibilityMenu}
            value={visibility}
            onSelect={(value) => {
              setVisibility(value);
              setVisibilityMenu(null);
            }}
            onClose={() => setVisibilityMenu(null)}
          />
        )}
        <ConfirmDialog
          visible={discardOpen}
          danger
          title={t('moment.discardTitle')}
          message={t('moment.discardMessage')}
          confirmLabel={t('moment.discard')}
          cancelLabel={t('common.cancel')}
          onConfirm={() => {
            setDiscardOpen(false);
            closeAfterDialog();
          }}
          onCancel={() => setDiscardOpen(false)}
          onDismiss={closeIfPending}
        />
      </View>
    </MomentSlideUp>
  );
}

interface MomentComposerModalProps {
  visible: boolean;
  onClose: () => void;
}

export function MomentComposerModal({ visible, onClose }: MomentComposerModalProps) {
  const requestCloseRef = useRef(onClose);
  const [shown, setShown] = useState(false);

  function close() {
    setShown(false);
    onClose();
  }

  return (
    <OlaModal
      visible={visible}
      transparent
      animationType="none"
      statusBarTranslucent
      navigationBarTranslucent
      onShow={() => setShown(true)}
      onRequestClose={() => requestCloseRef.current()}
    >
      {visible && (
        <GestureHandlerRootView style={{ flex: 1 }}>
          <MomentComposerContent ready={shown} onClose={close} requestCloseRef={requestCloseRef} />
        </GestureHandlerRootView>
      )}
      <ToastHost />
    </OlaModal>
  );
}

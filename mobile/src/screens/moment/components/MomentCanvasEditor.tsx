import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { GestureDetector } from 'react-native-gesture-handler';
import { patchMomentOverlay, raiseMomentOverlay, removeMomentOverlay } from '@ola/shared/lib';
import type { MomentDraftSlide, MomentOverlay } from '@ola/shared/types';
import { useOverlayGestures } from '../useOverlayGestures';
import {
  MomentBackgroundFill,
  MomentCanvas,
  MomentOverlayBubble,
  MomentOverlayFrame,
  type MomentCanvasSize,
} from './MomentCanvas';
import { MomentBackgroundPicker } from './MomentComposerParts';
import { MomentTrashIcon, MomentVideoIcon } from './MomentIcons';

const TRASH_SIZE = 48;
const CORNER_BUTTON = 40;
const CORNER_INSET = 12;
const ADD_TEXT_LABEL_MIN_WIDTH = 208;
const GUIDE_COLOR = 'rgba(255,255,255,0.8)';
const TAP_TO_TYPE = {
  color: 'rgba(255,255,255,0.85)',
  textShadowColor: 'rgba(0,0,0,0.35)',
  textShadowRadius: 4,
  textShadowOffset: { width: 0, height: 1 },
};

type OverlayGestureFactory = ReturnType<typeof useOverlayGestures>['overlayGesture'];

function EditableOverlay({
  overlay,
  canvas,
  hidden,
  createGesture,
}: {
  overlay: MomentOverlay;
  canvas: MomentCanvasSize;
  hidden: boolean;
  createGesture: OverlayGestureFactory;
}) {
  const gesture = useMemo(() => createGesture(overlay.id), [createGesture, overlay.id]);
  return (
    <MomentOverlayFrame overlay={overlay} canvas={canvas}>
      <GestureDetector gesture={gesture}>
        <View style={{ opacity: hidden ? 0 : 1, transform: [{ rotate: `${overlay.rotation}deg` }] }}>
          <MomentOverlayBubble overlay={overlay} canvasWidth={canvas.width} />
        </View>
      </GestureDetector>
    </MomentOverlayFrame>
  );
}

interface MomentCanvasEditorProps {
  slide: MomentDraftSlide;
  width: number;
  height: number;
  editingId: string | null;
  onChange: (update: (slide: MomentDraftSlide) => MomentDraftSlide) => void;
  onEditingChange: (id: string | null) => void;
  onAddText: () => void;
  onMediaError: () => void;
}

export function MomentCanvasEditor({
  slide,
  width,
  height,
  editingId,
  onChange,
  onEditingChange,
  onAddText,
  onMediaError,
}: MomentCanvasEditorProps) {
  const { t } = useTranslation();
  const canvas = useMemo(() => ({ width, height }), [width, height]);
  const [backgroundOpen, setBackgroundOpen] = useState(false);
  const canChangeBackground = slide.media == null;

  const gestures = useOverlayGestures({
    overlays: slide.overlays,
    canvas,
    onUpdate: (id, patch) => onChange((current) => patchMomentOverlay(current, id, patch)),
    onRemove: (id) => onChange((current) => removeMomentOverlay(current, id)),
    onRaise: (id) => onChange((current) => raiseMomentOverlay(current, id)),
    onTap: (id) => {
      setBackgroundOpen(false);
      onEditingChange(id);
    },
  });

  function startAddText() {
    setBackgroundOpen(false);
    onAddText();
  }

  const showHandles = !gestures.dragging && editingId == null;

  return (
    <GestureDetector gesture={gestures.canvasGesture}>
      <View style={{ width, height, borderRadius: 12, overflow: 'hidden' }}>
        <MomentCanvas
          background={slide.background}
          media={slide.media}
          overlays={[]}
          videoMode="loop"
          onMediaError={onMediaError}
          style={StyleSheet.absoluteFill}
          renderOverlays={(size) =>
            slide.overlays.map((overlay) => (
              <EditableOverlay
                key={overlay.id}
                overlay={overlay}
                canvas={size}
                hidden={overlay.id === editingId}
                createGesture={gestures.overlayGesture}
              />
            ))
          }
        />
        {slide.media?.playable === false && (
          <View
            pointerEvents="none"
            style={{ position: 'absolute', left: 32, right: 32, top: 0, bottom: 0, alignItems: 'center', justifyContent: 'center', gap: 8 }}
          >
            <MomentVideoIcon size={32} color="rgba(255,255,255,0.85)" />
            <Text className="text-center text-sm" style={{ color: 'rgba(255,255,255,0.85)' }}>
              {t('moment.videoNoPreview')}
            </Text>
          </View>
        )}
        {gestures.verticalGuide && (
          <View
            pointerEvents="none"
            style={{ position: 'absolute', top: 0, bottom: 0, left: width / 2, width: 1, backgroundColor: GUIDE_COLOR }}
          />
        )}
        {gestures.horizontalGuide && (
          <View
            pointerEvents="none"
            style={{ position: 'absolute', left: 0, right: 0, top: height / 2, height: 1, backgroundColor: GUIDE_COLOR }}
          />
        )}
        {showHandles && slide.media == null && slide.overlays.length === 0 && (
          <Pressable
            accessibilityRole="button"
            onPress={startAddText}
            style={{ position: 'absolute', left: 32, right: 32, top: height / 2 - 28, height: 56, alignItems: 'center', justifyContent: 'center' }}
          >
            <Text className="text-center text-2xl font-semibold" style={TAP_TO_TYPE}>
              {t('moment.tapToType')}
            </Text>
          </Pressable>
        )}
        {showHandles && backgroundOpen && canChangeBackground && (
          <>
            <Pressable style={StyleSheet.absoluteFill} onPress={() => setBackgroundOpen(false)} />
            <View pointerEvents="box-none" style={styles.backgroundSlot}>
              <View style={styles.backgroundSheet}>
                <ScrollView style={{ flexGrow: 0 }} bounces={false} showsVerticalScrollIndicator={false}>
                  <MomentBackgroundPicker
                    value={slide.background}
                    onChange={(background) => onChange((current) => ({ ...current, background }))}
                  />
                </ScrollView>
              </View>
            </View>
          </>
        )}
        {showHandles && (
          <View className="flex-row items-center gap-2" style={styles.cornerTools}>
            {canChangeBackground && (
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('moment.background')}
                accessibilityState={{ expanded: backgroundOpen }}
                onPress={() => setBackgroundOpen((open) => !open)}
                style={[styles.backgroundButton, { transform: [{ scale: backgroundOpen ? 1.1 : 1 }] }]}
              >
                <MomentBackgroundFill background={slide.background} />
              </Pressable>
            )}
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('moment.addText')}
              onPress={startAddText}
              className="flex-row items-center gap-1.5 rounded-full px-3"
              style={{ height: CORNER_BUTTON, backgroundColor: 'rgba(0,0,0,0.45)' }}
            >
              <Text style={{ color: '#ffffff', fontSize: 16, fontWeight: '600' }}>Aa</Text>
              {width >= ADD_TEXT_LABEL_MIN_WIDTH && (
                <Text className="text-sm font-semibold" style={{ color: '#ffffff' }}>
                  {t('moment.addText')}
                </Text>
              )}
            </Pressable>
          </View>
        )}
        {gestures.dragging && (
          <View
            pointerEvents="none"
            style={{ position: 'absolute', left: 0, right: 0, bottom: 20, alignItems: 'center', gap: 6 }}
          >
            <View
              ref={gestures.trashRef}
              onLayout={gestures.measureTrash}
              style={{
                width: TRASH_SIZE,
                height: TRASH_SIZE,
                borderRadius: TRASH_SIZE / 2,
                alignItems: 'center',
                justifyContent: 'center',
                borderWidth: 2,
                borderColor: gestures.overTrash ? '#e34545' : 'rgba(255,255,255,0.7)',
                backgroundColor: gestures.overTrash ? '#e34545' : 'rgba(0,0,0,0.4)',
                transform: [{ scale: gestures.overTrash ? 1.25 : 1 }],
              }}
            >
              <MomentTrashIcon />
            </View>
            <Text
              className="rounded-full px-2 py-0.5 text-xs"
              style={{ color: '#ffffff', backgroundColor: 'rgba(0,0,0,0.4)', overflow: 'hidden' }}
            >
              {t('moment.dropToDelete')}
            </Text>
          </View>
        )}
      </View>
    </GestureDetector>
  );
}

const styles = StyleSheet.create({
  cornerTools: { position: 'absolute', right: CORNER_INSET, bottom: CORNER_INSET },
  backgroundButton: {
    width: CORNER_BUTTON,
    height: CORNER_BUTTON,
    borderRadius: CORNER_BUTTON / 2,
    borderWidth: 2,
    borderColor: '#ffffff',
    overflow: 'hidden',
  },
  backgroundSlot: {
    position: 'absolute',
    left: 8,
    right: 8,
    top: 8,
    bottom: CORNER_INSET + CORNER_BUTTON + 12,
    justifyContent: 'flex-end',
  },
  backgroundSheet: {
    maxHeight: '100%',
    borderRadius: 16,
    padding: 6,
    backgroundColor: 'rgba(255,255,255,0.95)',
    shadowColor: '#000',
    shadowOpacity: 0.2,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 6,
  },
});

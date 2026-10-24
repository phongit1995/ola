import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { GestureDetector } from 'react-native-gesture-handler';
import { patchReelOverlay, raiseReelOverlay, removeReelOverlay } from '@ola/shared/lib';
import type { ReelDraftSlide, ReelOverlay } from '@ola/shared/types';
import { useOverlayGestures } from '../useOverlayGestures';
import {
  ReelCanvas,
  ReelOverlayBubble,
  ReelOverlayFrame,
  type ReelCanvasSize,
} from './ReelCanvas';
import { ReelTrashIcon, ReelVideoIcon } from './ReelIcons';

const TRASH_SIZE = 48;
const GUIDE_COLOR = 'rgba(255,255,255,0.8)';

type OverlayGestureFactory = ReturnType<typeof useOverlayGestures>['overlayGesture'];

function EditableOverlay({
  overlay,
  canvas,
  hidden,
  createGesture,
}: {
  overlay: ReelOverlay;
  canvas: ReelCanvasSize;
  hidden: boolean;
  createGesture: OverlayGestureFactory;
}) {
  const gesture = useMemo(() => createGesture(overlay.id), [createGesture, overlay.id]);
  return (
    <ReelOverlayFrame overlay={overlay} canvas={canvas}>
      <GestureDetector gesture={gesture}>
        <View style={{ opacity: hidden ? 0 : 1, transform: [{ rotate: `${overlay.rotation}deg` }] }}>
          <ReelOverlayBubble overlay={overlay} canvasWidth={canvas.width} />
        </View>
      </GestureDetector>
    </ReelOverlayFrame>
  );
}

interface ReelCanvasEditorProps {
  slide: ReelDraftSlide;
  width: number;
  height: number;
  editingId: string | null;
  onChange: (update: (slide: ReelDraftSlide) => ReelDraftSlide) => void;
  onEditingChange: (id: string | null) => void;
  onAddText: () => void;
  onMediaError: () => void;
}

export function ReelCanvasEditor({
  slide,
  width,
  height,
  editingId,
  onChange,
  onEditingChange,
  onAddText,
  onMediaError,
}: ReelCanvasEditorProps) {
  const { t } = useTranslation();
  const canvas = useMemo(() => ({ width, height }), [width, height]);

  const gestures = useOverlayGestures({
    overlays: slide.overlays,
    canvas,
    onUpdate: (id, patch) => onChange((current) => patchReelOverlay(current, id, patch)),
    onRemove: (id) => onChange((current) => removeReelOverlay(current, id)),
    onRaise: (id) => onChange((current) => raiseReelOverlay(current, id)),
    onTap: onEditingChange,
  });

  const showHandles = !gestures.dragging && editingId == null;

  return (
    <GestureDetector gesture={gestures.canvasGesture}>
      <View style={{ width, height, borderRadius: 12, overflow: 'hidden' }}>
        <ReelCanvas
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
            <ReelVideoIcon size={32} color="rgba(255,255,255,0.85)" />
            <Text className="text-center text-sm" style={{ color: 'rgba(255,255,255,0.85)' }}>
              {t('reel.videoNoPreview')}
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
        {showHandles && (
          <Pressable
            accessibilityRole="button"
            onPress={onAddText}
            className="flex-row items-center gap-1.5 rounded-full px-3"
            style={{ position: 'absolute', top: 12, right: 12, height: 40, backgroundColor: 'rgba(0,0,0,0.45)' }}
          >
            <Text style={{ color: '#ffffff', fontSize: 16, fontWeight: '600' }}>Aa</Text>
            <Text className="text-sm font-semibold" style={{ color: '#ffffff' }}>
              {t('reel.addText')}
            </Text>
          </Pressable>
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
              <ReelTrashIcon />
            </View>
            <Text
              className="rounded-full px-2 py-0.5 text-xs"
              style={{ color: '#ffffff', backgroundColor: 'rgba(0,0,0,0.4)', overflow: 'hidden' }}
            >
              {t('reel.dropToDelete')}
            </Text>
          </View>
        )}
      </View>
    </GestureDetector>
  );
}

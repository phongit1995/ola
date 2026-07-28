import { useState } from 'react';
import {
  ActivityIndicator,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Pressable,
  ScrollView,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Gesture, GestureDetector, GestureHandlerRootView } from 'react-native-gesture-handler';
import Animated, {
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
  withTiming,
} from 'react-native-reanimated';
import { toast } from '@ola/shared/lib';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import { saveImageToGallery } from '@lib/saveImage';
import { recordAppError } from '@lib/telemetry';
import { CachedImage } from './CachedImage';
import { CloseIcon } from './CloseIcon';
import { DownloadIcon } from './DownloadIcon';
import { OlaModal } from './OlaModal';
import { ToastHost } from './ToastHost';

const MAX_ZOOM = 6;
const DOUBLE_TAP_ZOOM = 2.5;

interface MediaViewerModalProps {
  images: string[];
  index: number;
  onClose: () => void;
}

function ZoomablePage({
  uri,
  width,
  height,
  onSingleTap,
  onZoomChange,
}: {
  uri: string;
  width: number;
  height: number;
  onSingleTap: () => void;
  onZoomChange: (zoomed: boolean) => void;
}) {
  const scale = useSharedValue(1);
  const savedScale = useSharedValue(1);
  const tx = useSharedValue(0);
  const ty = useSharedValue(0);
  const savedTx = useSharedValue(0);
  const savedTy = useSharedValue(0);
  const [zoomed, setZoomed] = useState(false);

  function syncZoomed(next: boolean) {
    setZoomed(next);
    onZoomChange(next);
  }

  const pinch = Gesture.Pinch()
    .onUpdate((e) => {
      scale.value = Math.min(MAX_ZOOM, Math.max(1, savedScale.value * e.scale));
    })
    .onEnd(() => {
      savedScale.value = scale.value;
      if (scale.value <= 1) {
        tx.value = withTiming(0);
        ty.value = withTiming(0);
        savedTx.value = 0;
        savedTy.value = 0;
      }
      runOnJS(syncZoomed)(scale.value > 1);
    });

  const pan = Gesture.Pan()
    .enabled(zoomed)
    .onUpdate((e) => {
      tx.value = savedTx.value + e.translationX;
      ty.value = savedTy.value + e.translationY;
    })
    .onEnd(() => {
      const maxX = (width * (scale.value - 1)) / 2;
      const maxY = (height * (scale.value - 1)) / 2;
      tx.value = withTiming(Math.min(maxX, Math.max(-maxX, tx.value)));
      ty.value = withTiming(Math.min(maxY, Math.max(-maxY, ty.value)));
      savedTx.value = Math.min(maxX, Math.max(-maxX, tx.value));
      savedTy.value = Math.min(maxY, Math.max(-maxY, ty.value));
    });

  const doubleTap = Gesture.Tap()
    .numberOfTaps(2)
    .onEnd(() => {
      if (scale.value > 1) {
        scale.value = withTiming(1);
        savedScale.value = 1;
        tx.value = withTiming(0);
        ty.value = withTiming(0);
        savedTx.value = 0;
        savedTy.value = 0;
        runOnJS(syncZoomed)(false);
      } else {
        scale.value = withTiming(DOUBLE_TAP_ZOOM);
        savedScale.value = DOUBLE_TAP_ZOOM;
        runOnJS(syncZoomed)(true);
      }
    });

  const singleTap = Gesture.Tap()
    .numberOfTaps(1)
    .requireExternalGestureToFail(doubleTap)
    .onEnd(() => {
      runOnJS(onSingleTap)();
    });

  const gesture = Gesture.Simultaneous(pinch, pan, Gesture.Exclusive(doubleTap, singleTap));

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: tx.value }, { translateY: ty.value }, { scale: scale.value }],
  }));

  return (
    <GestureDetector gesture={gesture}>
      <View style={{ width, height, overflow: 'hidden' }} className="items-center justify-center">
        <Animated.View style={[{ width, height }, animatedStyle]}>
          <CachedImage uri={uri} style={{ width, height }} resizeMode="contain" />
        </Animated.View>
      </View>
    </GestureDetector>
  );
}

export function MediaViewerModal(props: MediaViewerModalProps) {
  return (
    <OlaModal
      visible={props.images.length > 0}
      transparent
      statusBarTranslucent
      animationType="fade"
      onRequestClose={props.onClose}
    >
      <MediaViewerBody key={`${props.index}:${props.images[0] ?? ''}`} {...props} />
      <ToastHost />
    </OlaModal>
  );
}

function MediaViewerBody({ images, index, onClose }: MediaViewerModalProps) {
  const { width, height } = useWindowDimensions();
  const insets = useSafeAreaInsets();
  const { t } = useTranslation();
  const [current, setCurrent] = useState(index);
  const [saving, setSaving] = useState(false);
  const [zoomed, setZoomed] = useState(false);

  function onScroll(e: NativeSyntheticEvent<NativeScrollEvent>) {
    const next = Math.round(e.nativeEvent.contentOffset.x / width);
    if (next !== current) setCurrent(next);
  }

  async function onSave() {
    const uri = images[current];
    if (uri == null || saving) return;
    setSaving(true);
    try {
      const ok = await saveImageToGallery(uri);
      if (ok) toast.success(t('media.saved'));
      else toast.error(t('media.saveFailed'));
    } catch (error) {
      recordAppError(error, `saveImageToGallery: ${uri}`);
      toast.error(t('media.saveFailed'));
    } finally {
      setSaving(false);
    }
  }

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <View className="flex-1 bg-black">
        <ScrollView
          horizontal
          pagingEnabled
          scrollEnabled={!zoomed}
          showsHorizontalScrollIndicator={false}
          contentOffset={{ x: index * width, y: 0 }}
          onScroll={onScroll}
          scrollEventThrottle={16}
        >
          {images.map(uri => (
            <ZoomablePage
              key={uri}
              uri={uri}
              width={width}
              height={height}
              onSingleTap={onClose}
              onZoomChange={setZoomed}
            />
          ))}
        </ScrollView>
        {images.length > 1 && (
          <View
            pointerEvents="none"
            className="absolute left-0 right-0 items-center"
            style={{ top: insets.top + 16 }}
          >
            <Text className="overflow-hidden rounded-full bg-black/50 px-3 py-1 text-sm text-white">
              {current + 1} / {images.length}
            </Text>
          </View>
        )}
        <Pressable
          onPress={onSave}
          disabled={saving}
          accessibilityLabel={t('media.save')}
          className="absolute left-3 h-10 w-10 items-center justify-center rounded-full bg-white/15"
          style={{ top: insets.top + 8 }}
        >
          {saving ? <ActivityIndicator size="small" color="#ffffff" /> : <DownloadIcon />}
        </Pressable>
        <Pressable
          onPress={onClose}
          className="absolute right-3 h-10 w-10 items-center justify-center rounded-full bg-white/15"
          style={{ top: insets.top + 8 }}
        >
          <CloseIcon />
        </Pressable>
      </View>
    </GestureHandlerRootView>
  );
}

export function MediaViewer() {
  const images = useMediaViewerStore(s => s.images);
  const index = useMediaViewerStore(s => s.index);
  const close = useMediaViewerStore(s => s.close);
  return <MediaViewerModal images={images} index={index} onClose={close} />;
}

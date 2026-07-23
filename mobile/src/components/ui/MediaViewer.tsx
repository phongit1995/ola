import { useState } from 'react';
import {
  ActivityIndicator,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Pressable,
  ScrollView,
  useWindowDimensions,
  View,
} from 'react-native';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { toast } from '@ola/shared/lib';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import { saveImageToGallery } from '@lib/saveImage';
import { CachedImage } from './CachedImage';
import { CloseIcon } from './CloseIcon';
import { DownloadIcon } from './DownloadIcon';
import { OlaModal } from './OlaModal';

interface MediaViewerModalProps {
  images: string[];
  index: number;
  onClose: () => void;
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
    </OlaModal>
  );
}

function MediaViewerBody({ images, index, onClose }: MediaViewerModalProps) {
  const { width, height } = useWindowDimensions();
  const insets = useSafeAreaInsets();
  const { t } = useTranslation();
  const [current, setCurrent] = useState(index);
  const [saving, setSaving] = useState(false);

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
    } catch {
      toast.error(t('media.saveFailed'));
    } finally {
      setSaving(false);
    }
  }

  return (
    <View className="flex-1 bg-black">
      <ScrollView
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        contentOffset={{ x: index * width, y: 0 }}
        onScroll={onScroll}
        scrollEventThrottle={16}
      >
        {images.map(uri => (
          <Pressable
            key={uri}
            onPress={onClose}
            style={{ width, height }}
            className="items-center justify-center"
          >
            <CachedImage
              uri={uri}
              style={{ width, height }}
              resizeMode="contain"
            />
          </Pressable>
        ))}
      </ScrollView>
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
  );
}

export function MediaViewer() {
  const images = useMediaViewerStore(s => s.images);
  const index = useMediaViewerStore(s => s.index);
  const close = useMediaViewerStore(s => s.close);
  return <MediaViewerModal images={images} index={index} onClose={close} />;
}

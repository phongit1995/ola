import { Image, Modal, Pressable, ScrollView, useWindowDimensions, View } from 'react-native';
import { useSafeInsets } from '../hooks/useSafeInsets';
import { Text } from 'react-native';
import { useMediaViewerStore } from '../store/mediaViewerStore';

export function MediaViewerModal({
  images,
  index,
  onClose,
}: {
  images: string[];
  index: number;
  onClose: () => void;
}) {
  const { width, height } = useWindowDimensions();
  const insets = useSafeInsets();
  const visible = images.length > 0;

  return (
    <Modal visible={visible} transparent statusBarTranslucent animationType="fade" onRequestClose={onClose}>
      <View className="flex-1 bg-black">
        <ScrollView
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          contentOffset={{ x: index * width, y: 0 }}
        >
          {images.map((uri) => (
            <Pressable key={uri} onPress={onClose} style={{ width, height }} className="items-center justify-center">
              <Image source={{ uri }} style={{ width, height }} resizeMode="contain" />
            </Pressable>
          ))}
        </ScrollView>
        <Pressable
          onPress={onClose}
          className="absolute right-3 h-10 w-10 items-center justify-center rounded-full bg-white/15"
          style={{ top: insets.top + 8 }}
        >
          <Text className="text-2xl leading-none text-white">×</Text>
        </Pressable>
      </View>
    </Modal>
  );
}

export function MediaViewer() {
  const images = useMediaViewerStore((s) => s.images);
  const index = useMediaViewerStore((s) => s.index);
  const close = useMediaViewerStore((s) => s.close);
  return <MediaViewerModal images={images} index={index} onClose={close} />;
}

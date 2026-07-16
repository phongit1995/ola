import {
  Image,
  Pressable,
  ScrollView,
  useWindowDimensions,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useMediaViewerStore } from '../store/mediaViewerStore';
import { CloseIcon } from './CloseIcon';
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
      <MediaViewerBody {...props} />
    </OlaModal>
  );
}

function MediaViewerBody({ images, index, onClose }: MediaViewerModalProps) {
  const { width, height } = useWindowDimensions();
  const insets = useSafeAreaInsets();

  return (
    <View className="flex-1 bg-black">
      <ScrollView
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        contentOffset={{ x: index * width, y: 0 }}
      >
        {images.map(uri => (
          <Pressable
            key={uri}
            onPress={onClose}
            style={{ width, height }}
            className="items-center justify-center"
          >
            <Image
              source={{ uri }}
              style={{ width, height }}
              resizeMode="contain"
            />
          </Pressable>
        ))}
      </ScrollView>
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

import { Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

export interface MePostMenuOption {
  key: string;
  label: string;
  danger?: boolean;
  onSelect: () => void;
}

interface MePostMenuProps {
  visible: boolean;
  title: string;
  options: MePostMenuOption[];
  onClose: () => void;
}

export function MePostMenu({ visible, title, options, onClose }: MePostMenuProps) {
  const insets = useSafeAreaInsets();

  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <Pressable className="flex-1 justify-end bg-black/40" onPress={onClose}>
        <Pressable
          className="rounded-t-2xl bg-white pt-2"
          style={{ paddingBottom: insets.bottom + 8 }}
          onPress={(event) => event.stopPropagation()}
        >
          <View className="items-center pb-1">
            <View className="h-1 w-10 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.15)' }} />
          </View>
          <Text
            className="px-5 py-3 text-center text-sm font-semibold"
            style={{ color: 'rgba(0,0,0,0.54)' }}
          >
            {title}
          </Text>
          {options.map((option) => (
            <Pressable
              key={option.key}
              onPress={() => {
                onClose();
                option.onSelect();
              }}
              className="px-5 py-4 active:bg-black/5"
              style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' }}
            >
              <Text
                className="text-center text-sm"
                style={{ color: option.danger ? '#dd4b39' : 'rgba(0,0,0,0.87)' }}
              >
                {option.label}
              </Text>
            </Pressable>
          ))}
        </Pressable>
      </Pressable>
    </Modal>
  );
}

import { Modal, Pressable, ScrollView, Text, View } from 'react-native';

export interface ListOption {
  key: string;
  label: string;
  danger?: boolean;
  onSelect: () => void;
}

interface ListOptionDialogProps {
  visible: boolean;
  title: string;
  options: ListOption[];
  onClose: () => void;
}

export function ListOptionDialog({ visible, title, options, onClose }: ListOptionDialogProps) {
  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <Pressable
        className="flex-1 items-center justify-center p-4"
        style={{ backgroundColor: 'rgba(0,0,0,0.6)' }}
        onPress={onClose}
      >
        <Pressable
          className="w-full overflow-hidden bg-white"
          style={{
            minWidth: 280,
            maxWidth: 384,
            borderRadius: 5,
            shadowColor: '#000',
            shadowOpacity: 0.35,
            shadowRadius: 24,
            shadowOffset: { width: 0, height: 6 },
            elevation: 8,
          }}
          onPress={() => undefined}
        >
          <View
            className="flex-row items-center px-2 py-1"
            style={{
              minHeight: 38,
              backgroundColor: '#ebebeb',
              borderBottomWidth: 1,
              borderBottomColor: '#d1cece',
            }}
          >
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1 text-xl font-bold"
              style={{ color: '#3a3839' }}
            >
              {title}
            </Text>
          </View>
          <ScrollView style={{ maxHeight: 400 }}>
            {options.map((option, index) => (
              <Pressable
                key={option.key}
                onPress={() => {
                  option.onSelect();
                  onClose();
                }}
                className="px-4 py-3 active:bg-black/5"
                style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
              >
                <Text
                  className="text-sm"
                  style={{ color: option.danger ? '#dd4b39' : 'rgba(0,0,0,0.87)' }}
                >
                  {option.label}
                </Text>
              </Pressable>
            ))}
          </ScrollView>
        </Pressable>
      </Pressable>
    </Modal>
  );
}

import { useCallback, useRef } from 'react';
import { Platform, Pressable, ScrollView, Text } from 'react-native';
import { Dialog } from './Dialog';

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
  const pendingActionRef = useRef<(() => void) | null>(null);

  const runPendingAction = useCallback(() => {
    const action = pendingActionRef.current;
    pendingActionRef.current = null;
    action?.();
  }, []);

  const selectOption = useCallback(
    (action: () => void) => {
      if (pendingActionRef.current != null) return;
      pendingActionRef.current = action;
      onClose();
      if (Platform.OS !== 'ios') requestAnimationFrame(runPendingAction);
    },
    [onClose, runPendingAction]
  );

  return (
    <Dialog visible={visible} onClose={onClose} onDismiss={runPendingAction} title={title}>
      <ScrollView style={{ maxHeight: 400, marginHorizontal: -8, marginVertical: -4 }}>
        {options.map((option, index) => (
          <Pressable
            key={option.key}
            onPress={() => selectOption(option.onSelect)}
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
    </Dialog>
  );
}

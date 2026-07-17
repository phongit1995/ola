import { useEffect } from 'react';
import { Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useToastStore, type ToastItem, type ToastType } from '@ola/shared/stores/toastStore';

const AUTO_DISMISS_MS = 3000;

const backgroundByType: Record<ToastType, string> = {
  error: '#e53935',
  success: '#558b2f',
  info: 'rgba(0,0,0,0.8)',
};

function ToastRow({ toast, onDismiss }: { toast: ToastItem; onDismiss: (id: number) => void }) {
  useEffect(() => {
    const timer = setTimeout(() => onDismiss(toast.id), AUTO_DISMISS_MS);
    return () => clearTimeout(timer);
  }, [toast.id, onDismiss]);

  return (
    <Pressable
      onPress={() => onDismiss(toast.id)}
      className="max-w-[90%] rounded-full px-4 py-2"
      style={{ backgroundColor: backgroundByType[toast.type] }}
    >
      <Text className="text-center text-sm text-white">{toast.message}</Text>
    </Pressable>
  );
}

export function ToastHost() {
  const insets = useSafeAreaInsets();
  const toasts = useToastStore((state) => state.toasts);
  const dismiss = useToastStore((state) => state.dismiss);

  if (toasts.length === 0) return null;

  return (
    <View
      pointerEvents="box-none"
      className="absolute inset-x-0 items-center gap-2 px-4"
      style={{ bottom: insets.bottom + 80 }}
    >
      {toasts.map((item) => (
        <ToastRow key={item.id} toast={item} onDismiss={dismiss} />
      ))}
    </View>
  );
}

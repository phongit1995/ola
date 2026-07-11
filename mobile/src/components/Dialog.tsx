import type { ReactNode } from 'react';
import {
  Image,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  Text,
  View,
  type ImageSourcePropType,
} from 'react-native';

interface DialogProps {
  visible: boolean;
  onClose: () => void;
  title?: string;
  icon?: ImageSourcePropType;
  showClose?: boolean;
  dismissOnBackdrop?: boolean;
  children: ReactNode;
  footer?: ReactNode;
}

export function Dialog({
  visible,
  onClose,
  title,
  icon,
  showClose = false,
  dismissOnBackdrop = true,
  children,
  footer,
}: DialogProps) {
  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <KeyboardAvoidingView
        className="flex-1"
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      >
        <Pressable
          className="flex-1 items-center justify-center p-4"
          style={{ backgroundColor: 'rgba(0,0,0,0.6)' }}
          onPress={dismissOnBackdrop ? onClose : undefined}
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
            {title != null && (
              <View
                className="flex-row items-center px-2 py-1"
                style={{
                  minHeight: 38,
                  gap: 5,
                  backgroundColor: '#ebebeb',
                  borderBottomWidth: 1,
                  borderBottomColor: '#d1cece',
                }}
              >
                {icon != null && (
                  <View className="items-center justify-center" style={{ width: 34, height: 34 }}>
                    <Image source={icon} style={{ width: 30, height: 32 }} resizeMode="contain" />
                  </View>
                )}
                <Text
                  numberOfLines={1}
                  className="min-w-0 flex-1 text-xl font-bold"
                  style={{ color: '#3a3839' }}
                >
                  {title}
                </Text>
                {showClose && (
                  <Pressable
                    onPress={onClose}
                    className="h-8 w-8 items-center justify-center rounded active:bg-black/10"
                    style={{ marginRight: -4 }}
                  >
                    <Text className="text-base font-semibold" style={{ color: '#3a3839' }}>
                      ✕
                    </Text>
                  </Pressable>
                )}
              </View>
            )}
            <View className="m-2" style={{ minHeight: 50 }}>
              {children}
            </View>
            {footer != null && <View className="flex-row gap-2 px-1 pb-2">{footer}</View>}
          </Pressable>
        </Pressable>
      </KeyboardAvoidingView>
    </Modal>
  );
}

type DialogButtonVariant = 'default' | 'green' | 'danger';

interface DialogButtonProps {
  variant?: DialogButtonVariant;
  disabled?: boolean;
  onPress: () => void;
  children: string;
}

const dialogButtonBox: Record<DialogButtonVariant, object> = {
  default: { backgroundColor: '#ffffff', borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)' },
  green: { backgroundColor: '#9ccc65', borderWidth: 1, borderColor: '#558b2f' },
  danger: { backgroundColor: '#dd4b39' },
};

const dialogButtonText: Record<DialogButtonVariant, string> = {
  default: 'rgba(0,0,0,0.87)',
  green: '#ffffff',
  danger: '#ffffff',
};

export function DialogButton({
  variant = 'default',
  disabled = false,
  onPress,
  children,
}: DialogButtonProps) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="flex-1 items-center justify-center px-1 active:opacity-90"
      style={[
        { minHeight: 28, borderRadius: 2, paddingVertical: 5, opacity: disabled ? 0.5 : 1 },
        dialogButtonBox[variant],
      ]}
    >
      <Text className="text-sm" style={{ color: dialogButtonText[variant] }}>
        {children}
      </Text>
    </Pressable>
  );
}

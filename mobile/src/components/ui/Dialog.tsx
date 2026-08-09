import type { ReactNode } from 'react';
import {
  Image,
  Modal,
  Pressable,
  Text,
  View,
  type ImageSourcePropType,
} from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { KeyboardView } from '../KeyboardView';

interface DialogProps {
  visible: boolean;
  onClose: () => void;
  onDismiss?: () => void;
  title?: string;
  icon?: ImageSourcePropType;
  showClose?: boolean;
  dismissOnBackdrop?: boolean;
  avoidKeyboard?: boolean;
  bare?: boolean;
  maxWidth?: number;
  children: ReactNode;
  footer?: ReactNode;
}

export function Dialog({
  visible,
  onClose,
  onDismiss,
  title,
  icon,
  showClose = false,
  dismissOnBackdrop = true,
  avoidKeyboard = true,
  bare = false,
  maxWidth = 384,
  children,
  footer,
}: DialogProps) {
  const Body = avoidKeyboard ? KeyboardView : View;
  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onClose}
      onDismiss={onDismiss}
    >
      <Pressable
        className="absolute inset-0"
        style={{ backgroundColor: 'rgba(0,0,0,0.6)' }}
        onPress={dismissOnBackdrop ? onClose : undefined}
      />
      <Body className="flex-1" pointerEvents="box-none">
        <View
          className="flex-1 items-center justify-center p-4"
          pointerEvents="box-none"
        >
          <View
            className={bare ? 'w-full' : 'w-full overflow-hidden bg-white'}
            style={
              bare
                ? { maxWidth, maxHeight: '100%' }
                : {
                    minWidth: 280,
                    maxWidth,
                    maxHeight: '100%',
                    borderRadius: 5,
                    shadowColor: '#000',
                    shadowOpacity: 0.35,
                    shadowRadius: 24,
                    shadowOffset: { width: 0, height: 6 },
                    elevation: 8,
                  }
            }
          >
            {bare && children}
            {!bare && title != null && (
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
            {!bare && (
              <View className="m-2" style={{ minHeight: 50, flexShrink: 1 }}>
                {children}
              </View>
            )}
            {!bare && footer != null && (
              <View className="flex-row gap-2 px-1 pb-2">{footer}</View>
            )}
          </View>
        </View>
      </Body>
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

const dialogButtonBox: Record<Exclude<DialogButtonVariant, 'green'>, object> = {
  default: { backgroundColor: '#ffffff', borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)' },
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
  const colors = useThemeColors();
  const boxStyle =
    variant === 'green'
      ? { backgroundColor: colors.button, borderWidth: 1, borderColor: colors.primaryDark }
      : dialogButtonBox[variant];
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="flex-1 items-center justify-center px-1 active:opacity-90"
      style={[
        { minHeight: 28, borderRadius: 2, paddingVertical: 5, opacity: disabled ? 0.5 : 1 },
        boxStyle,
      ]}
    >
      <Text className="text-sm" style={{ color: dialogButtonText[variant] }}>
        {children}
      </Text>
    </Pressable>
  );
}

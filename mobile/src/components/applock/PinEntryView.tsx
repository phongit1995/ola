import { useEffect, useRef, useState, type ReactNode } from 'react';
import { Animated, Image, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useThemeColors } from '@hooks/useThemeColors';
import { PIN_LENGTH, type BiometryType } from '@lib/appLock';
import { APP_LOCK_ICONS } from '@lib/appLockImages';
import { PinKeypad } from './PinKeypad';

const closeIcon = require('@assets/icons/ic_close.png');
const SUBMIT_DELAY_MS = 120;

interface PinEntryViewProps {
  title: string;
  subtitle?: string;
  errorText?: string | null;
  disabled?: boolean;
  biometryType?: BiometryType;
  onBiometric?: () => void;
  onSubmit: (pin: string) => boolean | Promise<boolean>;
  onCancel?: () => void;
  resetKey?: string | number;
  footer?: ReactNode;
}

export function PinEntryView({
  title,
  subtitle,
  errorText,
  disabled = false,
  biometryType = '',
  onBiometric,
  onSubmit,
  onCancel,
  resetKey,
  footer,
}: PinEntryViewProps) {
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();
  const [pin, setPin] = useState('');
  const [shaking, setShaking] = useState(false);
  const shake = useRef(new Animated.Value(0)).current;
  const submittingRef = useRef(false);
  const submitTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    setPin('');
  }, [resetKey]);

  useEffect(
    () => () => {
      if (submitTimerRef.current != null) clearTimeout(submitTimerRef.current);
    },
    []
  );

  function runShake() {
    setShaking(true);
    shake.setValue(0);
    Animated.sequence([
      Animated.timing(shake, { toValue: 12, duration: 50, useNativeDriver: true }),
      Animated.timing(shake, { toValue: -12, duration: 50, useNativeDriver: true }),
      Animated.timing(shake, { toValue: 8, duration: 50, useNativeDriver: true }),
      Animated.timing(shake, { toValue: -8, duration: 50, useNativeDriver: true }),
      Animated.timing(shake, { toValue: 0, duration: 50, useNativeDriver: true }),
    ]).start(() => setShaking(false));
  }

  function handleDigit(digit: string) {
    if (disabled || submittingRef.current || pin.length >= PIN_LENGTH) return;
    const next = pin + digit;
    setPin(next);
    if (next.length < PIN_LENGTH) return;
    submittingRef.current = true;
    submitTimerRef.current = setTimeout(() => {
      submitTimerRef.current = null;
      void Promise.resolve(onSubmit(next)).then((ok) => {
        submittingRef.current = false;
        setPin('');
        if (!ok) runShake();
      });
    }, SUBMIT_DELAY_MS);
  }

  function cancel() {
    if (submitTimerRef.current != null) {
      clearTimeout(submitTimerRef.current);
      submitTimerRef.current = null;
      submittingRef.current = false;
    }
    onCancel?.();
  }

  function handleBackspace() {
    if (submittingRef.current) return;
    setPin((current) => current.slice(0, -1));
  }

  const showError = errorText != null && errorText !== '';

  return (
    <View
      className="flex-1"
      style={{
        backgroundColor: colors.primary,
        paddingTop: insets.top,
        paddingBottom: Math.max(insets.bottom, 16),
      }}
    >
      <View className="h-12 flex-row items-center px-2">
        {onCancel != null && (
          <Pressable
            onPress={cancel}
            hitSlop={8}
            accessibilityRole="button"
            className="h-10 w-10 items-center justify-center rounded-full active:bg-white/15"
          >
            <Image
              source={closeIcon}
              style={{ width: 20, height: 20, tintColor: '#ffffff' }}
              resizeMode="contain"
            />
          </Pressable>
        )}
      </View>
      <View className="flex-1 items-center justify-center px-6">
        <Image
          source={APP_LOCK_ICONS.lock}
          style={{ width: 56, height: 56, opacity: 0.95 }}
          resizeMode="contain"
        />
        <Text className="mt-4 text-center text-xl font-bold text-white">{title}</Text>
        {subtitle != null && subtitle !== '' && (
          <Text className="mt-1 text-center text-sm text-white/80">{subtitle}</Text>
        )}
        <Animated.View
          className="mt-8 flex-row"
          style={{ gap: 18, transform: [{ translateX: shake }] }}
        >
          {Array.from({ length: PIN_LENGTH }, (_, index) => {
            const filled = index < pin.length;
            return (
              <View
                key={index}
                className="rounded-full"
                style={{
                  width: 16,
                  height: 16,
                  borderWidth: 2,
                  borderColor: shaking ? '#ffb4b4' : '#ffffff',
                  backgroundColor: filled ? (shaking ? '#ffb4b4' : '#ffffff') : 'transparent',
                }}
              />
            );
          })}
        </Animated.View>
        <Text
          className="mt-4 min-h-[20px] text-center text-sm"
          style={{ color: showError ? '#ffe0e0' : 'transparent' }}
        >
          {showError ? errorText : ' '}
        </Text>
      </View>
      <View className="items-center pb-4">
        <PinKeypad
          disabled={disabled}
          biometryType={biometryType}
          onDigit={handleDigit}
          onBackspace={handleBackspace}
          onBiometric={onBiometric}
        />
        <View className="mt-6 min-h-[24px] items-center">{footer}</View>
      </View>
    </View>
  );
}

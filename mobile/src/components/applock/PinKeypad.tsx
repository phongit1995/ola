import { Image, Pressable, Text, View } from 'react-native';
import { hapticImpact } from '@lib/haptics';
import type { BiometryType } from '@lib/appLock';
import { APP_LOCK_ICONS, biometryIcon } from '@lib/appLockImages';

const KEY_SIZE = 72;
const KEY_GAP = 18;
const KEY_ROWS = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
] as const;

interface PinKeypadProps {
  disabled?: boolean;
  biometryType?: BiometryType;
  onDigit: (digit: string) => void;
  onBackspace: () => void;
  onBiometric?: () => void;
}

function Key({
  label,
  icon,
  disabled,
  onPress,
}: {
  label?: string;
  icon?: number;
  disabled?: boolean;
  onPress?: () => void;
}) {
  const empty = onPress == null;
  return (
    <Pressable
      disabled={disabled || empty}
      onPress={() => {
        hapticImpact();
        onPress?.();
      }}
      accessibilityRole="button"
      accessibilityLabel={label}
      className="items-center justify-center rounded-full active:opacity-60"
      style={{
        width: KEY_SIZE,
        height: KEY_SIZE,
        backgroundColor: empty || label == null ? 'transparent' : 'rgba(255,255,255,0.16)',
        opacity: disabled ? 0.4 : 1,
      }}
    >
      {label != null && (
        <Text style={{ fontSize: 30, lineHeight: 36, color: '#ffffff', fontWeight: '500' }}>
          {label}
        </Text>
      )}
      {icon != null && (
        <Image source={icon} style={{ width: 34, height: 34 }} resizeMode="contain" />
      )}
    </Pressable>
  );
}

export function PinKeypad({
  disabled = false,
  biometryType = '',
  onDigit,
  onBackspace,
  onBiometric,
}: PinKeypadProps) {
  const showBiometric = onBiometric != null && biometryType !== '';
  return (
    <View style={{ gap: KEY_GAP }}>
      {KEY_ROWS.map((row) => (
        <View key={row[0]} className="flex-row" style={{ gap: KEY_GAP }}>
          {row.map((digit) => (
            <Key key={digit} label={digit} disabled={disabled} onPress={() => onDigit(digit)} />
          ))}
        </View>
      ))}
      <View className="flex-row" style={{ gap: KEY_GAP }}>
        <Key
          icon={showBiometric ? (biometryIcon(biometryType) as number) : undefined}
          disabled={disabled}
          onPress={showBiometric ? onBiometric : undefined}
        />
        <Key label="0" disabled={disabled} onPress={() => onDigit('0')} />
        <Key icon={APP_LOCK_ICONS.backspace as number} disabled={disabled} onPress={onBackspace} />
      </View>
    </View>
  );
}

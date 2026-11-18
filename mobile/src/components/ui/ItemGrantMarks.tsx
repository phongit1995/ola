import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View, type StyleProp, type TextStyle } from 'react-native';
import { formatItemExpiryTime, toast, type LockableItem } from '@ola/shared/lib';
import { useItemExpiry } from '@ola/shared/stores/useItemExpiry';
import { ITEM_GRANT_ICONS, type ItemGrantIconKind } from '@assets/itemGrantIcons';
import { ERROR, TEXT_SECONDARY, WARNING_INK, WARNING_SOFT } from '@constants';

const ITEM_GRANT_ICON_OPACITY = 0.55;

export function ItemGrantIcon({ kind, size = 14 }: { kind: ItemGrantIconKind; size?: number }) {
  return <Image source={ITEM_GRANT_ICONS[kind]} style={{ width: size, height: size, opacity: ITEM_GRANT_ICON_OPACITY }} resizeMode="contain" />;
}

export function ItemLockButton({ message, size = 14 }: { message: string; size?: number }) {
  return (
    <Pressable
      onPress={() => toast.info(message)}
      hitSlop={8}
      accessibilityRole="button"
      accessibilityLabel={message}
    >
      <ItemGrantIcon kind="lock" size={size} />
    </Pressable>
  );
}

export function ItemCountdown({ expiresAt, style }: { expiresAt?: string | null; style?: StyleProp<TextStyle> }) {
  const { label, soon } = useItemExpiry(expiresAt);
  if (label == null) return null;
  return (
    <Text
      numberOfLines={1}
      style={[
        { color: soon ? ERROR : TEXT_SECONDARY, fontWeight: soon ? '600' : '400', fontVariant: ['tabular-nums'] },
        style,
      ]}
    >
      {label}
    </Text>
  );
}

export function ItemExpiryText({ item }: { item: LockableItem }) {
  const { label, soon } = useItemExpiry(item.expiresAt);
  if (label == null) return null;
  return (
    <View className="w-full flex-row items-center justify-center" style={{ gap: 2 }}>
      <ItemGrantIcon kind="clock" size={11} />
      <Text
        numberOfLines={1}
        style={{
          fontSize: 10,
          color: soon ? ERROR : TEXT_SECONDARY,
          fontWeight: soon ? '600' : '400',
          fontVariant: ['tabular-nums'],
        }}
      >
        {label}
      </Text>
    </View>
  );
}

export function ItemExpiryNotice({ expiresAt }: { expiresAt?: string | null }) {
  const { t } = useTranslation();
  const { label } = useItemExpiry(expiresAt);
  const time = formatItemExpiryTime(expiresAt);
  if (label == null || time == null) return null;
  return (
    <View
      className="mt-2 flex-row items-center rounded-md px-2.5 py-1.5"
      style={{ backgroundColor: WARNING_SOFT, gap: 6 }}
    >
      <ItemGrantIcon kind="clock" size={14} />
      <Text style={{ flex: 1, fontSize: 13, color: WARNING_INK, fontVariant: ['tabular-nums'] }}>
        {t('itemExpiry.notice', { time, left: label })}
      </Text>
    </View>
  );
}

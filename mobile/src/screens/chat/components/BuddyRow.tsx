import { Image, Pressable, Text, View } from 'react-native';
import { VipAvatar } from '@components/ui/VipAvatar';
import { CachedImage } from '@components/ui/CachedImage';
import type { Contact } from '../contacts';
import { DEVICE_ICONS } from '@lib/deviceIcons';
import { DIVIDER } from '@constants';

const birthdayIcon = require('@assets/icons/chat/ic_buddy_birthday.png');
function SquareAvatar({ name, color, uri, size = 40 }: { name: string; color: string; uri?: string; size?: number }) {
  const style = { width: size, height: size, borderRadius: 4 } as const;
  if (uri != null && uri !== '') {
    return <CachedImage uri={uri} style={style} />;
  }
  const initial = name.trim().charAt(0).toUpperCase() || '?';
  return (
    <View className="items-center justify-center" style={[style, { backgroundColor: color }]}>
      <Text className="font-semibold text-white" style={{ fontSize: size * 0.4 }}>
        {initial}
      </Text>
    </View>
  );
}

interface BuddyRowProps {
  contact: Contact;
  highlight: boolean;
  onSelect: () => void;
  onLongPress: () => void;
  onOpenProfile?: () => void;
  onPreviewImage?: (url: string) => void;
}

export function BuddyRow({ contact, highlight, onSelect, onLongPress, onOpenProfile, onPreviewImage }: BuddyRowProps) {
  const showVip = contact.online && contact.vip;
  const badge =
    contact.group === 'birthday'
      ? birthdayIcon
      : contact.online
        ? DEVICE_ICONS[contact.deviceType]
        : null;

  return (
    <Pressable
      onPress={onSelect}
      onLongPress={onLongPress}
      delayLongPress={400}
      className="flex-row items-center px-4 py-3"
      style={{ backgroundColor: highlight ? '#f1f8e9' : '#fff', borderBottomWidth: 1, borderBottomColor: DIVIDER }}
    >
      <Pressable
        className="shrink-0"
        style={{ position: 'relative', width: 40, height: 40 }}
        onPress={onOpenProfile ?? onSelect}
      >
        <SquareAvatar name={contact.name} color={contact.color} uri={contact.avatar} />
        {badge != null && (
          <View
            className="items-center justify-center bg-ola-primary"
            style={{
              position: 'absolute',
              right: 0,
              bottom: 0,
              width: 14,
              height: 14,
              borderRadius: 7,
              borderWidth: 1,
              borderColor: '#fff',
            }}
          >
            <Image source={badge} style={{ width: 10, height: 10 }} resizeMode="contain" />
          </View>
        )}
      </Pressable>
      <View className="ml-4 min-w-0 flex-1">
        <Pressable
          className="max-w-full flex-row items-center gap-1"
          onPress={onOpenProfile ?? onSelect}
        >
          {showVip && <VipAvatar typeId={contact.vipTypeId} size={20} />}
          <Text className="shrink text-base text-ola-ink" numberOfLines={1}>
            {contact.name}
            {contact.fullName != null && contact.fullName !== '' && (
              <Text style={{ color: 'rgba(0,0,0,0.45)' }}> · {contact.fullName}</Text>
            )}
          </Text>
        </Pressable>
        {contact.status != null && contact.status !== '' && (
          <Text className="text-xs text-ola-ink-soft" numberOfLines={1}>
            {contact.status}
          </Text>
        )}
      </View>
      {!contact.online && contact.lastActive != null && contact.lastActive !== '' && (
        <Text className="ml-2 text-xs text-ola-ink-soft">
          {contact.lastActive}
        </Text>
      )}
      {contact.statusImage != null && contact.statusImage !== '' && (
        <Pressable className="ml-2" onPress={() => onPreviewImage?.(contact.statusImage!)}>
          <CachedImage
            uri={contact.statusImage}
            style={{ width: 40, height: 40, borderRadius: 4, borderWidth: 1, borderColor: DIVIDER }}
          />
        </Pressable>
      )}
    </Pressable>
  );
}

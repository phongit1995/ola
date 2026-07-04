import { Image, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import { VipAvatar } from '../../components/VipAvatar';
import { DEVICE_ICONS, type Contact } from './contacts';

const birthdayIcon = require('../../assets/icons/chat/ic_buddy_birthday.png');
const DIVIDER = 'rgba(0,0,0,0.12)';

function SquareAvatar({ name, color, uri, size = 40 }: { name: string; color: string; uri?: string; size?: number }) {
  const style = { width: size, height: size, borderRadius: 4 } as const;
  if (uri != null && uri !== '') {
    return <Image source={{ uri }} style={style} />;
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
      <Pressable className="relative h-10 w-10 shrink-0" onPress={onOpenProfile ?? onSelect}>
        <SquareAvatar name={contact.name} color={contact.color} uri={contact.avatar} />
        {badge != null && (
          <View
            className="absolute bottom-0 right-0 h-3.5 w-3.5 items-center justify-center rounded-full bg-ola-primary"
            style={{ borderWidth: 1, borderColor: '#fff' }}
          >
            <Image source={badge} style={{ width: 10, height: 10 }} resizeMode="contain" />
          </View>
        )}
      </Pressable>
      <View className="ml-4 min-w-0 flex-1">
        <View className="flex-row items-center gap-1">
          {showVip && <VipAvatar typeId={contact.vipTypeId} size={20} />}
          <Text className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }} numberOfLines={1}>
            {contact.name}
            {contact.fullName != null && contact.fullName !== '' && (
              <Text style={{ color: 'rgba(0,0,0,0.45)' }}> · {contact.fullName}</Text>
            )}
          </Text>
        </View>
        {contact.status != null && contact.status !== '' && (
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }} numberOfLines={1}>
            {contact.status}
          </Text>
        )}
      </View>
      {!contact.online && contact.lastActive != null && contact.lastActive !== '' && (
        <Text className="ml-2 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {contact.lastActive}
        </Text>
      )}
      {contact.statusImage != null && contact.statusImage !== '' && (
        <Pressable className="ml-2" onPress={() => onPreviewImage?.(contact.statusImage!)}>
          <Image
            source={{ uri: contact.statusImage }}
            style={{ width: 40, height: 40, borderRadius: 4, borderWidth: 1, borderColor: DIVIDER }}
          />
        </Pressable>
      )}
    </Pressable>
  );
}

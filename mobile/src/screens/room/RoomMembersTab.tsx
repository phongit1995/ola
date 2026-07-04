import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import type { RoomMember } from '@ola/shared/types';
import { VipAvatar } from '../../components/VipAvatar';

const maleIcon = require('../../assets/icons/chat/ic_indicate_male.png');
const femaleIcon = require('../../assets/icons/chat/ic_indicate_female.png');

interface RoomMembersTabProps {
  members: RoomMember[];
  onOpenUser?: (userId: string) => void;
}

function GenderIcon({ gender }: { gender: RoomMember['gender'] }) {
  if (gender == null) return null;
  return (
    <Image
      source={gender === 'female' ? femaleIcon : maleIcon}
      style={{ width: 16, height: 16 }}
      resizeMode="contain"
    />
  );
}

function MemberRow({
  member,
  onOpenUser,
}: {
  member: RoomMember;
  onOpenUser?: (userId: string) => void;
}) {
  const subName =
    member.fullName != null && member.fullName !== '' && member.fullName !== member.username
      ? member.fullName
      : null;
  return (
    <Pressable
      onPress={() => onOpenUser?.(member.userId)}
      className="flex-row items-center gap-2 px-4 py-3 active:bg-black/5"
      style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
    >
      <GenderIcon gender={member.gender} />
      <VipAvatar typeId={member.vipTypeId} size={40} />
      <View className="min-w-0 flex-1">
        <View className="flex-row items-center gap-1">
          <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {member.username}
          </Text>
          {subName != null && (
            <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {subName}
            </Text>
          )}
        </View>
        {member.bio != null && member.bio !== '' && (
          <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {member.bio}
          </Text>
        )}
      </View>
    </Pressable>
  );
}

export function RoomMembersTab({ members, onOpenUser }: RoomMembersTabProps) {
  const { t } = useTranslation();
  if (members.length === 0) {
    return (
      <View className="flex-1 items-center justify-center bg-white px-8">
        <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('room.noMembers')}
        </Text>
      </View>
    );
  }
  return (
    <View className="flex-1 bg-white">
      <FlashList
        data={members}
        keyExtractor={(item) => item.userId}
        renderItem={({ item }) => <MemberRow member={item} onOpenUser={onOpenUser} />}
      />
    </View>
  );
}

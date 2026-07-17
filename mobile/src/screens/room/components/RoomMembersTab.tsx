import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Modal, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import type { RoomMember } from '@ola/shared/types';
import { VipAvatar } from '@components/ui/VipAvatar';
import { DEVICE_ICONS, normalizeDevice } from '@lib/deviceIcons';

const maleIcon = require('@assets/icons/chat/ic_indicate_male.png');
const femaleIcon = require('@assets/icons/chat/ic_indicate_female.png');

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
  onViewImage,
}: {
  member: RoomMember;
  onOpenUser?: (userId: string) => void;
  onViewImage: (uri: string) => void;
}) {
  const subName =
    member.fullName != null && member.fullName !== '' && member.fullName !== member.username
      ? member.fullName
      : null;
  const bioImage = member.bioImage != null && member.bioImage !== '' ? member.bioImage : null;
  return (
    <Pressable
      onPress={() => onOpenUser?.(member.userId)}
      className="flex-row items-center gap-2 px-4 py-3 active:bg-black/5"
      style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
    >
      <GenderIcon gender={member.gender} />
      <View style={{ position: 'relative', width: 40, height: 40 }}>
        <VipAvatar typeId={member.vipTypeId} size={40} />
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
          <Image
            source={DEVICE_ICONS[normalizeDevice(member.deviceType)]}
            style={{ width: 10, height: 10 }}
            resizeMode="contain"
          />
        </View>
      </View>
      <View className="min-w-0 flex-1">
        <View className="flex-row items-center gap-1">
          <Text numberOfLines={1} className="text-base text-ola-ink">
            {member.username}
          </Text>
          {subName != null && (
            <Text numberOfLines={1} className="text-sm text-ola-ink-soft">
              {subName}
            </Text>
          )}
        </View>
        {member.bio != null && member.bio !== '' && (
          <Text numberOfLines={1} className="text-xs text-ola-ink-soft">
            {member.bio}
          </Text>
        )}
      </View>
      {bioImage != null && (
        <Pressable onPress={() => onViewImage(bioImage)} hitSlop={4}>
          <Image
            source={{ uri: bioImage }}
            style={{
              width: 40,
              height: 40,
              borderRadius: 4,
              borderWidth: 1,
              borderColor: 'rgba(0,0,0,0.12)',
            }}
            resizeMode="cover"
          />
        </Pressable>
      )}
    </Pressable>
  );
}

export function RoomMembersTab({ members, onOpenUser }: RoomMembersTabProps) {
  const { t } = useTranslation();
  const [previewImage, setPreviewImage] = useState<string | null>(null);

  if (members.length === 0) {
    return (
      <View className="flex-1 items-center justify-center bg-white px-8">
        <Text className="text-center text-sm text-ola-ink-soft">
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
        renderItem={({ item }) => (
          <MemberRow member={item} onOpenUser={onOpenUser} onViewImage={setPreviewImage} />
        )}
      />
      <Modal
        visible={previewImage != null}
        transparent
        animationType="fade"
        onRequestClose={() => setPreviewImage(null)}
      >
        <Pressable
          className="flex-1 items-center justify-center bg-black/90 px-4"
          onPress={() => setPreviewImage(null)}
        >
          {previewImage != null && (
            <Image
              source={{ uri: previewImage }}
              style={{ width: '100%', height: '80%' }}
              resizeMode="contain"
            />
          )}
        </Pressable>
      </Modal>
    </View>
  );
}

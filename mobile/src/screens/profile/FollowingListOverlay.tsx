import { useTranslation } from 'react-i18next';
import { FlatList, Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { FollowUser } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';

interface FollowingListOverlayProps {
  following: FollowUser[];
  onSelect: (friend: FollowUser) => void;
  onClose: () => void;
  title?: string;
}

export function FollowingListOverlay({ following, onSelect, onClose, title }: FollowingListOverlayProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <View className="flex-1 bg-white">
        <View className="flex-row items-center bg-ola-primary px-1" style={{ paddingTop: insets.top }}>
          <Pressable onPress={onClose} className="h-12 w-10 items-center justify-center">
            <Text className="text-2xl leading-none text-white">‹</Text>
          </Pressable>
          <Text numberOfLines={1} className="flex-1 text-center text-base font-medium text-white">
            {title ?? t('profile.following')}
          </Text>
          <View className="w-10" />
        </View>
        <FlatList
          data={following}
          keyExtractor={(item) => item.id}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          renderItem={({ item }) => (
            <Pressable
              onPress={() => onSelect(item)}
              className="flex-row items-center gap-3 px-4 py-2 active:bg-black/5"
              style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
            >
              <Avatar name={item.username} uri={item.avatar ?? undefined} size={40} rounded={false} />
              <Text numberOfLines={1} className="min-w-0 flex-1 text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                @{item.username}
                {item.fullName != null && item.fullName !== '' && (
                  <Text style={{ color: 'rgba(0,0,0,0.54)' }}> · {item.fullName}</Text>
                )}
              </Text>
            </Pressable>
          )}
        />
      </View>
    </Modal>
  );
}

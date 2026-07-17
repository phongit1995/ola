import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  FlatList,
  Pressable,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { activeVipTypeId, createTimeFormatter } from '@ola/shared/lib';
import type { Relationship } from '@ola/shared/types';
import { Avatar } from '@components/Avatar';
import { VipAvatar } from '@components/VipAvatar';
import { OlaModal } from '@components/OlaModal';
import { ScreenHeader } from '@components/ScreenHeader';

interface FriendRequestsScreenProps {
  requests: Relationship[];
  loading: boolean;
  onAccept: (relationship: Relationship) => Promise<void>;
  onDecline: (relationship: Relationship) => Promise<void>;
  onClose: () => void;
}

export function FriendRequestsScreen(props: FriendRequestsScreenProps) {
  return (
    <OlaModal
      visible
      transparent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <FriendRequestsBody {...props} />
    </OlaModal>
  );
}

function FriendRequestsBody({
  requests,
  loading,
  onAccept,
  onDecline,
  onClose,
}: FriendRequestsScreenProps) {
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language],
  );
  const [busyIds, setBusyIds] = useState<string[]>([]);

  async function run(
    relationship: Relationship,
    action: (relationship: Relationship) => Promise<void>,
  ) {
    if (busyIds.includes(relationship.id)) return;
    setBusyIds(prev => [...prev, relationship.id]);
    try {
      await action(relationship);
    } finally {
      setBusyIds(prev => prev.filter(id => id !== relationship.id));
    }
  }

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader
        title={t('chat.friendRequests')}
        centerTitle
        onBack={onClose}
      />

      {loading ? (
        <ActivityIndicator className="py-10" color="#7cb342" size="large" />
      ) : requests.length === 0 ? (
        <Text
          className="px-4 py-10 text-center text-sm"
          style={{ color: 'rgba(0,0,0,0.54)' }}
        >
          {t('chat.friendRequestEmpty')}
        </Text>
      ) : (
        <FlatList
          data={requests}
          keyExtractor={item => item.id}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          renderItem={({ item }) => {
            const requester = item.requester;
            const name = requester?.fullName || requester?.username || '';
            const vipTypeId = activeVipTypeId(
              requester?.vipUsed,
              requester?.vipEndTime,
            );
            const busy = busyIds.includes(item.id);
            return (
              <View
                className="flex-row items-center gap-3 bg-white px-4 py-3"
                style={{
                  borderBottomWidth: 1,
                  borderBottomColor: 'rgba(0,0,0,0.12)',
                }}
              >
                <Avatar
                  name={name}
                  uri={requester?.avatar ?? undefined}
                  size={56}
                />
                <View className="min-w-0 flex-1">
                  <View className="flex-row items-center gap-1">
                    {vipTypeId != null && (
                      <VipAvatar typeId={vipTypeId} size={20} />
                    )}
                    <Text
                      numberOfLines={1}
                      className="min-w-0 shrink text-base"
                      style={{ color: 'rgba(0,0,0,0.87)' }}
                    >
                      @{requester?.username ?? ''}
                      {requester?.fullName != null &&
                        requester.fullName !== '' && (
                          <Text style={{ color: 'rgba(0,0,0,0.45)' }}>
                            {' '}
                            · {requester.fullName}
                          </Text>
                        )}
                    </Text>
                  </View>
                  <Text
                    numberOfLines={1}
                    className="text-xs"
                    style={{ color: 'rgba(0,0,0,0.54)' }}
                  >
                    {formatTime(item.createdAt)}
                  </Text>
                </View>
                <View className="shrink-0 items-center gap-2">
                  <Pressable
                    disabled={busy}
                    onPress={() => void run(item, onAccept)}
                    className="items-center rounded bg-ola-primary px-3 py-1.5"
                    style={{ minWidth: 76, opacity: busy ? 0.5 : 1 }}
                  >
                    <Text className="text-sm font-medium text-white">
                      {t('chat.acceptRequest')}
                    </Text>
                  </Pressable>
                  <Pressable
                    disabled={busy}
                    onPress={() => void run(item, onDecline)}
                    className="items-center rounded px-3 py-1.5"
                    style={{
                      minWidth: 76,
                      borderWidth: 1,
                      borderColor: '#7cb342',
                      opacity: busy ? 0.5 : 1,
                    }}
                  >
                    <Text
                      className="text-sm font-medium"
                      style={{ color: '#7cb342' }}
                    >
                      {t('chat.declineRequest')}
                    </Text>
                  </Pressable>
                </View>
              </View>
            );
          }}
        />
      )}
    </View>
  );
}

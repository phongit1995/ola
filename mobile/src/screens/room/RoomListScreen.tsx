import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { RoomService } from '@ola/shared/services';
import type { Room } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';

const membersIcon = require('../../assets/icons/room/ic_indicate_privacy_friends.png');
const quickJoinIcon = require('../../assets/icons/room/ic_action_auto_join_room.png');

const ROOM_COLORS = ['#ef5350', '#ec407a', '#5c6bc0', '#26a69a', '#7e57c2', '#ffa726'];
const ROOM_CAPACITY = 200;
const DIVIDER = 'rgba(0,0,0,0.12)';

function membersBadgeColor(members: number): string {
  if (members >= ROOM_CAPACITY) return '#ff4081';
  if (members >= 100) return 'rgba(0,0,0,0.54)';
  return 'rgba(0,0,0,0.26)';
}

function MembersBadge({ members }: { members: number }) {
  const display = members >= ROOM_CAPACITY ? '200+' : String(members);
  return (
    <View className="flex-row items-center gap-1">
      <Image source={membersIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
      <Text className="text-sm" style={{ color: membersBadgeColor(members) }}>
        {display}
      </Text>
    </View>
  );
}

function RoomRow({
  room,
  color,
  onEnter,
}: {
  room: Room;
  color: string;
  onEnter: (room: Room) => void;
}) {
  return (
    <Pressable
      onPress={() => onEnter(room)}
      className="flex-row items-center gap-2 bg-white px-4 py-3 active:bg-black/5"
      style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
    >
      {room.imageUrl != null && room.imageUrl !== '' ? (
        <Image
          source={{ uri: room.imageUrl }}
          style={{ width: 64, height: 64, borderRadius: 4 }}
          resizeMode="cover"
        />
      ) : (
        <View
          className="items-center justify-center"
          style={{ width: 64, height: 64, borderRadius: 4, backgroundColor: color }}
        >
          <Text className="text-2xl font-medium text-white">
            {room.name.charAt(0).toUpperCase()}
          </Text>
        </View>
      )}
      <View className="min-w-0 flex-1 pl-2">
        <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {room.name}
        </Text>
        {room.description != null && room.description !== '' && (
          <Text numberOfLines={1} className="mt-1 text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {room.description}
          </Text>
        )}
      </View>
      <MembersBadge members={room.memberCount} />
    </Pressable>
  );
}

function QuickJoinRow({ onPress }: { onPress: () => void }) {
  const { t } = useTranslation();
  return (
    <Pressable
      onPress={onPress}
      className="flex-row items-center gap-2 bg-white px-4 py-3 active:bg-black/5"
      style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
    >
      <View
        className="items-center justify-center bg-ola-primary-light"
        style={{ width: 64, height: 64, borderRadius: 4 }}
      >
        <Image source={quickJoinIcon} style={{ width: 48, height: 48 }} resizeMode="contain" />
      </View>
      <View className="min-w-0 flex-1 pl-2">
        <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {t('room.quickJoin')}
        </Text>
        <Text numberOfLines={1} className="mt-1 text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('room.quickJoinDesc')}
        </Text>
      </View>
    </Pressable>
  );
}

function SectionHeader({ label }: { label: string }) {
  return (
    <View className="px-4 py-1.5" style={{ backgroundColor: '#f3f3f3' }}>
      <Text
        className="text-xs font-medium uppercase"
        style={{ color: 'rgba(0,0,0,0.54)', letterSpacing: 0.5 }}
      >
        {label}
      </Text>
    </View>
  );
}

export function RoomListScreen() {
  const { t } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const [rooms, setRooms] = useState<Room[]>([]);
  const [loading, setLoading] = useState(false);

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const result = await RoomService.browse({ limit: 50 });
      setRooms(result.items);
    } catch {
      setRooms([]);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    void load();
  }, [load]);

  const enterRoom = useCallback(
    (room: Room) => {
      navigation.navigate(ROOT_ROUTES.RoomChat, { roomId: room.id, roomName: room.name });
    },
    [navigation]
  );

  const quickJoin = useCallback(() => {
    const available = [...rooms]
      .filter((room) => room.memberCount < ROOM_CAPACITY)
      .sort((a, b) => a.memberCount - b.memberCount)[0];
    if (available != null) enterRoom(available);
  }, [rooms, enterRoom]);

  const header = useMemo(
    () => (
      <View>
        <QuickJoinRow onPress={quickJoin} />
        <SectionHeader label={t('room.sectionPublic')} />
      </View>
    ),
    [quickJoin, t]
  );

  return (
    <View className="flex-1 bg-white">
      <View className="h-12 items-center justify-center bg-ola-primary">
        <Text className="text-base font-medium text-white">{t('home.tabRoom')}</Text>
      </View>
      {loading && rooms.length === 0 ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <FlashList
          data={rooms}
          keyExtractor={(item) => item.id}
          refreshControl={<RefreshControl refreshing={loading} onRefresh={() => void load()} />}
          ListHeaderComponent={header}
          ListEmptyComponent={
            <View className="mt-24 items-center">
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.4)' }}>
                {t('home.roomEmpty')}
              </Text>
            </View>
          }
          renderItem={({ item, index }) => (
            <RoomRow room={item} color={ROOM_COLORS[index % ROOM_COLORS.length]!} onEnter={enterRoom} />
          )}
        />
      )}
    </View>
  );
}

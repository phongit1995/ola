import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { RoomService } from '@ola/shared/services';
import type { Room } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { Avatar } from '../../components/Avatar';

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

  return (
    <View className="flex-1 bg-white">
      <View className="h-12 items-center justify-center border-b border-neutral-200 bg-ola-primary">
        <Text className="text-lg font-semibold text-white">{t('home.tabRoom')}</Text>
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
          ItemSeparatorComponent={() => <View className="ml-[76px] h-px bg-neutral-100" />}
          ListEmptyComponent={
            <View className="mt-24 items-center">
              <Text className="text-sm text-neutral-400">{t('home.roomEmpty')}</Text>
            </View>
          }
          renderItem={({ item }) => (
            <Pressable
              className="flex-row items-center gap-3 bg-white px-4 py-3 active:bg-neutral-100"
              onPress={() =>
                navigation.navigate(ROOT_ROUTES.RoomChat, { roomId: item.id, roomName: item.name })
              }
            >
              <Avatar name={item.name} uri={item.imageUrl} />
              <View className="flex-1">
                <Text className="text-base font-semibold text-neutral-900" numberOfLines={1}>
                  {item.name}
                </Text>
                {item.description != null && item.description !== '' && (
                  <Text className="text-sm text-neutral-500" numberOfLines={1}>
                    {item.description}
                  </Text>
                )}
              </View>
              <Text className="text-xs text-neutral-400">
                {item.memberCount}/{item.maxMembers}
              </Text>
            </Pressable>
          )}
        />
      )}
    </View>
  );
}

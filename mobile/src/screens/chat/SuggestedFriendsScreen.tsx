import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FlatList, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { SUGGESTED_FRIENDS, type SuggestedFriend } from './contacts';
import { OlaModal } from '@components/OlaModal';
import { ScreenHeader } from '@components/ScreenHeader';

export function SuggestedFriendsScreen({ onClose }: { onClose: () => void }) {
  return (
    <OlaModal
      visible
      transparent
      animationType="slide"
      onRequestClose={onClose}
    >
      <SuggestedFriendsBody onClose={onClose} />
    </OlaModal>
  );
}

function SuggestedFriendsBody({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore(s => s.push);
  const [list, setList] = useState<SuggestedFriend[]>(SUGGESTED_FRIENDS);

  const remove = (name: string) =>
    setList(prev => prev.filter(friend => friend.name !== name));

  function addFriend(friend: SuggestedFriend) {
    push('success', t('chat.friendRequestSent'));
    remove(friend.name);
  }

  function addAll() {
    if (list.length === 0) return;
    push('success', t('chat.friendRequestSent'));
    setList([]);
  }

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader
        title={t('chat.suggestFriends')}
        centerTitle
        onBack={onClose}
      />

      {list.length > 0 && (
        <View
          className="p-2"
          style={{
            borderBottomWidth: 1,
            borderBottomColor: 'rgba(0,0,0,0.12)',
          }}
        >
          <Pressable
            onPress={addAll}
            className="items-center rounded bg-ola-primary py-2"
          >
            <Text className="text-sm font-medium text-white">
              {t('chat.makeFriendAll')}
            </Text>
          </Pressable>
        </View>
      )}

      {list.length === 0 ? (
        <Text
          className="px-4 py-10 text-center text-sm"
          style={{ color: 'rgba(0,0,0,0.54)' }}
        >
          {t('chat.suggestEmpty')}
        </Text>
      ) : (
        <FlatList
          data={list}
          keyExtractor={item => item.name}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          renderItem={({ item }) => (
            <View
              className="flex-row items-center gap-3 bg-white px-4 py-3"
              style={{
                borderBottomWidth: 1,
                borderBottomColor: 'rgba(0,0,0,0.12)',
              }}
            >
              <View
                className="h-14 w-14 items-center justify-center rounded-full"
                style={{ backgroundColor: item.color }}
              >
                <Text className="text-xl font-medium text-white">
                  {item.name.charAt(0).toUpperCase()}
                </Text>
              </View>
              <View className="min-w-0 flex-1">
                <Text
                  numberOfLines={1}
                  className="text-base"
                  style={{ color: 'rgba(0,0,0,0.87)' }}
                >
                  {item.name}
                </Text>
                <Pressable
                  onPress={() => addFriend(item)}
                  className="mt-1 self-start rounded bg-ola-primary px-3 py-1.5"
                >
                  <Text className="text-sm font-medium text-white">
                    {t('chat.menuMakeFriend')}
                  </Text>
                </Pressable>
              </View>
              <Pressable
                onPress={() => remove(item.name)}
                className="h-10 w-10 shrink-0 items-center justify-center rounded-full active:bg-black/5"
              >
                <Text className="text-xl" style={{ color: 'rgba(0,0,0,0.38)' }}>
                  ×
                </Text>
              </Pressable>
            </View>
          )}
        />
      )}
    </View>
  );
}

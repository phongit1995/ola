import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import { useFriendsStore } from '@store/friendsStore';
import { Avatar } from '@components/Avatar';

interface MeComposerTagPanelProps {
  onMention: (username: string) => void;
}

export function MeComposerTagPanel({ onMention }: MeComposerTagPanelProps) {
  const { t } = useTranslation();
  const friends = useFriendsStore((s) => s.friends);
  const loading = useFriendsStore((s) => s.loading);
  const loaded = useFriendsStore((s) => s.loaded);
  const ensureFriends = useFriendsStore((s) => s.ensureFriends);
  const [query, setQuery] = useState('');

  useEffect(() => {
    ensureFriends();
  }, [ensureFriends]);

  const filtered = useMemo(() => {
    const keyword = query.trim().toLowerCase();
    if (keyword === '') return friends;
    return friends.filter(
      (friend) =>
        friend.username.toLowerCase().includes(keyword) ||
        (friend.fullName ?? '').toLowerCase().includes(keyword)
    );
  }, [friends, query]);

  return (
    <View style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)', borderRadius: 6 }}>
      <TextInput
        className="px-3 py-2 text-sm"
        style={{ color: 'rgba(0,0,0,0.87)', borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
        placeholder={t('me.tagSearchHint')}
        placeholderTextColor="rgba(0,0,0,0.38)"
        value={query}
        onChangeText={setQuery}
      />
      <ScrollView style={{ maxHeight: 176 }} keyboardShouldPersistTaps="handled">
        {loading || !loaded ? (
          <View className="items-center py-4">
            <ActivityIndicator color="#7cb342" />
          </View>
        ) : filtered.length === 0 ? (
          <Text className="py-4 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.tagEmpty')}
          </Text>
        ) : (
          filtered.map((friend) => {
            const fullName = friend.fullName?.trim() ?? '';
            return (
              <Pressable
                key={friend.id}
                onPress={() => onMention(friend.username)}
                className="flex-row items-center gap-2 px-3 py-2 active:bg-black/5"
              >
                <Avatar name={friend.username} uri={friend.avatar ?? undefined} size={28} />
                <Text numberOfLines={1} className="min-w-0 flex-1 text-sm">
                  {fullName !== '' ? (
                    <>
                      <Text style={{ color: 'rgba(0,0,0,0.87)' }}>{fullName}</Text>
                      <Text style={{ color: 'rgba(0,0,0,0.45)' }}> @{friend.username}</Text>
                    </>
                  ) : (
                    <Text style={{ color: 'rgba(0,0,0,0.87)' }}>@{friend.username}</Text>
                  )}
                </Text>
              </Pressable>
            );
          })
        )}
      </ScrollView>
    </View>
  );
}

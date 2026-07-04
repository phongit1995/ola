import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Animated, FlatList, Pressable, Text, TextInput, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { colorForName } from '@ola/shared/lib';
import type { UserSearchResult } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';

const WIDTH = 280;

interface MeRightDrawerProps {
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
}

export function MeRightDrawer({ onClose, onOpenProfile }: MeRightDrawerProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore((s) => s.push);
  const translateX = useRef(new Animated.Value(WIDTH)).current;
  const backdrop = useRef(new Animated.Value(0)).current;

  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    Animated.parallel([
      Animated.timing(translateX, { toValue: 0, duration: 200, useNativeDriver: true }),
      Animated.timing(backdrop, { toValue: 1, duration: 200, useNativeDriver: true }),
    ]).start();
  }, [translateX, backdrop]);

  useEffect(() => {
    const keyword = query.trim();
    const timer = setTimeout(() => {
      if (keyword === '') {
        setResults([]);
        setLoading(false);
        return;
      }
      setLoading(true);
      UserService.search(keyword, 30)
        .then((result) => setResults(result.users))
        .catch(() => push('error', t('me.searchError')))
        .finally(() => setLoading(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, push, t]);

  const searching = query.trim() !== '';

  function openProfile(user: UserSearchResult) {
    onOpenProfile(user.username, colorForName(user.username));
    onClose();
  }

  return (
    <View className="absolute inset-0" style={{ zIndex: 40 }}>
      <Animated.View style={{ flex: 1, opacity: backdrop }} className="bg-black/30">
        <Pressable className="flex-1" onPress={onClose} />
      </Animated.View>
      <Animated.View
        className="absolute inset-y-0 right-0 bg-white"
        style={{ width: WIDTH, transform: [{ translateX }] }}
      >
        <View style={{ paddingTop: insets.top }} className="bg-[#d5d5d5] px-4 py-3" >
          <View
            className="h-10 flex-row items-center rounded-md bg-white px-2"
            style={{ borderWidth: 1, borderColor: '#b2b2b2' }}
          >
            <TextInput
              className="flex-1 text-base"
              style={{ color: 'rgba(0,0,0,0.87)' }}
              value={query}
              onChangeText={setQuery}
              placeholder={t('me.searchHint')}
              placeholderTextColor="rgba(0,0,0,0.26)"
              autoFocus
            />
          </View>
        </View>

        <View className="flex-1">
          {loading ? (
            <ActivityIndicator className="py-6" color="#7cb342" />
          ) : searching && results.length === 0 ? (
            <Text className="py-8 text-center text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>
              {t('me.searchEmpty')}
            </Text>
          ) : !searching ? (
            <Text className="py-8 text-center text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>
              {t('me.searchHistoryEmpty')}
            </Text>
          ) : (
            <FlatList
              data={results}
              keyExtractor={(item) => item.id}
              renderItem={({ item }) => {
                const title = item.fullName != null && item.fullName !== '' ? item.fullName : item.username;
                return (
                  <Pressable
                    onPress={() => openProfile(item)}
                    className="h-12 flex-row items-center gap-2 px-2 active:bg-ola-primary-light"
                  >
                    <Avatar name={item.username} uri={item.avatar ?? undefined} size={32} />
                    <View className="min-w-0 flex-1">
                      <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                        {title}
                      </Text>
                      {item.fullName != null && item.fullName !== '' && (
                        <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                          @{item.username}
                        </Text>
                      )}
                    </View>
                  </Pressable>
                );
              }}
            />
          )}
        </View>
      </Animated.View>
    </View>
  );
}

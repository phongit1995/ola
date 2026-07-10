import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  FlatList,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  Text,
  TextInput,
  View,
} from 'react-native';
import { UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { UserSearchResult } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';

interface ComposeDialogProps {
  onClose: () => void;
  onStart: (userId: string) => void;
}

export function ComposeDialog({ onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const keyword = query.trim();

  useEffect(() => {
    const value = query.trim();
    const timer = setTimeout(() => {
      if (value === '') {
        setResults([]);
        setSearching(false);
        return;
      }
      setSearching(true);
      UserService.search(value, 30)
        .then((result) => setResults(result.users))
        .catch(() => push('error', t('chat.searchError')))
        .finally(() => setSearching(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, push, t]);

  const emptyMessage = keyword === '' ? t('chat.addContactHint') : t('chat.composeSearchEmpty');

  return (
    <Modal visible transparent animationType="fade" onRequestClose={onClose}>
      <KeyboardAvoidingView className="flex-1" behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
        <Pressable className="flex-1 items-center justify-center bg-black/40 px-6" onPress={onClose}>
          <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
            <Text className="mb-3 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
              {t('chat.composeTitle')}
            </Text>
            <TextInput
              value={query}
              onChangeText={setQuery}
              placeholder={t('chat.composeSearchPlaceholder')}
              placeholderTextColor="rgba(0,0,0,0.38)"
              autoFocus
              className="rounded bg-white px-3 py-2 text-sm"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.15)', color: 'rgba(0,0,0,0.87)' }}
            />
            {searching ? (
              <ActivityIndicator className="py-6" color="#7cb342" />
            ) : results.length === 0 ? (
              <Text className="py-6 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {emptyMessage}
              </Text>
            ) : (
              <FlatList
                className="mt-2"
                style={{ maxHeight: 320 }}
                data={results}
                keyboardShouldPersistTaps="handled"
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                  <Pressable
                    onPress={() => onStart(item.id)}
                    className="flex-row items-center gap-3 py-2 active:bg-black/5"
                  >
                    <View className="relative">
                      <Avatar name={item.fullName || item.username} uri={item.avatar ?? undefined} size={40} />
                      {item.isOnline && (
                        <View
                          className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary"
                          style={{ borderWidth: 2, borderColor: '#fff' }}
                        />
                      )}
                    </View>
                    <View className="min-w-0 flex-1">
                      <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                        {item.fullName || item.username}
                      </Text>
                      <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                        @{item.username}
                      </Text>
                    </View>
                  </Pressable>
                )}
              />
            )}
          </Pressable>
        </Pressable>
      </KeyboardAvoidingView>
    </Modal>
  );
}

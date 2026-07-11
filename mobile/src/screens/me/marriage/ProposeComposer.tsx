import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { toast } from '@ola/shared/lib';
import { UserService } from '@ola/shared/services';
import { useMarriageStore } from '@ola/shared/stores/marriageStore';
import type { UserSearchResult } from '@ola/shared/types';
import { VipAvatar } from '../../../components/VipAvatar';

const MESSAGE_LIMIT = 500;

const searchIcon = require('../../../assets/icons/me/ic_action_search.png');

interface ProposeComposerProps {
  onClose: () => void;
}

function isBlocked(user: UserSearchResult): boolean {
  return user.relationship === 'blocked_by_me' || user.relationship === 'blocked_by_them';
}

function UserRowName({ user }: { user: UserSearchResult }) {
  return (
    <View className="min-w-0 flex-1">
      <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
        <Text className="font-semibold">{user.username}</Text>
        {user.fullName != null && user.fullName !== '' && (
          <Text style={{ color: 'rgba(0,0,0,0.54)' }}> {user.fullName}</Text>
        )}
      </Text>
      {user.bio != null && user.bio !== '' && (
        <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {user.bio}
        </Text>
      )}
    </View>
  );
}

export function ProposeComposer({ onClose }: ProposeComposerProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const propose = useMarriageStore((s) => s.propose);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [selected, setSelected] = useState<UserSearchResult | null>(null);
  const [message, setMessage] = useState('');
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (selected != null) return;
    const keyword = query.trim();
    if (keyword === '') {
      setResults([]);
      setSearching(false);
      return;
    }
    const timer = setTimeout(() => {
      setSearching(true);
      UserService.search(keyword, 20)
        .then((result) => setResults(result.users))
        .catch(() => setResults([]))
        .finally(() => setSearching(false));
    }, 300);
    return () => clearTimeout(timer);
  }, [query, selected]);

  function pick(user: UserSearchResult) {
    setSelected(user);
    setResults([]);
    setQuery('');
  }

  function clearSelected() {
    setSelected(null);
    setQuery('');
  }

  const canSend = selected != null && message.trim().length > 0 && !busy;

  async function send() {
    if (busy) return;
    if (selected == null) {
      toast.info(t('marriage.needReceiver'));
      return;
    }
    const body = message.trim();
    if (body.length === 0) {
      toast.info(t('marriage.needMessage'));
      return;
    }
    setBusy(true);
    try {
      await propose(selected.id, body);
      toast.success(t('marriage.sent', { nick: selected.username }));
      onClose();
    } catch {
      toast.error(t('common.error'));
    } finally {
      setBusy(false);
    }
  }

  return (
    <KeyboardAvoidingView
      className="flex-1 bg-white"
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <View
        className="flex-row items-center bg-ola-primary px-2"
        style={{ paddingTop: insets.top }}
      >
        <Pressable onPress={onClose} className="h-12 w-10 items-center justify-center">
          <Text className="text-2xl leading-none text-white">‹</Text>
        </Pressable>
        <Text className="flex-1 text-lg font-medium text-white">{t('marriage.composeTitle')}</Text>
        <Pressable
          onPress={() => void send()}
          disabled={!canSend}
          className="rounded-full px-4 active:opacity-90"
          style={{
            paddingVertical: 6,
            backgroundColor: canSend ? '#ff4d7d' : 'rgba(0,0,0,0.15)',
          }}
        >
          <Text className="text-sm font-bold text-white">{t('marriage.send')}</Text>
        </Pressable>
      </View>

      <ScrollView className="flex-1" keyboardShouldPersistTaps="handled">
        <View className="items-center px-5 pb-4 pt-6">
          <Text style={{ fontSize: 48 }}>💍</Text>
          <Text
            className="mt-1 text-center text-sm"
            style={{ maxWidth: 320, color: 'rgba(0,0,0,0.55)' }}
          >
            {t('marriage.composeIntro')}
          </Text>
        </View>

        <View className="gap-5 px-4 pb-6">
          <View className="gap-2">
            <Text
              className="px-1 text-xs font-bold uppercase"
              style={{ letterSpacing: 0.5, color: '#c2185b' }}
            >
              {t('marriage.receiverLabel')}
            </Text>

            {selected != null ? (
              <View
                className="flex-row items-center rounded-xl bg-white p-3"
                style={{ gap: 12, borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
              >
                <View>
                  <VipAvatar size={40} />
                  {selected.isOnline && (
                    <View
                      className="absolute bottom-0 right-0 rounded-full"
                      style={{
                        width: 10,
                        height: 10,
                        backgroundColor: '#4caf50',
                        borderWidth: 1.5,
                        borderColor: '#ffffff',
                      }}
                    />
                  )}
                </View>
                <UserRowName user={selected} />
                <Pressable
                  onPress={clearSelected}
                  className="rounded-full px-3 active:opacity-80"
                  style={{ paddingVertical: 6, backgroundColor: 'rgba(0,0,0,0.06)' }}
                >
                  <Text className="text-xs font-semibold" style={{ color: 'rgba(0,0,0,0.7)' }}>
                    {t('marriage.changeReceiver')}
                  </Text>
                </Pressable>
              </View>
            ) : (
              <View>
                <View
                  className="flex-row items-center rounded-2xl bg-white"
                  style={{ borderWidth: 1, borderColor: '#ffd0de', paddingHorizontal: 12 }}
                >
                  <Image
                    source={searchIcon}
                    style={{ width: 18, height: 18, tintColor: 'rgba(0,0,0,0.35)' }}
                    resizeMode="contain"
                  />
                  <TextInput
                    value={query}
                    onChangeText={setQuery}
                    placeholder={t('marriage.searchPlaceholder')}
                    placeholderTextColor="rgba(0,0,0,0.35)"
                    className="flex-1 text-sm"
                    style={{ paddingVertical: 12, paddingLeft: 8, color: 'rgba(0,0,0,0.87)' }}
                  />
                </View>
                {(results.length > 0 || searching) && (
                  <View
                    className="mt-2 rounded-2xl bg-white py-1"
                    style={{
                      maxHeight: 256,
                      borderWidth: 1,
                      borderColor: '#ffd0de',
                      shadowColor: '#000',
                      shadowOpacity: 0.12,
                      shadowRadius: 12,
                      shadowOffset: { width: 0, height: 4 },
                      elevation: 4,
                    }}
                  >
                    <ScrollView keyboardShouldPersistTaps="handled" nestedScrollEnabled>
                      {searching && results.length === 0 ? (
                        <View className="flex-row items-center px-3" style={{ paddingVertical: 10, gap: 8 }}>
                          <ActivityIndicator size="small" color="#ff4d7d" />
                          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
                            {t('common.loading')}
                          </Text>
                        </View>
                      ) : (
                        results.map((user) => {
                          const blocked = isBlocked(user);
                          return (
                            <Pressable
                              key={user.id}
                              disabled={blocked}
                              onPress={() => pick(user)}
                              className="flex-row items-center px-3 active:bg-[#fff0f4]"
                              style={{ paddingVertical: 10, gap: 12, opacity: blocked ? 0.5 : 1 }}
                            >
                              <VipAvatar size={36} />
                              <UserRowName user={user} />
                              {blocked && (
                                <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                                  {t('chat.blocked')}
                                </Text>
                              )}
                            </Pressable>
                          );
                        })
                      )}
                    </ScrollView>
                  </View>
                )}
              </View>
            )}
          </View>

          <View className="gap-2">
            <Text
              className="px-1 text-xs font-bold uppercase"
              style={{ letterSpacing: 0.5, color: '#c2185b' }}
            >
              {t('marriage.messageLabel')}
            </Text>
            <View
              className="rounded-2xl bg-white p-3"
              style={{ borderWidth: 1, borderColor: '#ffd0de' }}
            >
              <TextInput
                value={message}
                onChangeText={(value) => setMessage(value.slice(0, MESSAGE_LIMIT))}
                multiline
                maxLength={MESSAGE_LIMIT}
                placeholder={t('marriage.messageHint')}
                placeholderTextColor="rgba(0,0,0,0.35)"
                className="text-sm"
                style={{ height: 130, textAlignVertical: 'top', color: 'rgba(0,0,0,0.87)' }}
              />
              <Text className="mt-1 text-right text-xs" style={{ color: 'rgba(0,0,0,0.35)' }}>
                {message.length}/{MESSAGE_LIMIT}
              </Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

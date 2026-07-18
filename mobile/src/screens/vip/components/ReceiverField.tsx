import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { UserSearchResult } from '@ola/shared/types';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { UserResultRow } from './UserResultRow';

interface ReceiverFieldProps {
  receiverUser: UserSearchResult | null;
  receiverQuery: string;
  receiverResults: UserSearchResult[];
  receiverSearching: boolean;
  onChangeQuery: (value: string) => void;
  onPick: (user: UserSearchResult) => void;
  onClear: () => void;
}

export function ReceiverField({
  receiverUser,
  receiverQuery,
  receiverResults,
  receiverSearching,
  onChangeQuery,
  onPick,
  onClear,
}: ReceiverFieldProps) {
  const { t } = useTranslation();
  return (
    <View className="mt-2 bg-white px-4 py-3">
      <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{t('vip.buy.receiverLabel')}</Text>
      {receiverUser != null ? (
        <View
          className="mt-1 flex-row items-center rounded pl-2 pr-1"
          style={{ borderWidth: 1, borderColor: DIVIDER }}
        >
          <View className="min-w-0 flex-1">
            <UserResultRow user={receiverUser} />
          </View>
          <Pressable
            onPress={onClear}
            className="ml-1 h-8 w-8 items-center justify-center rounded-full active:bg-black/5"
          >
            <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>✕</Text>
          </Pressable>
        </View>
      ) : (
        <>
          <TextInput
            value={receiverQuery}
            onChangeText={onChangeQuery}
            placeholder={t('vip.buy.receiverHint')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            autoCapitalize="none"
            className="mt-1 rounded bg-white px-3 py-2 text-sm"
            style={{ borderWidth: 1, borderColor: DIVIDER, color: TEXT_PRIMARY }}
          />
          {receiverQuery.trim() !== '' && (
            <View
              className="mt-2 rounded"
              style={{ borderWidth: 1, borderColor: DIVIDER, maxHeight: 224 }}
            >
              {receiverSearching ? (
                <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('common.loading')}
                </Text>
              ) : receiverResults.length === 0 ? (
                <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('chat.composeSearchEmpty')}
                </Text>
              ) : (
                <ScrollView keyboardShouldPersistTaps="handled" className="px-2">
                  {receiverResults.map((item, index) => (
                    <View
                      key={item.id}
                      style={
                        index > 0
                          ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' }
                          : null
                      }
                    >
                      <UserResultRow user={item} onPress={() => onPick(item)} />
                    </View>
                  ))}
                </ScrollView>
              )}
            </View>
          )}
        </>
      )}
    </View>
  );
}

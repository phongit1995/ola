import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScrollView, Text, TextInput, View } from 'react-native';
import { useUserSearch } from '@ola/shared/stores/user/useUserSearch';
import type { UserSearchResult } from '@ola/shared/types';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { UserIdentityRow } from './UserIdentityRow';
import { userIdentityFromSearchResult } from './userIdentity';

interface UserSearchPickerProps {
  label: string;
  placeholder: string;
  onPick: (user: UserSearchResult) => void;
}

const RESULTS_MAX_HEIGHT = 224;

export function UserSearchPicker({ label, placeholder, onPick }: UserSearchPickerProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const { results, searching } = useUserSearch(query);

  return (
    <View className="px-1 py-1">
      <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{label}</Text>
      <TextInput
        autoFocus
        value={query}
        onChangeText={setQuery}
        placeholder={placeholder}
        placeholderTextColor="rgba(0,0,0,0.38)"
        autoCapitalize="none"
        className="mt-1 w-full rounded px-3 py-2 text-base"
        style={{ borderWidth: 1, borderColor: DIVIDER, color: TEXT_PRIMARY }}
      />
      {query.trim() !== '' && (
        <View
          className="mt-2 rounded"
          style={{ borderWidth: 1, borderColor: DIVIDER, maxHeight: RESULTS_MAX_HEIGHT }}
        >
          {searching ? (
            <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('common.loading')}
            </Text>
          ) : results.length === 0 ? (
            <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('chat.composeSearchEmpty')}
            </Text>
          ) : (
            <ScrollView keyboardShouldPersistTaps="handled" className="px-2">
              {results.map((item, index) => (
                <View
                  key={item.id}
                  style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
                >
                  <UserIdentityRow
                    user={userIdentityFromSearchResult(item)}
                    onPress={() => onPick(item)}
                  />
                </View>
              ))}
            </ScrollView>
          )}
        </View>
      )}
    </View>
  );
}

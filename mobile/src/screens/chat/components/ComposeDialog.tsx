import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Text } from 'react-native';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { UserListDialog } from '@components/ui/UserListDialog';
import { UserIdentityRow } from '@components/user/UserIdentityRow';
import { userIdentityFromSearchResult } from '@components/user/userIdentity';
import {
  useUserSearch,
  USER_SEARCH_TYPING_DEBOUNCE_MS,
} from '@ola/shared/stores/user/useUserSearch';

interface ComposeDialogProps {
  onClose: () => void;
  onStart: (userId: string) => void;
}

export function ComposeDialog({ onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [query, setQuery] = useState('');
  const keyword = query.trim();
  const { results, searching } = useUserSearch(query, {
    debounceMs: USER_SEARCH_TYPING_DEBOUNCE_MS,
    onError: () => push('error', t('chat.searchError')),
  });

  const emptyMessage = keyword === '' ? t('chat.addContactHint') : t('chat.composeSearchEmpty');

  return (
    <UserListDialog
      visible
      title={t('chat.composeTitle')}
      onClose={onClose}
      loading={searching}
      isEmpty={results.length === 0}
      empty={
        <Text className="py-6 text-center text-sm text-ola-ink-soft">
          {emptyMessage}
        </Text>
      }
      search={{
        value: query,
        onChange: setQuery,
        placeholder: t('chat.composeSearchPlaceholder'),
        autoFocus: true,
      }}
    >
      {results.map((item) => (
        <UserIdentityRow
          key={item.id}
          onPress={() => onStart(item.id)}
          user={userIdentityFromSearchResult(item)}
        />
      ))}
    </UserListDialog>
  );
}

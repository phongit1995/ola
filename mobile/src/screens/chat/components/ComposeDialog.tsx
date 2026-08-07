import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Text } from 'react-native';
import { UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { UserSearchResult } from '@ola/shared/types';
import { UserListDialog } from '@components/ui/UserListDialog';
import { UserIdentityRow } from '@components/user/UserIdentityRow';
import { userIdentityFromSearchResult } from '@components/user/userIdentity';

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

import { useState } from 'react';
import { useDebouncedCallback } from 'use-debounce';
import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { UserService } from '@services';
import { colorForName, toast } from '@lib';
import type { UserSearchResult } from '@app-types';

interface ComposeDialogProps {
  open: boolean;
  onClose: () => void;
  onStart: (userId: string) => void;
}

export function ComposeDialog({ open, onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [query, setQuery] = useState('');
  const keyword = query.trim();

  const runSearch = useDebouncedCallback((value: string) => {
    if (value === '') {
      setResults([]);
      setSearching(false);
      return;
    }
    setSearching(true);
    UserService.search(value, 30)
      .then((result) => setResults(result.users))
      .catch(() => toast.error(t('chat.searchError')))
      .finally(() => setSearching(false));
  }, 350);

  function handleQueryChange(value: string) {
    setQuery(value);
    runSearch(value.trim());
  }

  const emptyMessage =
    keyword === '' ? t('chat.addContactHint') : t('chat.composeSearchEmpty');

  return (
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('chat.composeTitle')}
      search={{
        value: query,
        onChange: handleQueryChange,
        placeholder: t('chat.composeSearchPlaceholder'),
      }}
      loading={searching}
      loadingText={t('common.loading')}
      isEmpty={results.length === 0}
      empty={
        <p className="py-6 text-center text-sm text-black/54">{emptyMessage}</p>
      }
    >
      {results.map((user) => (
        <li key={user.id}>
          <UserRow
            name={user.fullName || user.username}
            username={user.username}
            avatar={user.avatar}
            color={colorForName(user.username)}
            online={user.isOnline}
            onClick={() => onStart(user.id)}
          />
        </li>
      ))}
    </UserListDialog>
  );
}

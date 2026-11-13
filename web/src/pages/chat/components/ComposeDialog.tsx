import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { colorForName, toast } from '@lib';
import {
  useUserSearch,
  USER_SEARCH_TYPING_DEBOUNCE_MS,
} from '@ola/shared/stores/user/useUserSearch';

interface ComposeDialogProps {
  open: boolean;
  onClose: () => void;
  onStart: (userId: string) => void;
}

export function ComposeDialog({ open, onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const keyword = query.trim();
  const { results, searching } = useUserSearch(query, {
    debounceMs: USER_SEARCH_TYPING_DEBOUNCE_MS,
    keepPreviousResults: true,
    onError: () => toast.error(t('chat.searchError')),
  });

  const emptyMessage =
    keyword === '' ? t('chat.addContactHint') : t('chat.composeSearchEmpty');

  return (
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('chat.composeTitle')}
      search={{
        value: query,
        onChange: setQuery,
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

import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActionButton, UserListDialog, UserRow } from '@components';
import { colorForName, toast } from '@lib';
import { RelationshipService, UserService } from '@services';
import type { UserSearchResult } from '@app-types';

interface AddContactDialogProps {
  open: boolean;
  onClose: () => void;
}

export function AddContactDialog({ open, onClose }: AddContactDialogProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [sentIds, setSentIds] = useState<string[]>([]);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    if (!open) return;
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
        .catch(() => toast.error(t('chat.searchError')))
        .finally(() => setLoading(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, open, t]);

  async function sendRequest(user: UserSearchResult) {
    setBusyId(user.id);
    try {
      await RelationshipService.sendRequest(user.id);
      setSentIds((ids) => [...ids, user.id]);
      toast.success(t('chat.friendRequestSent'));
    } catch {
      toast.error(t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  const emptyMessage = query.trim() === '' ? t('chat.addContactHint') : t('chat.addContactEmpty');

  return (
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('chat.menuAddContact')}
      search={{
        value: query,
        onChange: setQuery,
        placeholder: t('chat.addContactSearchPlaceholder'),
      }}
      loading={loading}
      loadingText={t('common.loading')}
      isEmpty={results.length === 0}
      empty={<p className="py-6 text-center text-sm text-black/54">{emptyMessage}</p>}
    >
      {results.map((user) => {
        const sent = sentIds.includes(user.id);
        return (
          <li key={user.id}>
            <UserRow
              name={user.fullName || user.username}
              username={user.username}
              avatar={user.avatar}
              color={colorForName(user.username)}
              online={user.isOnline}
              trailing={
                <ActionButton
                  disabled={sent || busyId === user.id}
                  onClick={() => void sendRequest(user)}
                >
                  {sent ? t('chat.friendRequestSentShort') : t('chat.menuMakeFriend')}
                </ActionButton>
              }
            />
          </li>
        );
      })}
    </UserListDialog>
  );
}

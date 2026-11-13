import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActionButton, UserListDialog, UserRow } from '@components';
import { colorForName, toast } from '@lib';
import { RelationshipService } from '@services';
import type { UserSearchResult } from '@app-types';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import {
  useUserSearch,
  USER_SEARCH_TYPING_DEBOUNCE_MS,
} from '@ola/shared/stores/user/useUserSearch';

interface AddContactDialogProps {
  open: boolean;
  onClose: () => void;
  onOpenProfile?: (target: { username: string; color: string }) => void;
}

export function AddContactDialog({
  open,
  onClose,
  onOpenProfile,
}: AddContactDialogProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const [sentIds, setSentIds] = useState<string[]>([]);
  const [acceptedIds, setAcceptedIds] = useState<string[]>([]);
  const [busyId, setBusyId] = useState<string | null>(null);

  const { results, searching: loading } = useUserSearch(query, {
    debounceMs: USER_SEARCH_TYPING_DEBOUNCE_MS,
    onError: () => toast.error(t('chat.searchError')),
  });

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

  async function acceptRequest(user: UserSearchResult) {
    if (user.requestId == null) return;
    setBusyId(user.id);
    try {
      await RelationshipService.respond(user.requestId, 'accept');
      setAcceptedIds((ids) => [...ids, user.id]);
      toast.success(t('chat.requestAccepted'));
    } catch {
      toast.error(t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  function relationButton(user: UserSearchResult) {
    const busy = busyId === user.id;
    if (
      acceptedIds.includes(user.id) ||
      user.relationship === RELATIONSHIP_STATUS.friend
    ) {
      return (
        <ActionButton disabled>{t('chat.alreadyFriendShort')}</ActionButton>
      );
    }
    if (
      sentIds.includes(user.id) ||
      user.relationship === RELATIONSHIP_STATUS.pendingOutgoing
    ) {
      return (
        <ActionButton disabled>{t('chat.friendRequestSentShort')}</ActionButton>
      );
    }
    if (user.relationship === RELATIONSHIP_STATUS.pendingIncoming) {
      return (
        <ActionButton disabled={busy} onClick={() => void acceptRequest(user)}>
          {t('chat.acceptRequest')}
        </ActionButton>
      );
    }
    if (user.relationship === RELATIONSHIP_STATUS.blockedByMe) {
      return <ActionButton disabled>{t('chat.blocked')}</ActionButton>;
    }
    if (user.relationship === RELATIONSHIP_STATUS.blockedByThem) {
      return null;
    }
    return (
      <ActionButton disabled={busy} onClick={() => void sendRequest(user)}>
        {t('chat.menuMakeFriend')}
      </ActionButton>
    );
  }

  const emptyMessage =
    query.trim() === '' ? t('chat.addContactHint') : t('chat.addContactEmpty');

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
            onClick={
              onOpenProfile != null
                ? () =>
                    onOpenProfile({
                      username: user.username,
                      color: colorForName(user.username),
                    })
                : undefined
            }
            trailing={relationButton(user)}
          />
        </li>
      ))}
    </UserListDialog>
  );
}

import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { RelationshipService } from '@services';
import { colorForName } from '@lib';
import type { Friend } from '@app-types';

interface ComposeDialogProps {
  open: boolean;
  onClose: () => void;
  onStart: (friendId: string) => void;
}

function friendName(friend: Friend): string {
  return friend.fullName || friend.username;
}

export function ComposeDialog({ open, onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const [friends, setFriends] = useState<Friend[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState('');

  useEffect(() => {
    let active = true;
    RelationshipService.friends({ limit: 200 })
      .then((result) => {
        if (active) setFriends(result.friends);
      })
      .catch(() => {
        if (active) setFriends([]);
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  const filtered = useMemo(() => {
    const keyword = query.trim().toLowerCase();
    if (keyword === '') return friends;
    return friends.filter(
      (friend) =>
        friendName(friend).toLowerCase().includes(keyword) ||
        friend.username.toLowerCase().includes(keyword)
    );
  }, [friends, query]);

  return (
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('chat.composeTitle')}
      search={{ value: query, onChange: setQuery, placeholder: t('chat.composeSearchPlaceholder') }}
      loading={loading}
      isEmpty={filtered.length === 0}
      empty={<p className="py-6 text-center text-sm text-black/54">{t('chat.composeEmpty')}</p>}
    >
      {filtered.map((friend) => (
        <li key={friend.id}>
          <UserRow
            name={friendName(friend)}
            username={friend.username}
            avatar={friend.avatar}
            color={colorForName(friend.username)}
            online={friend.isOnline}
            onClick={() => onStart(friend.id)}
          />
        </li>
      ))}
    </UserListDialog>
  );
}

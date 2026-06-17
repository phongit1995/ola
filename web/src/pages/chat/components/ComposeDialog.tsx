import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog } from '@components';
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
  const [loading, setLoading] = useState(false);
  const [query, setQuery] = useState('');

  useEffect(() => {
    if (!open) return;
    let active = true;
    setQuery('');
    setLoading(true);
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
  }, [open]);

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
    <Dialog open={open} onClose={onClose} title={t('chat.composeTitle')}>
      <input
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={t('chat.composeSearchPlaceholder')}
        className="w-full rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />
      <div className="mt-3 max-h-72 overflow-y-auto">
        {loading ? (
          <p className="py-6 text-center text-sm text-black/54">{t('common.loading')}</p>
        ) : filtered.length === 0 ? (
          <p className="py-6 text-center text-sm text-black/54">{t('chat.composeEmpty')}</p>
        ) : (
          <ul className="divide-y divide-black/8">
            {filtered.map((friend) => {
              const name = friendName(friend);
              return (
                <li key={friend.id}>
                  <button
                    type="button"
                    onClick={() => onStart(friend.id)}
                    className="flex w-full items-center gap-3 py-2 text-left"
                  >
                    <span className="relative shrink-0">
                      <Avatar name={name} color={colorForName(name)} src={friend.avatar} size={40} />
                      {friend.isOnline && (
                        <span className="absolute right-0 bottom-0 h-3 w-3 rounded-full border-2 border-white bg-ola-primary" />
                      )}
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="block truncate text-base text-black/87">{name}</span>
                      <span className="block truncate text-xs text-black/54">@{friend.username}</span>
                    </span>
                  </button>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    </Dialog>
  );
}

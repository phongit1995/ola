import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Spinner } from '@components';
import { colorForName } from '@lib';
import { RelationshipService } from '@services';
import type { Friend } from '@app-types';

interface ComposerTagPanelProps {
  onMention: (username: string) => void;
}

export function ComposerTagPanel({ onMention }: ComposerTagPanelProps) {
  const { t } = useTranslation();
  const [friends, setFriends] = useState<Friend[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState('');

  useEffect(() => {
    let active = true;
    RelationshipService.friends({ limit: 200 })
      .then((res) => {
        if (active) setFriends(res.friends);
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  const keyword = query.trim().toLowerCase();
  const filtered =
    keyword === ''
      ? friends
      : friends.filter(
          (friend) =>
            friend.username.toLowerCase().includes(keyword) ||
            (friend.fullName ?? '').toLowerCase().includes(keyword)
        );

  return (
    <div className="mt-2 rounded-md border border-black/12">
      <input
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={t('me.tagSearchHint')}
        className="w-full border-b border-black/8 px-3 py-2 text-sm outline-none"
      />
      <div className="max-h-44 overflow-y-auto">
        {loading ? (
          <div className="flex justify-center py-4">
            <Spinner />
          </div>
        ) : filtered.length === 0 ? (
          <p className="py-4 text-center text-sm text-black/54">{t('me.tagEmpty')}</p>
        ) : (
          filtered.map((friend) => {
            const fullName = friend.fullName?.trim();
            return (
              <button
                key={friend.id}
                type="button"
                onClick={() => onMention(friend.username)}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm hover:bg-ola-primary-light"
              >
                <Avatar
                  name={friend.username}
                  color={colorForName(friend.username)}
                  size={28}
                  src={friend.avatar}
                />
                <span className="min-w-0 flex-1 truncate">
                  {fullName != null && fullName !== '' ? (
                    <>
                      <span className="text-black/87">{fullName}</span>{' '}
                      <span className="text-black/45">@{friend.username}</span>
                    </>
                  ) : (
                    <span className="text-black/87">@{friend.username}</span>
                  )}
                </span>
              </button>
            );
          })
        )}
      </div>
    </div>
  );
}

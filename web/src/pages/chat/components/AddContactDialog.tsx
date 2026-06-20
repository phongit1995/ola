import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog } from '@components';
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

  return (
    <Dialog open={open} onClose={onClose} title={t('chat.menuAddContact')}>
      <input
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={t('chat.addContactSearchPlaceholder')}
        className="w-full rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />
      <div className="mt-3 max-h-72 overflow-y-auto">
        {loading ? (
          <p className="py-6 text-center text-sm text-black/54">{t('common.loading')}</p>
        ) : query.trim() === '' ? (
          <p className="py-6 text-center text-sm text-black/54">{t('chat.addContactHint')}</p>
        ) : results.length === 0 ? (
          <p className="py-6 text-center text-sm text-black/54">{t('chat.addContactEmpty')}</p>
        ) : (
          <ul className="divide-y divide-black/8">
            {results.map((user) => {
              const name = user.fullName || user.username;
              const sent = sentIds.includes(user.id);
              return (
                <li key={user.id} className="flex items-center gap-3 py-2">
                  <span className="relative shrink-0">
                    <Avatar name={name} color={colorForName(name)} src={user.avatar} size={40} />
                    {user.isOnline && (
                      <span className="absolute right-0 bottom-0 h-3 w-3 rounded-full border-2 border-white bg-ola-primary" />
                    )}
                  </span>
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-base text-black/87">{name}</span>
                    <span className="block truncate text-xs text-black/54">@{user.username}</span>
                  </span>
                  <button
                    type="button"
                    disabled={sent || busyId === user.id}
                    onClick={() => void sendRequest(user)}
                    className="shrink-0 rounded-full bg-ola-primary px-3 py-1 text-sm font-medium text-white disabled:opacity-50"
                  >
                    {sent ? t('chat.friendRequestSentShort') : t('chat.menuMakeFriend')}
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

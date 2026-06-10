import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { Contact } from '../types';
import { Avatar } from './Avatar';

interface ContactListProps {
  contacts: Contact[];
  onSelect: (contact: Contact) => void;
}

function GenderIcon({ gender }: { gender: Contact['gender'] }) {
  const color = gender === 'male' ? '#4a90d9' : '#e573a8';
  return (
    <span
      className="h-2.5 w-2.5 shrink-0 rounded-full"
      style={{ backgroundColor: color }}
      aria-hidden="true"
    />
  );
}

function ActionRow({
  title,
  subtitle,
  onClick,
}: {
  title: string;
  subtitle: string;
  onClick?: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex w-full items-center gap-3 border-b border-black/12 bg-white px-4 py-3 text-left"
    >
      <span className="flex h-10 w-10 items-center justify-center rounded-full bg-ola-primary-light text-ola-primary-dark">
        <svg viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor" aria-hidden="true">
          <path d="M16 11c1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3zm-8 0c1.66 0 3-1.34 3-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" />
        </svg>
      </span>
      <span className="min-w-0">
        <span className="block text-base text-black/87">{title}</span>
        <span className="block text-xs text-black/54">{subtitle}</span>
      </span>
    </button>
  );
}

export function ContactList({ contacts, onSelect }: ContactListProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');

  const filtered = useMemo(() => {
    const term = query.trim().toLowerCase();
    if (term === '') return contacts;
    return contacts.filter((c) => c.name.toLowerCase().includes(term));
  }, [contacts, query]);

  return (
    <div className="h-full overflow-y-auto bg-[#f3f3f3]">
      <div className="bg-white p-3">
        <input
          type="search"
          value={query}
          onChange={(event) => setQuery(event.target.value)}
          placeholder={t('chat.searchContacts')}
          className="w-full rounded-md border border-black/12 bg-[#f3f3f3] px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
        />
      </div>
      <ActionRow title={t('chat.inviteFriends')} subtitle={t('chat.inviteFriendsSub')} />
      <ActionRow title={t('chat.chatGroup')} subtitle={t('chat.chatGroupSub')} />
      <ul>
        {filtered.map((c) => (
          <li key={c.name}>
            <button
              type="button"
              onClick={() => onSelect(c)}
              className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-3 text-left"
            >
              <Avatar name={c.name} color={c.color} />
              <span className="min-w-0 flex-1">
                <span className="flex items-center gap-2">
                  <GenderIcon gender={c.gender} />
                  <span className="truncate text-base text-black/87">{c.name}</span>
                  {c.vip && (
                    <span className="rounded-sm bg-amber-400 px-1 text-[10px] font-bold text-white">
                      VIP
                    </span>
                  )}
                </span>
                <span className="block truncate text-xs text-black/54">{c.status}</span>
              </span>
              {c.online && (
                <span className="shrink-0 text-xs text-ola-primary">{t('chat.online')}</span>
              )}
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}

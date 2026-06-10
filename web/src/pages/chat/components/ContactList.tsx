import { useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import groupIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';
import type { Contact } from '../types';
import { Avatar } from './Avatar';

interface ContactListProps {
  contacts: Contact[];
  onSelect: (contact: Contact) => void;
}

function GenderIcon({ gender }: { gender: Contact['gender'] }) {
  return (
    <img
      src={gender === 'male' ? maleIcon : femaleIcon}
      alt=""
      className="h-3.5 w-3.5 shrink-0 object-contain"
    />
  );
}

function ActionRow({
  badge,
  title,
  subtitle,
  showChevron = false,
  onClick,
}: {
  badge: ReactNode;
  title: string;
  subtitle: string;
  showChevron?: boolean;
  onClick?: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex w-full items-center gap-3 border-b border-black/12 bg-white px-4 py-3 text-left"
    >
      {badge}
      <span className="min-w-0 flex-1">
        <span className="block text-base text-black/87">{title}</span>
        <span className="block text-xs text-black/54">{subtitle}</span>
      </span>
      {showChevron && <span className="shrink-0 text-xl text-black/26">›</span>}
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
        <div className="flex items-center gap-2 rounded-md border border-black/12 bg-[#f3f3f3] px-3 py-2">
          <svg viewBox="0 0 24 24" className="h-4 w-4 shrink-0 text-black/38" fill="currentColor" aria-hidden="true">
            <path d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5 1.5-1.5-5-5zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z" />
          </svg>
          <input
            type="search"
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder={t('chat.searchContacts')}
            className="w-full bg-transparent text-sm text-black/87 outline-none placeholder:text-black/38"
          />
        </div>
      </div>

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

      <ActionRow
        badge={
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-[#1877f2] text-xl font-bold text-white">
            f
          </span>
        }
        title={t('chat.inviteFriends')}
        subtitle={t('chat.inviteFriendsSub')}
      />
      <ActionRow
        badge={
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-ola-primary">
            <img src={groupIcon} alt="" className="h-6 w-6 object-contain" />
          </span>
        }
        title={t('chat.chatGroup')}
        subtitle={t('chat.chatGroupSub')}
        showChevron
      />
    </div>
  );
}

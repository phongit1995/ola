import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { colorForName } from '@lib';
import type { UserSearchResult } from '@app-types';
import { useUserSearch } from '@ola/shared/stores/user/useUserSearch';
import { UserRow } from './UserRow';

interface UserSearchPickerProps {
  label: string;
  placeholder: string;
  onPick: (user: UserSearchResult) => void;
}

export function UserSearchPicker({
  label,
  placeholder,
  onPick,
}: UserSearchPickerProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const { results, searching } = useUserSearch(query);

  return (
    <div className="flex flex-col gap-1 px-1 py-1">
      <span className="text-base text-black/87">{label}</span>
      <input
        autoFocus
        type="text"
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={placeholder}
        className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
      />
      {query.trim() !== '' && (
        <div className="mt-2 max-h-56 overflow-y-auto rounded border border-black/12">
          {searching ? (
            <p className="py-3 text-center text-sm text-black/54">
              {t('common.loading')}
            </p>
          ) : results.length === 0 ? (
            <p className="py-3 text-center text-sm text-black/54">
              {t('chat.composeSearchEmpty')}
            </p>
          ) : (
            <ul className="divide-y divide-black/8 px-2">
              {results.map((item) => (
                <li key={item.id}>
                  <UserRow
                    name={item.fullName || item.username}
                    username={item.username}
                    avatar={item.avatar}
                    color={colorForName(item.username)}
                    online={item.isOnline}
                    onClick={() => onPick(item)}
                  />
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}

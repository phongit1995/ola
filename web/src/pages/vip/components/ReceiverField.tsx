import { useTranslation } from 'react-i18next';
import { UserRow } from '@components';
import { colorForName } from '@lib';
import type { UserSearchResult } from '@app-types';

interface ReceiverFieldProps {
  receiverUser: UserSearchResult | null;
  receiverQuery: string;
  receiverResults: UserSearchResult[];
  receiverSearching: boolean;
  onChangeQuery: (value: string) => void;
  onPick: (user: UserSearchResult) => void;
  onClear: () => void;
}

export function ReceiverField({
  receiverUser,
  receiverQuery,
  receiverResults,
  receiverSearching,
  onChangeQuery,
  onPick,
  onClear,
}: ReceiverFieldProps) {
  const { t } = useTranslation();
  return (
    <div className="mt-2 bg-white px-4 py-3">
      <span className="text-xs text-black/54">
        {t('vip.buy.receiverLabel')}
      </span>
      {receiverUser != null ? (
        <div className="mt-1 flex items-center rounded border border-black/12 pr-1 pl-2">
          <div className="min-w-0 flex-1">
            <UserRow
              name={receiverUser.fullName || receiverUser.username}
              username={receiverUser.username}
              avatar={receiverUser.avatar}
              color={colorForName(receiverUser.username)}
              online={receiverUser.isOnline}
            />
          </div>
          <button
            type="button"
            onClick={onClear}
            aria-label={t('common.cancel')}
            className="ml-1 shrink-0 rounded-full p-1.5 text-black/40 active:bg-black/5"
          >
            <svg
              viewBox="0 0 24 24"
              className="h-5 w-5"
              fill="currentColor"
              aria-hidden="true"
            >
              <path d="M18.3 5.71 12 12l6.3 6.29-1.41 1.42L10.59 13.4 4.29 19.7 2.88 18.3 9.17 12 2.88 5.71 4.29 4.29l6.3 6.3 6.3-6.3z" />
            </svg>
          </button>
        </div>
      ) : (
        <>
          <input
            type="text"
            value={receiverQuery}
            onChange={(event) => onChangeQuery(event.target.value)}
            placeholder={t('vip.buy.receiverHint')}
            className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
          />
          {receiverQuery.trim() !== '' && (
            <div className="mt-2 max-h-56 overflow-y-auto rounded border border-black/12">
              {receiverSearching ? (
                <p className="py-3 text-center text-sm text-black/54">
                  {t('common.loading')}
                </p>
              ) : receiverResults.length === 0 ? (
                <p className="py-3 text-center text-sm text-black/54">
                  {t('chat.composeSearchEmpty')}
                </p>
              ) : (
                <ul className="divide-y divide-black/8 px-2">
                  {receiverResults.map((item) => (
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
        </>
      )}
    </div>
  );
}

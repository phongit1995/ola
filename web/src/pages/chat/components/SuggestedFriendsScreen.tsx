import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActionButton, Avatar, FullScreenOverlay, ScreenHeader } from '@components';
import { toast } from '@lib';
import { SUGGESTED_FRIENDS } from '../data';
import type { SuggestedFriend } from '../interface';

interface SuggestedFriendsScreenProps {
  onClose: () => void;
}

function IgnoreIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-5 w-5"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      aria-hidden="true"
    >
      <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
    </svg>
  );
}

export function SuggestedFriendsScreen({ onClose }: SuggestedFriendsScreenProps) {
  const { t } = useTranslation();
  const [list, setList] = useState<SuggestedFriend[]>(SUGGESTED_FRIENDS);

  const remove = (name: string) => setList((prev) => prev.filter((friend) => friend.name !== name));

  const addFriend = (friend: SuggestedFriend) => {
    toast.success(t('chat.friendRequestSent'));
    remove(friend.name);
  };

  const addAll = () => {
    if (list.length === 0) return;
    toast.success(t('chat.friendRequestSent'));
    setList([]);
  };

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={t('chat.suggestFriends')} onBack={onClose} align="center" />

      {list.length > 0 && (
        <div className="shrink-0 border-b border-black/12 bg-white/80 p-2">
          <button
            type="button"
            onClick={addAll}
            className="w-full rounded bg-ola-primary py-2 text-sm font-medium text-white"
          >
            {t('chat.makeFriendAll')}
          </button>
        </div>
      )}

      <div className="flex-1 overflow-y-auto">
        {list.length === 0 ? (
          <p className="px-4 py-10 text-center text-sm text-black/54">{t('chat.suggestEmpty')}</p>
        ) : (
          <ul>
            {list.map((friend) => (
              <li
                key={friend.name}
                className="flex items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-3"
              >
                <Avatar name={friend.name} color={friend.color} size={56} />
                <div className="min-w-0 flex-1">
                  <span className="block truncate text-base text-black/87">{friend.name}</span>
                  <ActionButton variant="filled" onClick={() => addFriend(friend)} className="mt-1">
                    {t('chat.menuMakeFriend')}
                  </ActionButton>
                </div>
                <button
                  type="button"
                  aria-label={t('chat.ignoreSuggest')}
                  onClick={() => remove(friend.name)}
                  className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full text-black/38 hover:bg-black/5"
                >
                  <IgnoreIcon />
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>
    </FullScreenOverlay>
  );
}

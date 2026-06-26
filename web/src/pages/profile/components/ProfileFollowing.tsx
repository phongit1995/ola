import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { ProfileFriend } from '../types';
import { FollowingListOverlay } from './FollowingListOverlay';

interface ProfileFollowingProps {
  following: ProfileFriend[];
  onSelect: (friend: ProfileFriend) => void;
}

export function ProfileFollowing({ following, onSelect }: ProfileFollowingProps) {
  const { t } = useTranslation();
  const [showAll, setShowAll] = useState(false);

  return (
    <>
      <div className="mb-2 bg-white pb-1 shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
        <h3 className="mx-4 py-2 text-base text-black/87">{t('profile.following')}</h3>
        <div className="flex gap-1 px-2">
          {following.map((friend) => (
            <button
              key={friend.name}
              type="button"
              onClick={() => onSelect(friend)}
              className="relative aspect-square flex-1 overflow-hidden"
            >
              <span className="flex h-full w-full items-center justify-center text-2xl font-medium text-white" style={{ backgroundColor: friend.color }}>
                {friend.name.charAt(0).toUpperCase()}
              </span>
              <span className="absolute inset-x-0 bottom-0 truncate bg-gradient-to-t from-black/70 to-transparent px-1 py-1 text-center text-xs text-white">
                {friend.name}
              </span>
            </button>
          ))}
        </div>
        <button
          type="button"
          onClick={() => setShowAll(true)}
          className="block w-full py-3 text-center text-sm text-black/54 active:bg-black/5"
        >
          {t('profile.viewAll')}
        </button>
      </div>

      {showAll && (
        <FollowingListOverlay
          following={following}
          onClose={() => setShowAll(false)}
          onSelect={(friend) => {
            setShowAll(false);
            onSelect(friend);
          }}
        />
      )}
    </>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { ProfileFriend } from '../types';
import { FollowingListOverlay } from './FollowingListOverlay';

const FOLLOWING_PREVIEW_COUNT = 5;

interface ProfileFollowingProps {
  userId: string;
  following: ProfileFriend[];
  onSelect: (friend: ProfileFriend) => void;
}

export function ProfileFollowing({
  userId,
  following,
  onSelect,
}: ProfileFollowingProps) {
  const { t } = useTranslation();
  const [showAll, setShowAll] = useState(false);

  return (
    <>
      <div className="mb-2 bg-white pb-1 shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
        <button
          type="button"
          onClick={() => setShowAll(true)}
          className="flex w-full items-center justify-between px-4 py-2 transition-colors hover:bg-black/5 active:bg-black/5"
        >
          <h3 className="text-base text-black/87">{t('profile.following')}</h3>
          <span className="text-sm text-black/38">
            {t('profile.viewAll')} ›
          </span>
        </button>
        <div className="grid grid-cols-5 gap-1 px-2">
          {following.slice(0, FOLLOWING_PREVIEW_COUNT).map((friend) => (
            <button
              key={friend.name}
              type="button"
              onClick={() => onSelect(friend)}
              className="relative aspect-square overflow-hidden"
            >
              {friend.avatar ? (
                <img
                  src={friend.avatar}
                  alt=""
                  className="h-full w-full object-cover"
                />
              ) : (
                <span
                  className="flex h-full w-full items-center justify-center text-2xl font-medium text-white"
                  style={{ backgroundColor: friend.color }}
                >
                  {friend.name.charAt(0).toUpperCase()}
                </span>
              )}
              <span className="absolute inset-x-0 bottom-0 truncate bg-linear-to-t from-black/70 to-transparent px-1 py-1 text-center text-xs text-white">
                @{friend.name}
              </span>
            </button>
          ))}
        </div>
      </div>

      {showAll && (
        <FollowingListOverlay
          userId={userId}
          kind="following"
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

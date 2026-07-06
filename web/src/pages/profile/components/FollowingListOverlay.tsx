import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, UserRow } from '@components';
import type { ProfileFriend } from '../types';

interface FollowingListOverlayProps {
  following: ProfileFriend[];
  onSelect: (friend: ProfileFriend) => void;
  onClose: () => void;
}

export function FollowingListOverlay({ following, onSelect, onClose }: FollowingListOverlayProps) {
  const { t } = useTranslation();

  return (
    <FullScreenOverlay z={50}>
      <ScreenHeader title={t('profile.following')} onBack={onClose} align="center" />
      <div className="flex-1 overflow-y-auto bg-white">
        {following.map((friend) => (
          <div key={friend.name} className="border-b border-black/8 px-4">
            <UserRow
              name={`@${friend.name}`}
              fullName={friend.fullName}
              avatar={friend.avatar}
              color={friend.color}
              layout="inline"
              rounded={false}
              onClick={() => onSelect(friend)}
            />
          </div>
        ))}
      </div>
    </FullScreenOverlay>
  );
}

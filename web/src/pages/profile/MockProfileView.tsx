import { ProfilePage } from './ProfilePage';
import { useMockUserProfile } from './useMockUserProfile';
import type { ProfileFriend } from './types';

interface MockProfileViewProps {
  nick: string;
  color: string;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
}

export function MockProfileView({ nick, color, onClose, onOpenFriend }: MockProfileViewProps) {
  const { profile, relationship, actions, secondary } = useMockUserProfile(nick, color);

  if (!profile) return null;

  return (
    <ProfilePage
      profile={profile}
      relationship={relationship}
      actions={actions}
      secondary={secondary}
      onClose={onClose}
      onOpenFriend={onOpenFriend}
    />
  );
}

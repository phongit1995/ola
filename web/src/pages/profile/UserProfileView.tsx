import { useTranslation } from 'react-i18next';
import { ScreenHeader, FullScreenOverlay, Spinner } from '@components';
import { ProfilePage } from './ProfilePage';
import { useUserProfile } from './useUserProfile';
import type { ProfileFriend } from './types';

interface UserProfileViewProps {
  username: string;
  color: string;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
}

export function UserProfileView({ username, color, onClose, onOpenFriend }: UserProfileViewProps) {
  const { t } = useTranslation();
  const { profile, loading, notFound, relationship, actions, secondary, postActions } =
    useUserProfile(username, color);

  if (profile && !loading) {
    return (
      <ProfilePage
        profile={profile}
        relationship={relationship}
        actions={actions}
        secondary={secondary}
        postActions={postActions}
        onClose={onClose}
        onOpenFriend={onOpenFriend}
      />
    );
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={username} onBack={onClose} />
      <div className="flex flex-1 items-center justify-center px-6 text-center">
        {loading ? (
          <Spinner size={32} />
        ) : (
          <p className="text-sm text-black/54">{notFound ? t('profile.notFound') : ''}</p>
        )}
      </div>
    </FullScreenOverlay>
  );
}

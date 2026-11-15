import { useTranslation } from 'react-i18next';
import { ScreenHeader, FullScreenOverlay, Spinner } from '@components';
import { ProfilePage } from './ProfilePage';
import { useUserProfile } from './useUserProfile';
import type { ProfileFriend } from './types';
import { useCloseOnSocialLimitBuy } from '@ola/shared/stores/socialLimit';

interface UserProfileViewProps {
  username: string;
  color: string;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
  z?: 40 | 50 | 60;
}

export function UserProfileView({
  username,
  color,
  onClose,
  onOpenFriend,
  z = 40,
}: UserProfileViewProps) {
  const { t } = useTranslation();
  useCloseOnSocialLimitBuy(onClose);
  const {
    profile,
    userId,
    loading,
    notFound,
    relationship,
    actions,
    secondary,
    postActions,
  } = useUserProfile(username, color);

  if (profile && !loading) {
    return (
      <ProfilePage
        profile={profile}
        userId={userId}
        relationship={relationship}
        actions={actions}
        secondary={secondary}
        postActions={postActions}
        onClose={onClose}
        onOpenFriend={onOpenFriend}
        z={z}
      />
    );
  }

  return (
    <FullScreenOverlay z={z}>
      <ScreenHeader title={username} onBack={onClose} />
      <div className="flex flex-1 items-center justify-center px-6 text-center">
        {loading ? (
          <Spinner size={32} />
        ) : (
          <p className="text-sm text-black/54">
            {notFound ? t('profile.notFound') : ''}
          </p>
        )}
      </div>
    </FullScreenOverlay>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { UserProfileView } from '../profile/UserProfileView';
import { MeVisitorsList } from './components/MeVisitorsList';

interface MeVisitorsViewProps {
  onClose: () => void;
}

export function MeVisitorsView({ onClose }: MeVisitorsViewProps) {
  const { t } = useTranslation();
  const [profileTarget, setProfileTarget] = useState<{
    username: string;
    color: string;
  } | null>(null);

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('me.tabVisitors')} onBack={onClose} />
      <MeVisitorsList
        className="flex-1"
        onOpenProfile={(nick, color) =>
          setProfileTarget({ username: nick, color })
        }
      />

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) =>
            setProfileTarget({ username: friend.name, color: friend.color })
          }
        />
      )}
    </FullScreenOverlay>
  );
}

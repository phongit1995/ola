import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import leaderboardIcon from '@/assets/icons/gift/gift-leaderboard.webp';
import historyIcon from '@/assets/icons/gift/gift-history.webp';
import sendNowIcon from '@/assets/icons/gift/gift-send-now.webp';
import {
  CharmIcon,
  FullScreenOverlay,
  GiftPickerDialog,
  ScreenHeader,
  type GiftReceiver,
} from '@components';
import { GIFT_SOURCE } from '@constants';
import { colorForName, formatKen } from '@lib';
import { useGiftCatalogStore } from '@ola/shared/stores/gift/giftCatalogStore';
import { useAuthStore } from '@/store/authStore';
import { GiftWallSection } from '../profile/components/GiftWallSection';
import { GiftLeaderboardPage } from './GiftLeaderboardPage';
import { GiftHistoryPage } from './GiftHistoryPage';
import { GiftRecipientDialog } from './GiftRecipientDialog';
import { UserProfileView } from '../profile/UserProfileView';
import type { ProfileFriend } from '../profile/types';

interface GiftHomePageProps {
  onClose: () => void;
}

function HeaderAction({
  label,
  icon,
  onClick,
}: {
  label: string;
  icon: string;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex h-8 shrink-0 items-center gap-1 rounded-full bg-white/15 px-2 text-xs font-medium hover:bg-white/25"
    >
      <img
        src={icon}
        alt=""
        aria-hidden="true"
        className="h-5 w-5 shrink-0 object-contain"
      />
      <span>{label}</span>
    </button>
  );
}

export function GiftHomePage({ onClose }: GiftHomePageProps) {
  const { t } = useTranslation();
  const userId = useAuthStore((s) => s.user?.id ?? '');
  const charm = useAuthStore((s) => s.user?.charm ?? 0);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const giftsEnabled = useGiftCatalogStore((s) => s.settings.enabled);
  const loadGiftSettings = useGiftCatalogStore((s) => s.loadSettings);
  const [leaderboardOpen, setLeaderboardOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [recipientOpen, setRecipientOpen] = useState(false);
  const [receiver, setReceiver] = useState<GiftReceiver | null>(null);
  const [profileTarget, setProfileTarget] = useState<ProfileFriend | null>(
    null
  );

  useEffect(() => {
    void refreshUser();
    void loadGiftSettings();
  }, [refreshUser, loadGiftSettings]);

  function pickReceiver(picked: GiftReceiver) {
    setRecipientOpen(false);
    setReceiver(picked);
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('home.apps.gifts')} onBack={onClose}>
        <div className="flex shrink-0 items-center gap-1">
          <HeaderAction
            icon={leaderboardIcon}
            label={t('gift.wall.leaderboard')}
            onClick={() => setLeaderboardOpen(true)}
          />
          <HeaderAction
            icon={historyIcon}
            label={t('gift.wall.history')}
            onClick={() => setHistoryOpen(true)}
          />
        </div>
      </ScreenHeader>
      <div className="flex-1 overflow-y-auto pb-4">
        <div className="mx-2 mt-2 rounded-lg bg-linear-to-br from-ola-accent to-ola-marriage px-4 py-5 text-center text-white shadow-sm">
          <p className="text-sm text-white/85">{t('gift.charm')}</p>
          <p className="mt-1 flex items-center justify-center gap-2 text-3xl font-bold">
            {formatKen(charm)}
            <CharmIcon className="h-9 w-9" />
          </p>
          {giftsEnabled && (
            <button
              type="button"
              onClick={() => setRecipientOpen(true)}
              className="mt-3 inline-flex items-center gap-1.5 rounded-full bg-white px-5 py-1.5 text-sm font-semibold text-ola-accent-dark shadow-sm active:opacity-80"
            >
              <img
                src={sendNowIcon}
                alt=""
                aria-hidden="true"
                className="h-5 w-5 shrink-0 object-contain"
              />
              {t('gift.sendNow')}
            </button>
          )}
        </div>

        <GiftWallSection userId={userId} isSelf refreshKey={0} columns={4} />
      </div>

      {recipientOpen && (
        <GiftRecipientDialog
          onClose={() => setRecipientOpen(false)}
          onPick={pickReceiver}
        />
      )}
      {receiver != null && (
        <GiftPickerDialog
          open
          source={GIFT_SOURCE.profile}
          receiver={receiver}
          onClose={() => setReceiver(null)}
          onSent={() => void refreshUser()}
        />
      )}
      {leaderboardOpen && (
        <GiftLeaderboardPage z={50} onClose={() => setLeaderboardOpen(false)} />
      )}
      {historyOpen && (
        <GiftHistoryPage
          z={50}
          onClose={() => setHistoryOpen(false)}
          onOpenUser={(user) =>
            setProfileTarget({
              name: user.username,
              color: colorForName(user.username),
            })
          }
        />
      )}
      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.name}
          username={profileTarget.name}
          color={profileTarget.color}
          z={60}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={setProfileTarget}
        />
      )}
    </FullScreenOverlay>
  );
}

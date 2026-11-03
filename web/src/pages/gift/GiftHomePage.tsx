import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { formatKen } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { GiftWallSection } from '../profile/components/GiftWallSection';
import { GiftLeaderboardPage } from './GiftLeaderboardPage';
import { GiftHistoryPage } from './GiftHistoryPage';

interface GiftHomePageProps {
  onClose: () => void;
}

function HomeRow({ label, emoji, onClick }: { label: string; emoji: string; onClick: () => void }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex w-full items-center gap-3 px-4 py-3 text-left text-sm text-black/87 active:bg-black/5"
    >
      <span aria-hidden="true" className="text-lg">
        {emoji}
      </span>
      <span className="flex-1">{label}</span>
      <span aria-hidden="true" className="text-black/26">
        ›
      </span>
    </button>
  );
}

export function GiftHomePage({ onClose }: GiftHomePageProps) {
  const { t } = useTranslation();
  const userId = useAuthStore((s) => s.user?.id ?? '');
  const charm = useAuthStore((s) => s.user?.charm ?? 0);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const [leaderboardOpen, setLeaderboardOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);

  useEffect(() => {
    void refreshUser();
  }, [refreshUser]);

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('home.apps.gifts')} onBack={onClose} />
      <div className="flex-1 overflow-y-auto pb-4">
        <div className="mx-2 mt-2 rounded-lg bg-linear-to-br from-ola-accent to-ola-marriage px-4 py-5 text-center text-white shadow-sm">
          <p className="text-sm text-white/85">{t('gift.charm')}</p>
          <p className="mt-1 text-3xl font-bold">
            <span aria-hidden="true">✨ </span>
            {formatKen(charm)}
          </p>
        </div>

        <div className="mx-2 mt-2 divide-y divide-black/6 overflow-hidden rounded-lg bg-white shadow-sm">
          <HomeRow emoji="🏆" label={t('gift.wall.leaderboard')} onClick={() => setLeaderboardOpen(true)} />
          <HomeRow emoji="🎁" label={t('gift.wall.history')} onClick={() => setHistoryOpen(true)} />
        </div>

        <GiftWallSection
          userId={userId}
          isSelf
          refreshKey={0}
        />
      </div>

      {leaderboardOpen && (
        <GiftLeaderboardPage z={50} onClose={() => setLeaderboardOpen(false)} />
      )}
      {historyOpen && <GiftHistoryPage z={50} onClose={() => setHistoryOpen(false)} />}
    </FullScreenOverlay>
  );
}

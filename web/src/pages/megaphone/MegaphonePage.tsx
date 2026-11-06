import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  FullScreenOverlay,
  ListOptionDialog,
  ReportDialog,
  ScreenHeader,
  Spinner,
  type ListOption,
} from '@components';
import { REPORT_TARGET_TYPE } from '@constants';
import { colorForName, megaphoneSenderName } from '@lib';
import { useMegaphoneHistory } from '@ola/shared/stores/megaphone/useMegaphoneHistory';
import type { Megaphone } from '@app-types';
import megaphoneImage from '@/assets/images/member-megaphone.webp';
import { useAuthStore } from '@/store/authStore';
import { UserProfileView } from '../profile/UserProfileView';
import { MegaphoneComposeDialog } from './components/MegaphoneComposeDialog';
import { MegaphoneHistoryItem } from './components/MegaphoneHistoryItem';

interface ProfileTarget {
  username: string;
  color: string;
}

interface MegaphonePageProps {
  onClose: () => void;
}

export function MegaphonePage({ onClose }: MegaphonePageProps) {
  const { t } = useTranslation();
  const userId = useAuthStore((s) => s.user?.id);
  const history = useMegaphoneHistory();
  const [composeOpen, setComposeOpen] = useState(false);
  const [menuTarget, setMenuTarget] = useState<Megaphone | null>(null);
  const [reportTarget, setReportTarget] = useState<Megaphone | null>(null);
  const [profileTarget, setProfileTarget] = useState<ProfileTarget | null>(null);
  const [nowMs, setNowMs] = useState(() => Date.now());

  function openProfile(megaphone: Megaphone) {
    setProfileTarget({
      username: megaphone.sender.username,
      color: colorForName(megaphoneSenderName(megaphone)),
    });
  }

  const menuOptions: ListOption[] =
    menuTarget == null
      ? []
      : [
          {
            key: 'profile',
            label: t('megaphone.viewProfile'),
            onSelect: () => openProfile(menuTarget),
          },
          {
            key: 'report',
            label: t('megaphone.report'),
            danger: true,
            onSelect: () => setReportTarget(menuTarget),
          },
        ];

  return (
    <FullScreenOverlay keepMegaphone>
      <ScreenHeader title={t('megaphone.title')} onBack={onClose} />
      <div className="flex-1 overflow-y-auto">
        <section className="m-3 flex items-center gap-3 rounded-xl border border-ola-megaphone-line bg-ola-megaphone-soft p-3">
          <img src={megaphoneImage} alt="" className="h-14 w-14 shrink-0 object-contain" draggable={false} />
          <div className="min-w-0 flex-1">
            <p className="text-base font-semibold text-black/87">{t('megaphone.composeTitle')}</p>
          </div>
          <button
            type="button"
            onClick={() => setComposeOpen(true)}
            className="shrink-0 rounded-full bg-ola-warning px-4 py-2 text-sm font-semibold text-white shadow-[0_2px_4px_rgba(0,0,0,0.2)] active:opacity-80"
          >
            {t('megaphone.compose')}
          </button>
        </section>

        <h2 className="px-4 pt-1 pb-2 text-sm font-semibold text-black/54">{t('megaphone.history')}</h2>
        {history.items.length === 0 ? (
          <div className="flex justify-center py-12">
            {history.loading || !history.done ? (
              <Spinner size={24} />
            ) : (
              <span className="text-sm text-black/54">{t('megaphone.historyEmpty')}</span>
            )}
          </div>
        ) : (
          <ul className="divide-y divide-black/6">
            {history.items.map((megaphone) => (
              <MegaphoneHistoryItem
                key={megaphone.id}
                megaphone={megaphone}
                isMine={megaphone.sender.id === userId}
                nowMs={nowMs}
                onOpenProfile={openProfile}
                onMore={setMenuTarget}
              />
            ))}
          </ul>
        )}
        {!history.done && history.items.length > 0 && (
          <div className="flex justify-center py-3">
            {history.loading ? (
              <Spinner size={20} />
            ) : (
              <button type="button" onClick={history.loadMore} className="text-sm font-medium text-ola-primary-dark">
                {t('megaphone.loadMore')}
              </button>
            )}
          </div>
        )}
      </div>

      {composeOpen && (
        <MegaphoneComposeDialog
          onClose={() => setComposeOpen(false)}
          onSent={(result) => {
            setNowMs(Date.now());
            history.prepend(result.megaphone);
          }}
        />
      )}
      <ListOptionDialog
        open={menuTarget != null}
        title={menuTarget != null ? megaphoneSenderName(menuTarget) : ''}
        options={menuOptions}
        onClose={() => setMenuTarget(null)}
      />
      {reportTarget != null && (
        <ReportDialog
          target={{ type: REPORT_TARGET_TYPE.megaphone, id: reportTarget.id }}
          onClose={() => setReportTarget(null)}
        />
      )}
      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          z={50}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget({ username: friend.name, color: friend.color })}
        />
      )}
    </FullScreenOverlay>
  );
}

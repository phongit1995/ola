import { useEffect, useState } from 'react';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import {
  markDailyCheckinPopupShown,
  shouldShowDailyCheckinPopup,
  useDailyCheckinStore,
} from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { DailyCheckinNoticeDialog } from './components/DailyCheckinNoticeDialog';
import { DailyCheckinOpenedDialog } from './components/DailyCheckinOpenedDialog';
import { DailyCheckinPopup } from './DailyCheckinPopup';

export function DailyCheckinHost() {
  const authReady = useAuthStore((s) => s.authReady);
  const status = useDailyCheckinStore((s) => s.status);
  const opened = useDailyCheckinStore((s) => s.opened);
  const notice = useDailyCheckinStore((s) => s.notice);
  const dismissOpened = useDailyCheckinStore((s) => s.dismissOpened);
  const dismissNotice = useDailyCheckinStore((s) => s.dismissNotice);
  const openApp = useAppOverlayStore((s) => s.push);
  const [popupOpen, setPopupOpen] = useState(false);

  useEffect(
    () =>
      useDailyCheckinStore.subscribe((state, prev) => {
        if (state.status === prev.status || state.status == null) return;
        if (!shouldShowDailyCheckinPopup(state.status)) return;
        markDailyCheckinPopupShown(state.status);
        const onPage = useAppOverlayStore.getState().stack.some((entry) => entry.kind === 'dailyCheckin');
        if (!onPage) setPopupOpen(true);
      }),
    []
  );

  useEffect(() => {
    if (!authReady) return;
    const load = () => void useDailyCheckinStore.getState().load();
    load();
    const onVisible = () => {
      if (document.visibilityState === 'visible') load();
    };
    document.addEventListener('visibilitychange', onVisible);
    return () => document.removeEventListener('visibilitychange', onVisible);
  }, [authReady]);

  function verifyEmail() {
    dismissNotice();
    setPopupOpen(false);
    openApp('profile');
  }

  return (
    <>
      {popupOpen && status?.enabled === true && (
        <DailyCheckinPopup status={status} onClose={() => setPopupOpen(false)} onVerifyEmail={verifyEmail} />
      )}
      {opened != null && (
        <DailyCheckinOpenedDialog key={`${status?.month ?? ''}-${opened.slot}`} opened={opened} onClose={dismissOpened} />
      )}
      {notice != null && <DailyCheckinNoticeDialog notice={notice} onClose={dismissNotice} onVerifyEmail={verifyEmail} />}
    </>
  );
}

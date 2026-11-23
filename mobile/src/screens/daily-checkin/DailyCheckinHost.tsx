import { useCallback, useEffect, useState } from 'react';
import { AppState } from 'react-native';
import type { NavigationContainerRefWithCurrent, NavigationProp, ParamListBase } from '@react-navigation/native';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import {
  markDailyCheckinPopupShown,
  shouldShowDailyCheckinPopup,
  useDailyCheckinStore,
} from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinSlot } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { useAfterDismiss } from '@hooks/useAfterDismiss';
import { suppressAppReviewForSession } from '@lib/appReview';
import { ROOT_ROUTES } from '@navigation/routes';
import { useAppLockStore } from '@store/appLockStore';
import { useAppUpdateStore } from '@store/appUpdateStore';
import { DailyCheckinNoticePanel, DailyCheckinOpenedPanel, DailyCheckinSlotPanel } from './components/DailyCheckinPanels';
import { DailyCheckinPopupPanel } from './components/DailyCheckinPopupPanel';
import { CHECKIN_POPUP_DELAY_MS, CHECKIN_POPUP_MAX_WIDTH } from './constants';
import { goDailyCheckinTask } from './useDailyCheckinTask';

interface DailyCheckinHostProps {
  navigationRef: NavigationContainerRefWithCurrent<ParamListBase>;
}

export function DailyCheckinHost({ navigationRef }: DailyCheckinHostProps) {
  const authReady = useAuthStore((s) => s.authReady);
  const signedIn = useAuthStore((s) => s.user != null);
  const status = useDailyCheckinStore((s) => s.status);
  const opened = useDailyCheckinStore((s) => s.opened);
  const notice = useDailyCheckinStore((s) => s.notice);
  const dismissOpened = useDailyCheckinStore((s) => s.dismissOpened);
  const dismissNotice = useDailyCheckinStore((s) => s.dismissNotice);
  const updateRequired = useAppUpdateStore((s) => s.required);
  const lockBlocked = useAppLockStore((s) => s.enabled && (s.locked || s.covered));
  const [ready, setReady] = useState(false);
  const [popupWanted, setPopupWanted] = useState(false);
  const [selected, setSelected] = useState<DailyCheckinSlot | null>(null);
  const afterDismiss = useAfterDismiss();

  useEffect(() => {
    const timer = setTimeout(() => setReady(true), CHECKIN_POPUP_DELAY_MS);
    return () => clearTimeout(timer);
  }, []);

  useEffect(
    () =>
      useDailyCheckinStore.subscribe((state, prev) => {
        if (state.popupRequest > prev.popupRequest) {
          setPopupWanted(true);
          return;
        }
        if (state.status === prev.status || state.status == null) return;
        if (!shouldShowDailyCheckinPopup(state.status)) return;
        if (navigationRef.getCurrentRoute()?.name === ROOT_ROUTES.DailyCheckin) {
          markDailyCheckinPopupShown(state.status);
          return;
        }
        setPopupWanted(true);
      }),
    [navigationRef]
  );

  useEffect(() => {
    if (!authReady || !signedIn) return;
    const load = () => void useDailyCheckinStore.getState().load();
    load();
    const subscription = AppState.addEventListener('change', (state) => {
      if (state === 'active') load();
    });
    return () => subscription.remove();
  }, [authReady, signedIn]);

  const gatesClear = ready && signedIn && !updateRequired && !lockBlocked;
  const popupVisible = popupWanted && gatesClear && status?.enabled === true;
  const standaloneVisible = !popupVisible && gatesClear && (opened != null || notice != null);

  useEffect(() => {
    if (!popupVisible || status == null) return;
    markDailyCheckinPopupShown(status);
    suppressAppReviewForSession();
  }, [popupVisible, status]);

  const navigate = useCallback<NavigationProp<ParamListBase>['navigate']>(
    (...args: Parameters<NavigationProp<ParamListBase>['navigate']>) => {
      if (navigationRef.isReady()) navigationRef.navigate(...(args as Parameters<typeof navigationRef.navigate>));
    },
    [navigationRef]
  );

  function closePopup() {
    setSelected(null);
    setPopupWanted(false);
    afterDismiss.runAfterClose();
  }

  function goTask() {
    const code = status?.todayTask?.code;
    afterDismiss.schedule(() => goDailyCheckinTask(navigate, code));
    closePopup();
  }

  function verifyEmail() {
    dismissNotice();
    afterDismiss.schedule(() => navigate(ROOT_ROUTES.EditProfile));
    if (popupVisible) {
      closePopup();
      return;
    }
    afterDismiss.runAfterClose();
  }

  function renderPanel() {
    if (opened != null) return <DailyCheckinOpenedPanel key={`${status?.month ?? ''}-${opened.slot}`} opened={opened} onClose={dismissOpened} />;
    if (notice != null) return <DailyCheckinNoticePanel notice={notice} onClose={dismissNotice} onVerifyEmail={verifyEmail} />;
    if (selected != null) return <DailyCheckinSlotPanel slot={selected} onClose={() => setSelected(null)} />;
    if (status == null) return null;
    return (
      <DailyCheckinPopupPanel status={status} onClose={closePopup} onSelect={setSelected} onGoTask={goTask} />
    );
  }

  return (
    <>
      <Dialog
        visible={popupVisible}
        bare
        showToasts
        maxWidth={CHECKIN_POPUP_MAX_WIDTH}
        avoidKeyboard={false}
        dismissOnBackdrop={opened == null}
        onClose={closePopup}
        onDismiss={afterDismiss.onDismiss}
      >
        {renderPanel()}
      </Dialog>
      <Dialog
        visible={standaloneVisible}
        bare
        showToasts
        avoidKeyboard={false}
        dismissOnBackdrop={opened == null}
        onClose={opened != null ? dismissOpened : dismissNotice}
        onDismiss={afterDismiss.onDismiss}
      >
        {opened != null ? (
          <DailyCheckinOpenedPanel key={`${status?.month ?? ''}-${opened.slot}`} opened={opened} onClose={dismissOpened} />
        ) : notice != null ? (
          <DailyCheckinNoticePanel notice={notice} onClose={dismissNotice} onVerifyEmail={verifyEmail} />
        ) : null}
      </Dialog>
    </>
  );
}

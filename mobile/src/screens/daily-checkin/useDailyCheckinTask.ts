import { useCallback } from 'react';
import type { NavigationProp, ParamListBase } from '@react-navigation/native';
import { dailyCheckinTaskTarget } from '@ola/shared/lib';
import { useMomentConfigStore } from '@ola/shared/stores/moment/momentConfigStore';
import { useStoryConfigStore } from '@ola/shared/stores/story/storyConfigStore';
import { ROOT_ROUTES, TAB_ROUTES } from '@navigation/routes';
import { useNavIntentStore } from '@store/navIntentStore';

type Navigate = NavigationProp<ParamListBase>['navigate'];

function openTab(navigate: Navigate, screen: string) {
  navigate(ROOT_ROUTES.MainTabs, { screen }, { pop: true });
}

export function goDailyCheckinTask(navigate: Navigate, code: string | undefined): void {
  const intents = useNavIntentStore.getState();
  switch (dailyCheckinTaskTarget(code)) {
    case 'meComposer':
      intents.request('meComposer');
      openTab(navigate, TAB_ROUTES.Me);
      break;
    case 'momentCreate':
      if (useMomentConfigStore.getState().enabled === true) intents.request('momentComposer');
      openTab(navigate, TAB_ROUTES.Me);
      break;
    case 'meTab':
    case 'momentList':
      openTab(navigate, TAB_ROUTES.Me);
      break;
    case 'storyTab':
      openTab(navigate, useStoryConfigStore.getState().enabled === true ? TAB_ROUTES.Story : TAB_ROUTES.Me);
      break;
    case 'gameTab':
      openTab(navigate, TAB_ROUTES.Game);
      break;
    case 'gifts':
      navigate(ROOT_ROUTES.GiftHome);
      break;
    case 'megaphone':
      navigate(ROOT_ROUTES.Megaphone);
      break;
    default:
      break;
  }
}

export function useDailyCheckinTask(navigate: Navigate): (code: string | undefined) => void {
  return useCallback((code) => goDailyCheckinTask(navigate, code), [navigate]);
}

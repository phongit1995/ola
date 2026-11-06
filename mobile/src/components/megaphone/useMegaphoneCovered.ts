import { useCallback, useSyncExternalStore } from 'react';
import { AppState } from 'react-native';
import type { NavigationContainerRefWithCurrent, ParamListBase } from '@react-navigation/native';
import { CHAT_ROUTES, ROOM_ROUTES, ROOT_ROUTES, STORY_ROUTES, TAB_ROUTES } from '@navigation/routes';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { useOpenModalStore } from '@store/openModalStore';

const MEGAPHONE_ROUTES: ReadonlySet<string> = new Set([
  ...Object.values(TAB_ROUTES),
  CHAT_ROUTES.ChatList,
  ROOM_ROUTES.RoomList,
  ROOM_ROUTES.RoomChat,
  ROOT_ROUTES.Megaphone,
  STORY_ROUTES.StoryList,
]);

function subscribeAppState(onChange: () => void) {
  const subscription = AppState.addEventListener('change', onChange);
  return () => subscription.remove();
}

function appStateSnapshot() {
  return AppState.currentState;
}

export function useMegaphoneCovered(navigationRef: NavigationContainerRefWithCurrent<ParamListBase>): boolean {
  const subscribeRoute = useCallback(
    (onChange: () => void) => {
      const removeReady = navigationRef.addListener('ready', onChange);
      const removeState = navigationRef.addListener('state', onChange);
      return () => {
        removeReady();
        removeState();
      };
    },
    [navigationRef],
  );
  const routeSnapshot = useCallback(
    () => (navigationRef.isReady() ? navigationRef.getCurrentRoute()?.name : undefined),
    [navigationRef],
  );
  const routeName = useSyncExternalStore(subscribeRoute, routeSnapshot);
  const appState = useSyncExternalStore(subscribeAppState, appStateSnapshot);
  const modalOpen = useOpenModalStore((s) => s.count > 0);
  const arcadeOpen = useArcadeOverlayStore((s) => s.active != null && !s.minimized);

  return (
    appState !== 'active' ||
    modalOpen ||
    arcadeOpen ||
    routeName == null ||
    !MEGAPHONE_ROUTES.has(routeName)
  );
}

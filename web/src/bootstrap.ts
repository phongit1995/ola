import {
  configureDeviceInfo,
  configureEnv,
  configureSound,
} from '@ola/shared/platform';
import { registerOnLogout } from '@ola/shared/stores/authStore';
import { useKenTreasureStore } from '@ola/shared/stores/kenTreasureStore';
import { useMediaViewerStore } from '@ola/shared/stores/mediaViewerStore';
import { useRoomChatStore } from '@ola/shared/stores/room/roomChatStore';
import { webEnv, initAnalytics } from '@config';
import {
  playKenChestSound,
  playKenCreditSound,
  playMessageSound,
  playRoomTagSound,
} from '@lib';
import { APP_VERSION } from '@/pages/login/constants';
import { useArcadeOverlayStore } from './store/arcadeOverlayStore';
import { useGameOverlayStore } from './store/gameOverlayStore';
import { useAppOverlayStore } from './store/appOverlayStore';
import { useSettingsStore } from './store/settingsStore';

configureEnv(webEnv);
configureDeviceInfo({ platform: 'web', appVersion: APP_VERSION });
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
  playKenChest: playKenChestSound,
  playKenCredit: playKenCreditSound,
});
void initAnalytics();
registerOnLogout(() => {
  useRoomChatStore.getState().reset();
  useGameOverlayStore.getState().close();
  useArcadeOverlayStore.getState().close();
  useKenTreasureStore.getState().reset();
  useMediaViewerStore.getState().close();
  useAppOverlayStore.getState().reset();
  useSettingsStore.getState().reset();
});

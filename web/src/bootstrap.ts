import { configureDeviceInfo, configureEnv, configureSound } from '@ola/shared/platform';
import { registerOnLogout } from '@ola/shared/stores/authStore';
import { useRoomChatStore } from '@ola/shared/stores/roomChatStore';
import { webEnv } from '@config';
import { playMessageSound, playRoomTagSound } from '@lib';
import { APP_VERSION } from '@/pages/login/constants';
import { useGameOverlayStore } from './store/gameOverlayStore';
import { useAppOverlayStore } from './store/appOverlayStore';
import { useSettingsStore } from './store/settingsStore';

configureEnv(webEnv);
configureDeviceInfo({ platform: 'web', appVersion: APP_VERSION });
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
});
registerOnLogout(() => {
  useRoomChatStore.getState().reset();
  useGameOverlayStore.getState().close();
  useAppOverlayStore.getState().reset();
  useSettingsStore.getState().reset();
});

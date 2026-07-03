import { configureEnv, configureSound } from '@ola/shared/platform';
import { registerOnLogout } from '@ola/shared/stores/authStore';
import { webEnv } from '@config';
import { playMessageSound, playRoomTagSound } from '@lib';
import { useGameOverlayStore } from './store/gameOverlayStore';
import { useAppOverlayStore } from './store/appOverlayStore';
import { useSettingsStore } from './store/settingsStore';

configureEnv(webEnv);
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
});
registerOnLogout(() => {
  useGameOverlayStore.getState().close();
  useAppOverlayStore.getState().reset();
  useSettingsStore.getState().reset();
});

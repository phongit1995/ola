import { configureEnv, configureSound } from '@ola/shared/platform';
import { registerOnLogout } from '@ola/shared/stores/authStore';
import { webEnv } from './shared/config/env';
import { playMessageSound, playRoomTagSound } from './shared/lib/sound';
import { useGameOverlayStore } from './store/gameOverlayStore';
import { useAppOverlayStore } from './store/appOverlayStore';

configureEnv(webEnv);
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
});
registerOnLogout(() => {
  useGameOverlayStore.getState().close();
  useAppOverlayStore.getState().reset();
});

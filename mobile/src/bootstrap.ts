import 'react-native-get-random-values';
import './platform/configureStorage';
import { Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';
import { configureDeviceInfo, configureEnv, configureSound } from '@ola/shared/platform';
import { registerOnLogout } from '@ola/shared/stores/authStore';
import { useKenTreasureStore } from '@ola/shared/stores/kenTreasureStore';
import { useMediaViewerStore } from '@ola/shared/stores/mediaViewerStore';
import { useArcadeOverlayStore } from './store/arcadeOverlayStore';
import { mobileEnv } from './platform/env';
import { configureRichTextNative } from './lib/richTextNativeConfig';
import {
  playKenChestSound,
  playKenCreditSound,
  playMessageSound,
  playRoomTagSound,
} from './lib/sound';

configureEnv(mobileEnv);
configureDeviceInfo({
  platform: Platform.OS,
  deviceName: DeviceInfo.getModel(),
  appVersion: `${DeviceInfo.getVersion()} (${DeviceInfo.getBuildNumber()})`,
});
configureRichTextNative();
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
  playKenChest: playKenChestSound,
  playKenCredit: playKenCreditSound,
});
registerOnLogout(() => {
  useArcadeOverlayStore.getState().close();
  useKenTreasureStore.getState().reset();
  useMediaViewerStore.getState().close();
});

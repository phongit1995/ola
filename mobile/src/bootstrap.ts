import 'react-native-get-random-values';
import './platform/configureStorage';
import { Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';
import { configureDeviceInfo, configureEnv, configureSound } from '@ola/shared/platform';
import { useAnnouncementStore } from '@ola/shared/stores/announcementStore';
import { registerOnLogout } from '@ola/shared/stores/auth/authStore';
import { useKenTreasureStore } from '@ola/shared/stores/ken/kenTreasureStore';
import { useMediaViewerStore } from '@ola/shared/stores/mediaViewerStore';
import { useRoomChatStore } from '@ola/shared/stores/room/roomChatStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { useArcadeOverlayStore } from './store/arcadeOverlayStore';
import { clearAllPushNotifications } from '@lib/push';
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
  useRoomChatStore.getState().reset();
  useArcadeOverlayStore.getState().close();
  useKenTreasureStore.getState().reset();
  useMediaViewerStore.getState().close();
  useSettingsStore.getState().reset();
  useAnnouncementStore.getState().reset();
  void clearAllPushNotifications();
});

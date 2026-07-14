import 'react-native-get-random-values';
import './platform/configureStorage';
import { Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';
import { configureDeviceInfo, configureEnv, configureSound } from '@ola/shared/platform';
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

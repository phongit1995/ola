import 'react-native-get-random-values';
import './platform/configureStorage';
import { configureEnv, configureSound } from '@ola/shared/platform';
import { mobileEnv } from './platform/env';
import { configureRichTextNative } from './lib/richTextNativeConfig';
import {
  playKenChestSound,
  playKenCreditSound,
  playMessageSound,
  playRoomTagSound,
} from './lib/sound';

configureEnv(mobileEnv);
configureRichTextNative();
configureSound({
  playMessage: playMessageSound,
  playRoomTag: playRoomTagSound,
  playKenChest: playKenChestSound,
  playKenCredit: playKenCreditSound,
});

import 'react-native-get-random-values';
import { configureEnv, configureKeyValueStorage } from '@ola/shared/platform';
import { mobileEnv } from './platform/env';
import { mmkvStorage } from './platform/storage';

configureEnv(mobileEnv);
configureKeyValueStorage(mmkvStorage);

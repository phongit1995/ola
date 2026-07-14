import { configureKeyValueStorage } from '@ola/shared/platform';
import { mmkvStorage } from './storage';

configureKeyValueStorage(mmkvStorage);

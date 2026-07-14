import { AppState } from 'react-native';
import { configurePresenceForeground } from '@ola/shared/stores/presenceStore';

configurePresenceForeground(() => AppState.currentState === 'active');

export * from '@ola/shared/stores/presenceHooks';

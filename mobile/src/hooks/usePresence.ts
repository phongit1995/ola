import { AppState } from 'react-native';
import { configurePresenceForeground } from '@ola/shared/stores/presence/presenceStore';

configurePresenceForeground(() => AppState.currentState === 'active');

export * from '@ola/shared/stores/presence/presenceHooks';

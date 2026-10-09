import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  biometryType(): Promise<string>;
  authenticate(title: string, subtitle: string, cancelLabel: string): Promise<string>;
}

export default TurboModuleRegistry.get<Spec>('OlaAppLock');

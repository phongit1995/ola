import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';
import type { UnsafeObject } from 'react-native/Libraries/Types/CodegenTypes';

export interface Spec extends TurboModule {
  configure(config: UnsafeObject): void;
  measure(content: string, maxWidth: number, fontSize: number, maxLines: number): number[];
}

export default TurboModuleRegistry.get<Spec>('OlaRichText');

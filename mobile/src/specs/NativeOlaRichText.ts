import type { CodegenTypes, TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  configure(config: CodegenTypes.UnsafeObject): void;
  measure(content: string, maxWidth: number, fontSize: number, maxLines: number): number[];
}

export default TurboModuleRegistry.get<Spec>('OlaRichText');

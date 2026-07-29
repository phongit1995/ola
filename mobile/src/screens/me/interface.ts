import type { NativeUploadFile } from '@ola/shared/types';

export interface PickedPhoto {
  id: string;
  uri: string;
  file?: NativeUploadFile;
}

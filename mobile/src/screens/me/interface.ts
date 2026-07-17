import type { NativeUploadFile } from '@ola/shared/lib';

export interface PickedPhoto {
  id: string;
  uri: string;
  file?: NativeUploadFile;
}

import type { NativeUploadFile } from '@ola/shared/types';

export interface PendingComposerImage {
  id: string;
  uri: string;
  file: NativeUploadFile;
}

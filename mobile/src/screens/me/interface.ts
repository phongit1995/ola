import type { MeAudioDraft, NativeUploadFile } from '@ola/shared/types';

export interface PickedPhoto {
  id: string;
  uri: string;
  file?: NativeUploadFile;
}

export interface PickedAudio {
  draft: MeAudioDraft;
  uri: string;
  temporary: boolean;
}

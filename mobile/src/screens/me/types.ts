import type { MeAudioDraft, NativeUploadFile } from '@ola/shared/types';

export type MeTab = 'community' | 'personal' | 'clan';

export type ComposerPanel = 'smiley' | 'tag' | 'sticker' | 'checkin' | null;

export type ComposerAttachKey = 'local' | 'voice' | 'smiley' | 'tag' | 'checkin' | 'sticker';

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

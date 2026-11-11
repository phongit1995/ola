import { launchImageLibrary, type Asset } from 'react-native-image-picker';
import { keepLocalCopy, pick, types } from '@react-native-documents/picker';
import {
  MOMENT_MAX_VIDEO_BYTES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_MUSIC_MAX_BYTES,
  MOMENT_TYPE,
  MOMENT_VIDEO_DURATION_TOLERANCE_S,
} from '@ola/shared/constants';
import { isMomentMusicFile, isMomentVideoFile } from '@ola/shared/lib';
import type { MomentMediaDraft, NativeUploadFile } from '@ola/shared/types';
import { uploadFileFromAsset } from '@lib/imagePicker';

const DEFAULT_VIDEO_MIME = 'video/mp4';
const DEFAULT_MUSIC_MIME = 'audio/mpeg';
const DEFAULT_MUSIC_NAME = 'music.mp3';

export type MomentMusicPick =
  | { kind: 'cancelled' }
  | { kind: 'unsupported' }
  | { kind: 'tooLarge' }
  | { kind: 'picked'; file: NativeUploadFile; fileName: string };

export async function pickMomentMusic(): Promise<MomentMusicPick> {
  const [picked] = await pick({ type: [types.audio], allowMultiSelection: false });
  if (picked == null) return { kind: 'cancelled' };
  const fileName = picked.name ?? DEFAULT_MUSIC_NAME;
  if (!isMomentMusicFile(fileName)) return { kind: 'unsupported' };
  if (picked.size != null && picked.size > MOMENT_MUSIC_MAX_BYTES) return { kind: 'tooLarge' };
  const [copy] = await keepLocalCopy({
    files: [{ uri: picked.uri, fileName }],
    destination: 'cachesDirectory',
  });
  if (copy.status !== 'success') return { kind: 'cancelled' };
  return {
    kind: 'picked',
    fileName,
    file: { uri: copy.localUri, name: fileName, type: picked.type ?? DEFAULT_MUSIC_MIME },
  };
}

export type MomentVideoPick =
  | { kind: 'cancelled' }
  | { kind: 'unsupported' }
  | { kind: 'tooLong' }
  | { kind: 'tooLarge' }
  | { kind: 'picked'; media: MomentMediaDraft };

function withUri(asset: Asset): (Asset & { uri: string }) | null {
  return asset.uri ? { ...asset, uri: asset.uri } : null;
}

export async function pickMomentImages(limit: number): Promise<MomentMediaDraft[]> {
  const result = await launchImageLibrary({ mediaType: 'photo', selectionLimit: limit });
  return (result.assets ?? []).flatMap((asset) => {
    const picked = withUri(asset);
    if (picked == null) return [];
    const file = uploadFileFromAsset(picked);
    return [{ type: MOMENT_TYPE.image, url: file.uri, file }];
  });
}

export async function pickMomentVideo(): Promise<MomentVideoPick> {
  const result = await launchImageLibrary({
    mediaType: 'video',
    selectionLimit: 1,
    assetRepresentationMode: 'current',
  });
  const asset = result.assets?.[0];
  const picked = asset ? withUri(asset) : null;
  if (result.didCancel || picked == null) return { kind: 'cancelled' };
  const base = uploadFileFromAsset(picked);
  if (!isMomentVideoFile(base)) return { kind: 'unsupported' };
  const file = { ...base, type: base.type || DEFAULT_VIDEO_MIME };
  const duration = picked.duration;
  if (duration != null && duration > MOMENT_MAX_VIDEO_SECONDS + MOMENT_VIDEO_DURATION_TOLERANCE_S) {
    return { kind: 'tooLong' };
  }
  if (file.size != null && file.size > MOMENT_MAX_VIDEO_BYTES) return { kind: 'tooLarge' };
  return {
    kind: 'picked',
    media: { type: MOMENT_TYPE.video, url: file.uri, file, duration, playable: true },
  };
}

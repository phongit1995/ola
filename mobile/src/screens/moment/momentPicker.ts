import { launchImageLibrary, type Asset } from 'react-native-image-picker';
import {
  MOMENT_MAX_VIDEO_BYTES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_TYPE,
  MOMENT_VIDEO_DURATION_TOLERANCE_S,
} from '@ola/shared/constants';
import { isMomentVideoFile } from '@ola/shared/lib';
import type { MomentMediaDraft } from '@ola/shared/types';
import { uploadFileFromAsset } from '@lib/imagePicker';

const DEFAULT_VIDEO_MIME = 'video/mp4';

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

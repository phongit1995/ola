import { launchImageLibrary, type Asset } from 'react-native-image-picker';
import {
  REEL_MAX_VIDEO_BYTES,
  REEL_MAX_VIDEO_SECONDS,
  REEL_TYPE,
  REEL_VIDEO_DURATION_TOLERANCE_S,
} from '@ola/shared/constants';
import { isReelVideoFile } from '@ola/shared/lib';
import type { ReelMediaDraft } from '@ola/shared/types';
import { uploadFileFromAsset } from '@lib/imagePicker';

const DEFAULT_VIDEO_MIME = 'video/mp4';

export type ReelVideoPick =
  | { kind: 'cancelled' }
  | { kind: 'unsupported' }
  | { kind: 'tooLong' }
  | { kind: 'tooLarge' }
  | { kind: 'picked'; media: ReelMediaDraft };

function withUri(asset: Asset): (Asset & { uri: string }) | null {
  return asset.uri ? { ...asset, uri: asset.uri } : null;
}

export async function pickReelImages(limit: number): Promise<ReelMediaDraft[]> {
  const result = await launchImageLibrary({ mediaType: 'photo', selectionLimit: limit });
  return (result.assets ?? []).flatMap((asset) => {
    const picked = withUri(asset);
    if (picked == null) return [];
    const file = uploadFileFromAsset(picked);
    return [{ type: REEL_TYPE.image, url: file.uri, file }];
  });
}

export async function pickReelVideo(): Promise<ReelVideoPick> {
  const result = await launchImageLibrary({
    mediaType: 'video',
    selectionLimit: 1,
    assetRepresentationMode: 'current',
  });
  const asset = result.assets?.[0];
  const picked = asset ? withUri(asset) : null;
  if (result.didCancel || picked == null) return { kind: 'cancelled' };
  const base = uploadFileFromAsset(picked);
  if (!isReelVideoFile(base)) return { kind: 'unsupported' };
  const file = { ...base, type: base.type || DEFAULT_VIDEO_MIME };
  const duration = picked.duration;
  if (duration != null && duration > REEL_MAX_VIDEO_SECONDS + REEL_VIDEO_DURATION_TOLERANCE_S) {
    return { kind: 'tooLong' };
  }
  if (file.size != null && file.size > REEL_MAX_VIDEO_BYTES) return { kind: 'tooLarge' };
  return {
    kind: 'picked',
    media: { type: REEL_TYPE.video, url: file.uri, file, duration, playable: true },
  };
}

import { REEL_THUMB_MAX_EDGE, REEL_TYPE } from '@ola/shared/constants';
import { asNativeUploadFile, reelCreateItems } from '@ola/shared/lib';
import type { CreateReelsInput } from '@ola/shared/services';
import type { NativeUploadFile, ReelDraftSlide, ReelVisibility } from '@ola/shared/types';
import { compressImagesForUpload, createJpegThumbnail } from '@lib/compressImage';

type ReelUploadSlide = Pick<ReelDraftSlide, 'media' | 'background' | 'overlays'>;

function slideFiles(slides: readonly ReelUploadSlide[]): NativeUploadFile[] {
  return slides.flatMap((slide) => {
    const file = slide.media?.file ? asNativeUploadFile(slide.media.file) : undefined;
    return file ? [file] : [];
  });
}

async function thumbnailsFor(files: readonly NativeUploadFile[]): Promise<NativeUploadFile[]> {
  const thumbs: NativeUploadFile[] = [];
  for (const file of files) thumbs.push(await createJpegThumbnail(file, REEL_THUMB_MAX_EDGE));
  return thumbs;
}

export async function buildReelUpload(
  visibility: ReelVisibility,
  slides: readonly ReelUploadSlide[]
): Promise<CreateReelsInput> {
  const type = slides[0]?.media?.type ?? REEL_TYPE.text;
  const items = reelCreateItems(slides);
  if (type === REEL_TYPE.image) {
    const files = slideFiles(slides);
    const images = await compressImagesForUpload(files);
    const thumbs = await thumbnailsFor(files);
    return { type, visibility, items, images, thumbs };
  }
  if (type === REEL_TYPE.video) {
    return { type, visibility, items, video: slides[0]?.media?.file };
  }
  return { type, visibility, items };
}

import { MOMENT_THUMB_MAX_EDGE, MOMENT_TYPE } from '@ola/shared/constants';
import { asNativeUploadFile, momentCreateItems, momentUploadType } from '@ola/shared/lib';
import type { CreateMomentsInput } from '@ola/shared/services';
import type { NativeUploadFile, MomentDraftSlide, MomentVisibility } from '@ola/shared/types';
import { compressImagesForUpload, createJpegThumbnail } from '@lib/compressImage';

type MomentUploadSlide = Pick<MomentDraftSlide, 'media' | 'background' | 'overlays'>;

function slideFiles(slides: readonly MomentUploadSlide[]): NativeUploadFile[] {
  return slides.flatMap((slide) => {
    const file = slide.media?.file ? asNativeUploadFile(slide.media.file) : undefined;
    return file ? [file] : [];
  });
}

async function thumbnailsFor(files: readonly NativeUploadFile[]): Promise<NativeUploadFile[]> {
  const thumbs: NativeUploadFile[] = [];
  for (const file of files) thumbs.push(await createJpegThumbnail(file, MOMENT_THUMB_MAX_EDGE));
  return thumbs;
}

export async function buildMomentUpload(
  visibility: MomentVisibility,
  slides: readonly MomentUploadSlide[]
): Promise<CreateMomentsInput> {
  const type = momentUploadType(slides);
  const items = momentCreateItems(slides);
  if (type === MOMENT_TYPE.image) {
    const files = slideFiles(slides);
    const images = await compressImagesForUpload(files);
    const thumbs = await thumbnailsFor(files);
    return { type, visibility, items, images, thumbs };
  }
  if (type === MOMENT_TYPE.video) {
    return { type, visibility, items, video: slides[0]?.media?.file };
  }
  return { type, visibility, items };
}

import { MOMENT_THUMB_MAX_EDGE, MOMENT_TYPE } from '@constants';
import { compressImagesForUpload, createJpegThumbnail, momentCreateItems, momentUploadType } from '@lib';
import type { CreateMomentsInput } from '@services';
import type { MomentDraftSlide, MomentVisibility } from '@app-types';

type MomentUploadSlide = Pick<MomentDraftSlide, 'media' | 'background' | 'overlays'>;

async function posterFile(posterUrl: string | undefined): Promise<File | undefined> {
  if (!posterUrl) return undefined;
  try {
    const blob = await (await fetch(posterUrl)).blob();
    return new File([blob], 'poster.jpg', { type: 'image/jpeg' });
  } catch {
    return undefined;
  }
}

function slideFiles(slides: readonly MomentUploadSlide[]): File[] {
  return slides.flatMap((slide) =>
    slide.media?.file instanceof File ? [slide.media.file] : []
  );
}

export async function buildMomentUpload(
  visibility: MomentVisibility,
  slides: readonly MomentUploadSlide[]
): Promise<CreateMomentsInput> {
  const type = momentUploadType(slides);
  const items = momentCreateItems(slides);
  if (type === MOMENT_TYPE.image) {
    const files = slideFiles(slides);
    const [images, thumbs] = await Promise.all([
      compressImagesForUpload(files),
      Promise.all(files.map((file) => createJpegThumbnail(file, MOMENT_THUMB_MAX_EDGE))),
    ]);
    return { type, visibility, items, images, thumbs };
  }
  if (type === MOMENT_TYPE.video) {
    const media = slides[0]?.media;
    return {
      type,
      visibility,
      items,
      video: media?.file,
      thumb: await posterFile(media?.posterUrl),
    };
  }
  return { type, visibility, items };
}

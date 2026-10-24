import { REEL_THUMB_MAX_EDGE, REEL_TYPE } from '@constants';
import { compressImagesForUpload, createJpegThumbnail, reelCreateItems } from '@lib';
import type { CreateReelsInput } from '@services';
import type { ReelDraftSlide, ReelVisibility } from '@app-types';

type ReelUploadSlide = Pick<ReelDraftSlide, 'media' | 'background' | 'overlays'>;

async function posterFile(posterUrl: string | undefined): Promise<File | undefined> {
  if (!posterUrl) return undefined;
  try {
    const blob = await (await fetch(posterUrl)).blob();
    return new File([blob], 'poster.jpg', { type: 'image/jpeg' });
  } catch {
    return undefined;
  }
}

function slideFiles(slides: readonly ReelUploadSlide[]): File[] {
  return slides.flatMap((slide) =>
    slide.media?.file instanceof File ? [slide.media.file] : []
  );
}

export async function buildReelUpload(
  visibility: ReelVisibility,
  slides: readonly ReelUploadSlide[]
): Promise<CreateReelsInput> {
  const type = slides[0]?.media?.type ?? REEL_TYPE.text;
  const items = reelCreateItems(slides);
  if (type === REEL_TYPE.image) {
    const files = slideFiles(slides);
    const [images, thumbs] = await Promise.all([
      compressImagesForUpload(files),
      Promise.all(files.map((file) => createJpegThumbnail(file, REEL_THUMB_MAX_EDGE))),
    ]);
    return { type, visibility, items, images, thumbs };
  }
  if (type === REEL_TYPE.video) {
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

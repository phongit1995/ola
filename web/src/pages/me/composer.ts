import { MeService } from '@services';
import { compressImagesForUpload } from '@lib';
import type { PostImage } from '@app-types';
import type { ComposedPost } from './components/MeComposerDialog';

interface ComposedPayload {
  content: string;
  checkIn?: {
    name: string;
    address: string;
    lat: number;
    lng: number;
    action?: string;
    actionIcon?: string;
  };
  sticker?: string;
  visibility: ComposedPost['visibility'];
}

export function composedToPayload(draft: ComposedPost): ComposedPayload {
  return {
    content: draft.content,
    checkIn: draft.checkIn
      ? {
          name: draft.checkIn.name,
          address: draft.checkIn.address,
          lat: draft.checkIn.lat,
          lng: draft.checkIn.lng,
          action: draft.checkIn.action,
          actionIcon: draft.checkIn.actionIcon,
        }
      : undefined,
    sticker: draft.sticker ?? undefined,
    visibility: draft.visibility,
  };
}

export function composedToUpdatePayload(
  draft: ComposedPost
): ComposedPayload & { sticker: string; clearCheckIn: boolean } {
  return {
    ...composedToPayload(draft),
    sticker: draft.sticker ?? '',
    clearCheckIn: draft.checkIn == null,
  };
}

export async function composedToImages(
  draft: ComposedPost,
  order: 'createdFirst' | 'existingFirst',
  existingImages: PostImage[] = []
): Promise<PostImage[]> {
  const prepared = await compressImagesForUpload(draft.files);
  const uploaded = prepared.length > 0 ? (await MeService.uploadImages(prepared)).images : [];
  const existing: PostImage[] = draft.imageUrls.map(
    (url) => existingImages.find((image) => image.url === url) ?? { url }
  );
  return order === 'createdFirst' ? [...uploaded, ...existing] : [...existing, ...uploaded];
}

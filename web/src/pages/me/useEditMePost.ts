import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { imageUploadErrorText, toast } from '@lib';
import { MeService } from '@services';
import type { Post, UploadedImage } from '@app-types';
import { composedToImages, composedToUpdatePayload } from './composer';
import { useMeFeedStore } from './meFeedStore';
import type { ComposedPost } from './components/MeComposerDialog';

type PostsUpdater = (updater: (current: Post[]) => Post[]) => void;

export function useEditMePost(
  posts: Post[],
  setPosts: PostsUpdater
): (id: string, draft: ComposedPost) => Promise<boolean> {
  const { t } = useTranslation();
  return useCallback(
    async (id, draft) => {
      let uploaded: UploadedImage[] = [];
      try {
        const existing = posts.find((item) => item.id === id)?.images ?? [];
        const prepared = await composedToImages(
          draft,
          'existingFirst',
          existing
        );
        uploaded = prepared.uploaded;
        const updated = await MeService.update(id, {
          ...composedToUpdatePayload(draft),
          images: prepared.images,
        });
        setPosts((current) =>
          current.map((item) => (item.id === id ? updated : item))
        );
        useMeFeedStore.getState().syncPost(updated);
        toast.success(t('me.editSuccess'));
        return true;
      } catch (error) {
        await MeService.cleanupRejectedImages(error, uploaded);
        toast.error(imageUploadErrorText(t, error, t('me.editError')));
        return false;
      }
    },
    [posts, setPosts, t]
  );
}

import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { MeService } from '@services';
import type { Post } from '@app-types';
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
      try {
        const existing = posts.find((item) => item.id === id)?.images ?? [];
        const images = await composedToImages(draft, 'existingFirst', existing);
        const updated = await MeService.update(id, { ...composedToUpdatePayload(draft), images });
        setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
        useMeFeedStore.getState().syncPost(updated);
        toast.success(t('me.editSuccess'));
        return true;
      } catch {
        toast.error(t('me.editError'));
        return false;
      }
    },
    [posts, setPosts, t]
  );
}

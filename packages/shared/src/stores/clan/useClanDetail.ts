import { useCallback, useEffect, useState } from 'react';
import i18n from 'i18next';
import { clanErrorText } from '../../lib/clanHelpers';
import { imageUploadErrorText } from '../../lib/imageUpload';
import { toast } from '../../lib/toast';
import { ClanService } from '../../services/clan.service';
import { MeService } from '../../services/me.service';
import type { Clan } from '../../types/api/clan.type';
import type { UploadFile } from '../../types/client/upload.type';
import { useClanFeedStore } from './clanFeedStore';
import { useClanStore } from './clanStore';

export type ClanStaffActionType = 'deletePost' | 'deleteByUser' | 'ban';

export interface ClanStaffAction {
  type: ClanStaffActionType;
  postId: string;
  authorId: string;
  authorName: string;
}

export type ClanImageField = 'avatar' | 'cover';

function fetchClan(handle: string | undefined, id: string | undefined): Promise<Clan> {
  return handle != null ? ClanService.byHandle(handle) : ClanService.get(id ?? '');
}

export function useClanDetail(handle: string | undefined, id: string | undefined) {
  const [clan, setClan] = useState<Clan | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [imageUploading, setImageUploading] = useState(false);

  const loadClan = useCallback(async (): Promise<Clan | null> => {
    try {
      const loaded = await fetchClan(handle, id);
      setClan(loaded);
      setLoadError(null);
      return loaded;
    } catch (error) {
      setLoadError(clanErrorText(error));
      return null;
    }
  }, [handle, id]);

  useEffect(() => {
    let active = true;
    fetchClan(handle, id)
      .then((loaded) => {
        if (!active) return;
        setClan(loaded);
        setLoadError(null);
        void useClanFeedStore.getState().load(loaded.id);
      })
      .catch((error) => {
        if (active) setLoadError(clanErrorText(error));
      });
    return () => {
      active = false;
      useClanFeedStore.getState().reset();
    };
  }, [handle, id]);

  const refreshAll = useCallback(async () => {
    const loaded = await fetchClan(handle, id);
    setClan(loaded);
    setLoadError(null);
    await useClanFeedStore.getState().refresh(loaded.id);
  }, [handle, id]);

  async function changeMembership(action: 'join' | 'leave') {
    if (clan == null) return;
    try {
      const updated =
        action === 'join' ? await ClanService.join(clan.id) : await ClanService.leave(clan.id);
      setClan(updated);
      useClanStore
        .getState()
        .refreshMine()
        .catch(() => undefined);
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function togglePinTop(postId: string) {
    if (clan == null) return;
    try {
      if (clan.meTopPostId === postId) {
        await ClanService.unpinPost(clan.id);
        toast.success(i18n.t('clan.unpinSuccess'));
      } else {
        await ClanService.pinPost(clan.id, postId);
        toast.success(i18n.t('clan.pinSuccess'));
      }
      await refreshAll();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function runStaffAction({ type, postId, authorId, authorName }: ClanStaffAction) {
    if (clan == null) return;
    try {
      if (type === 'deletePost') {
        await ClanService.deletePost(clan.id, postId);
        useClanFeedStore.getState().removePost(postId);
      } else if (type === 'deleteByUser') {
        await ClanService.deletePostsByUser(clan.id, authorId);
        useClanFeedStore.getState().removePostsByAuthor(authorId);
      } else {
        await ClanService.ban(clan.id, authorName);
        toast.success(i18n.t('clan.banSuccess', { username: authorName }));
        await refreshAll();
        return;
      }
      toast.success(i18n.t('clan.deleteSuccess'));
      void loadClan();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function deleteOwnPost(postId: string) {
    try {
      await MeService.remove(postId);
      useClanFeedStore.getState().removePost(postId);
      toast.success(i18n.t('me.deleteSuccess'));
    } catch {
      toast.error(i18n.t('me.deleteError'));
    }
  }

  async function uploadImage(
    field: ClanImageField,
    prepareFile: () => Promise<UploadFile>
  ): Promise<boolean> {
    if (clan == null || imageUploading) return false;
    setImageUploading(true);
    try {
      const file = await prepareFile();
      const result =
        field === 'avatar'
          ? await ClanService.uploadAvatar(clan.id, file)
          : await ClanService.uploadCover(clan.id, file);
      setClan({ ...clan, [field]: result.url });
      toast.success(i18n.t('clan.uploadSuccess'));
      return true;
    } catch (error) {
      toast.error(imageUploadErrorText(i18n.t, error, clanErrorText(error)));
      return false;
    } finally {
      setImageUploading(false);
    }
  }

  return {
    clan,
    setClan,
    loadError,
    imageUploading,
    loadClan,
    refreshAll,
    handleJoin: () => changeMembership('join'),
    handleLeave: () => changeMembership('leave'),
    togglePinTop,
    runStaffAction,
    deleteOwnPost,
    uploadImage,
  };
}

import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ClanService, MeService } from '@ola/shared/services';
import type { Clan, Post } from '@ola/shared/types';
import { useClanFeedStore } from '@ola/shared/stores/clanFeedStore';
import { useClanStore } from '@ola/shared/stores/clanStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { pickCroppedImage } from '@lib/imagePicker';
import { clanErrorText } from '@lib/clanHelpers';
import { CLAN_AVATAR_OUTPUT, CLAN_COVER_OUTPUT } from './constants';
import type { StaffConfirm } from './types';

export function useClanScreen(handle: string | undefined, id: string | undefined) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);

  const [clan, setClan] = useState<Clan | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [imageUploading, setImageUploading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [leaveConfirm, setLeaveConfirm] = useState(false);
  const [staffConfirm, setStaffConfirm] = useState<StaffConfirm | null>(null);

  const loadClan = useCallback(async (): Promise<Clan | null> => {
    try {
      const loaded =
        handle != null ? await ClanService.byHandle(handle) : await ClanService.get(id ?? '');
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
    const request = handle != null ? ClanService.byHandle(handle) : ClanService.get(id ?? '');
    request
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
    const loaded =
      handle != null ? await ClanService.byHandle(handle) : await ClanService.get(id ?? '');
    setClan(loaded);
    setLoadError(null);
    await useClanFeedStore.getState().refresh(loaded.id);
  }, [handle, id]);

  const onRefresh = useCallback(() => {
    setRefreshing(true);
    refreshAll()
      .catch((error) => pushToast('error', clanErrorText(error)))
      .finally(() => setRefreshing(false));
  }, [refreshAll, pushToast]);

  async function handleJoin() {
    if (clan == null) return;
    try {
      const updated = await ClanService.join(clan.id);
      setClan(updated);
      useClanStore.getState().refreshMine().catch(() => undefined);
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  async function handleLeave() {
    if (clan == null) return;
    setLeaveConfirm(false);
    try {
      const updated = await ClanService.leave(clan.id);
      setClan(updated);
      useClanStore.getState().refreshMine().catch(() => undefined);
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  async function togglePinTop(post: Post) {
    if (clan == null) return;
    try {
      if (clan.meTopPostId === post.id) {
        await ClanService.unpinPost(clan.id);
        pushToast('success', t('clan.unpinSuccess'));
      } else {
        await ClanService.pinPost(clan.id, post.id);
        pushToast('success', t('clan.pinSuccess'));
      }
      await refreshAll();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  async function runStaffConfirm() {
    if (clan == null || staffConfirm == null) return;
    const { type, post } = staffConfirm;
    const authorId = post.author?.id ?? '';
    const authorName = post.author?.username ?? '';
    setStaffConfirm(null);
    try {
      if (type === 'deletePost') {
        await ClanService.deletePost(clan.id, post.id);
        useClanFeedStore.getState().removePost(post.id);
      } else if (type === 'deleteByUser') {
        await ClanService.deletePostsByUser(clan.id, authorId);
        useClanFeedStore.getState().removePostsByAuthor(authorId);
      } else {
        await ClanService.ban(clan.id, authorName);
        pushToast('success', t('clan.banSuccess', { username: authorName }));
        await refreshAll();
        return;
      }
      pushToast('success', t('clan.deleteSuccess'));
      void loadClan();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  async function deleteOwnPost(postId: string) {
    try {
      await MeService.remove(postId);
      useClanFeedStore.getState().removePost(postId);
      pushToast('success', t('me.deleteSuccess'));
    } catch {
      pushToast('error', t('me.deleteError'));
    }
  }

  async function changeImage(field: 'avatar' | 'cover') {
    if (clan == null || imageUploading) return;
    try {
      const output = field === 'avatar' ? CLAN_AVATAR_OUTPUT : CLAN_COVER_OUTPUT;
      const picked = await pickCroppedImage(output.width, output.height);
      if (picked == null) return;
      setImageUploading(true);
      const result =
        field === 'avatar'
          ? await ClanService.uploadAvatar(clan.id, picked.file)
          : await ClanService.uploadCover(clan.id, picked.file);
      setClan({ ...clan, [field]: result.url });
      pushToast('success', t('clan.uploadSuccess'));
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setImageUploading(false);
    }
  }

  const staffConfirmText =
    staffConfirm == null
      ? ''
      : staffConfirm.type === 'deletePost'
        ? t('clan.deletePostConfirm')
        : staffConfirm.type === 'deleteByUser'
          ? t('clan.deletePostsByUserConfirm', { username: staffConfirm.post.author?.username ?? '' })
          : t('clan.banConfirm', { username: staffConfirm.post.author?.username ?? '' });

  return {
    clan,
    loadError,
    imageUploading,
    refreshing,
    leaveConfirm,
    setLeaveConfirm,
    staffConfirm,
    setStaffConfirm,
    staffConfirmText,
    onRefresh,
    handleJoin,
    handleLeave,
    togglePinTop,
    runStaffConfirm,
    deleteOwnPost,
    changeImage,
  };
}

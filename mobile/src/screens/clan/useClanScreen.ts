import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { clanErrorText, imageUploadErrorText } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { useClanDetail, type ClanImageField } from '@ola/shared/stores/clan/useClanDetail';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { pickCroppedImage } from '@lib/imagePicker';
import { CLAN_AVATAR_OUTPUT, CLAN_COVER_OUTPUT } from './constants';
import type { StaffConfirm } from './types';

export function useClanScreen(handle: string | undefined, id: string | undefined) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);
  const detail = useClanDetail(handle, id);
  const { clan, imageUploading, refreshAll } = detail;

  const [refreshing, setRefreshing] = useState(false);
  const [leaveConfirm, setLeaveConfirm] = useState(false);
  const [staffConfirm, setStaffConfirm] = useState<StaffConfirm | null>(null);

  const onRefresh = useCallback(() => {
    setRefreshing(true);
    refreshAll()
      .catch((error) => pushToast('error', clanErrorText(error)))
      .finally(() => setRefreshing(false));
  }, [refreshAll, pushToast]);

  async function handleLeave() {
    setLeaveConfirm(false);
    await detail.handleLeave();
  }

  async function togglePinTop(post: Post) {
    await detail.togglePinTop(post.id);
  }

  async function runStaffConfirm() {
    if (clan == null || staffConfirm == null) return;
    const { type, post } = staffConfirm;
    setStaffConfirm(null);
    await detail.runStaffAction({
      type,
      postId: post.id,
      authorId: post.author?.id ?? '',
      authorName: post.author?.username ?? '',
    });
  }

  async function changeImage(field: ClanImageField) {
    if (clan == null || imageUploading) return;
    const output = field === 'avatar' ? CLAN_AVATAR_OUTPUT : CLAN_COVER_OUTPUT;
    let picked: Awaited<ReturnType<typeof pickCroppedImage>>;
    try {
      picked = await pickCroppedImage(output.width, output.height);
    } catch (error) {
      pushToast('error', imageUploadErrorText(t, error, clanErrorText(error)));
      return;
    }
    if (picked == null) return;
    const file = picked.file;
    await detail.uploadImage(field, async () => file);
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
    loadError: detail.loadError,
    imageUploading,
    refreshing,
    leaveConfirm,
    setLeaveConfirm,
    staffConfirm,
    setStaffConfirm,
    staffConfirmText,
    onRefresh,
    handleJoin: detail.handleJoin,
    handleLeave,
    togglePinTop,
    runStaffConfirm,
    deleteOwnPost: detail.deleteOwnPost,
    changeImage,
  };
}

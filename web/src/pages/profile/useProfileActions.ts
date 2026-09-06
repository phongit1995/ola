import { useCallback, useMemo, useState } from 'react';
import type { Dispatch, SetStateAction } from 'react';
import { useTranslation } from 'react-i18next';
import { RELATIONSHIP_STATUS } from '@constants';
import { RelationshipService, UserService } from '@services';
import { compressImageForUpload, imageUploadErrorText, toast } from '@lib';
import type { RelationshipInfo } from '@app-types';
import { useChatStore } from '@/store/chat/chatStore';
import { useAuthStore } from '@/store/authStore';
import type { ProfileActions, UserProfile } from './types';

interface UseProfileActionsArgs {
  userId: string;
  relationship: RelationshipInfo;
  setRelationship: Dispatch<SetStateAction<RelationshipInfo>>;
  setProfile: Dispatch<SetStateAction<UserProfile | null>>;
  reload: () => Promise<void>;
}

export function useProfileActions({
  userId,
  relationship,
  setRelationship,
  setProfile,
  reload,
}: UseProfileActionsArgs): { actions: ProfileActions; busy: boolean } {
  const { t } = useTranslation();
  const [busy, setBusy] = useState(false);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const changeCover = useCallback(
    async (file: File) => {
      try {
        const { url } = await UserService.uploadAvatar(
          await compressImageForUpload(file)
        );
        await UserService.updateMe({ coverPhoto: url });
        setProfile((p) => (p ? { ...p, coverPhoto: url } : p));
        await refreshUser();
        toast.success(t('profileEdit.coverUpdated'));
      } catch (error) {
        toast.error(imageUploadErrorText(t, error, t('profileEdit.coverError')));
      }
    },
    [setProfile, refreshUser, t]
  );

  const changeAvatar = useCallback(
    async (file: File) => {
      try {
        const { url } = await UserService.uploadAvatar(
          await compressImageForUpload(file)
        );
        await UserService.updateMe({ avatar: url });
        setProfile((p) => (p ? { ...p, avatar: url } : p));
        await refreshUser();
        toast.success(t('profileEdit.avatarUpdated'));
      } catch (error) {
        toast.error(imageUploadErrorText(t, error, t('profileEdit.avatarError')));
      }
    },
    [setProfile, refreshUser, t]
  );

  const kiss = useCallback(() => {
    if (userId === '') return;
    setProfile((p) => (p ? { ...p, kisses: p.kisses + 1 } : p));
    UserService.kiss(userId)
      .then((res) => setProfile((p) => (p ? { ...p, kisses: res.kisses } : p)))
      .catch(() => {
        setProfile((p) =>
          p ? { ...p, kisses: Math.max(0, p.kisses - 1) } : p
        );
        toast.error(t('profile.actionError'));
      });
  }, [userId, setProfile, t]);

  const toggleFollow = useCallback(() => {
    if (userId === '') return;
    const wasFollowing = relationship.isFollowing;
    setRelationship((r) => ({ ...r, isFollowing: !wasFollowing }));
    setProfile((p) =>
      p ? { ...p, fans: Math.max(0, p.fans + (wasFollowing ? -1 : 1)) } : p
    );
    const call = wasFollowing
      ? UserService.unfollow(userId)
      : UserService.follow(userId);
    call
      .then((res) => {
        setRelationship((r) => ({ ...r, isFollowing: res.following }));
        setProfile((p) => (p ? { ...p, fans: res.followerCount } : p));
      })
      .catch(() => {
        setRelationship((r) => ({ ...r, isFollowing: wasFollowing }));
        setProfile((p) =>
          p ? { ...p, fans: Math.max(0, p.fans + (wasFollowing ? 1 : -1)) } : p
        );
        toast.error(t('profile.actionError'));
      });
  }, [userId, relationship.isFollowing, setRelationship, setProfile, t]);

  const runAndReload = useCallback(
    (op: Promise<unknown>) => {
      setBusy(true);
      op.then(() => reload())
        .catch(() => toast.error(t('profile.actionError')))
        .finally(() => setBusy(false));
    },
    [reload, t]
  );

  const friendAction = useCallback(() => {
    if (userId === '' || busy) return;
    const { status, requestId } = relationship;
    if (status === RELATIONSHIP_STATUS.none)
      runAndReload(RelationshipService.sendRequest(userId));
    else if (status === RELATIONSHIP_STATUS.pendingOutgoing && requestId)
      runAndReload(RelationshipService.cancel(requestId));
    else if (status === RELATIONSHIP_STATUS.pendingIncoming && requestId)
      runAndReload(RelationshipService.respond(requestId, 'accept'));
    else if (status === RELATIONSHIP_STATUS.friend && requestId)
      runAndReload(RelationshipService.unfriend(requestId));
  }, [userId, busy, relationship, runAndReload]);

  const blockAction = useCallback(() => {
    if (userId === '' || busy) return;
    const { status, requestId } = relationship;
    if (status === RELATIONSHIP_STATUS.blockedByMe && requestId)
      runAndReload(RelationshipService.unblock(requestId));
    else runAndReload(RelationshipService.block(userId));
  }, [userId, busy, relationship, runAndReload]);

  const message = useCallback(() => {
    if (userId === '') return;
    void useChatStore.getState().startDirect(userId);
  }, [userId]);

  const actions = useMemo<ProfileActions>(
    () => ({
      kiss,
      toggleFollow,
      friendAction,
      blockAction,
      message,
      changeCover,
      changeAvatar,
    }),
    [
      kiss,
      toggleFollow,
      friendAction,
      blockAction,
      message,
      changeCover,
      changeAvatar,
    ]
  );

  return { actions, busy };
}

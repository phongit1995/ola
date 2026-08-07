import {
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
  type ChangeEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
} from '@components';
import type { ListOption } from '@components';
import { CLAN_ROLE } from '@constants';
import {
  colorForName,
  compressImagesForUpload,
  createTimeFormatter,
  filterVisiblePosts,
  formatDateSlashDMY,
  isPostVisible,
  toast,
} from '@lib';
import { ClanService, MeService } from '@services';
import type {
  Clan,
  PostReaction,
  PostVisibility,
  UploadedImage,
} from '@app-types';
import { useClanFeedStore } from '@ola/shared/stores/clan/clanFeedStore';
import { useClanStore } from '@ola/shared/stores/clan/clanStore';
import { useAuthStore } from '@/store/authStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import { ImageCropEditor } from '@components';
import {
  MeComposerDialog,
  type ComposedPost,
} from '../me/components/MeComposerDialog';
import { MeFeedList } from '../me/components/MeFeedList';
import { MePostCard } from '../me/components/MePostCard';
import {
  MePostInteractions,
  type MePostSource,
} from '../me/MePostInteractions';
import {
  composedToImages,
  composedToPayload,
  composedToUpdatePayload,
} from '../me/composer';
import { toMePost } from '../me/mappers';
import type { MePost } from '../me/types';
import {
  CLAN_ROLE_ICONS,
  canPostPublicInClan,
  clanErrorText,
  clanFeedErrorText,
  clanPolicyLabel,
  isClanStaff,
} from './clanHelpers';
import cameraIcon from '@/assets/icons/me/ic_action_edit.png';
import manageIcon from '@/assets/icons/clan/ic_manage_clan.png';
import followIcon from '@/assets/icons/clan/ic_follow_black_disable.png';
import followingIcon from '@/assets/icons/clan/ic_state_following.png';
import postMeIcon from '@/assets/icons/clan/ic_post_me_gray.png';
import policyIcon from '@/assets/icons/clan/ic_profile_note.png';

interface ClanPageProps {
  handle?: string;
  id?: string;
  onClose: () => void;
  onOpenManage: (clanId: string) => void;
  onOpenMembers: (clanId: string) => void;
}

type StaffConfirm =
  | { type: 'deletePost'; post: MePost }
  | { type: 'deleteByUser'; post: MePost }
  | { type: 'ban'; post: MePost };

interface InfoRowProps {
  icon: string;
  text: string;
  onClick?: () => void;
}

function InfoRow({ icon, text, onClick }: InfoRowProps) {
  const body = (
    <>
      <img src={icon} alt="" className="h-3.75 w-4.25 object-contain" />
      <span className="truncate">{text}</span>
    </>
  );
  if (onClick == null) {
    return (
      <div className="mt-2 ml-4 flex items-center gap-1.5 text-xs text-black/54">
        {body}
      </div>
    );
  }
  return (
    <button
      type="button"
      onClick={onClick}
      className="mt-2 ml-4 flex items-center gap-1.5 text-xs text-black/54 hover:underline"
    >
      {body}
    </button>
  );
}

export function ClanPage({
  handle,
  id,
  onClose,
  onOpenManage,
  onOpenMembers,
}: ClanPageProps) {
  const { t, i18n } = useTranslation();
  const meId = useAuthStore((s) => s.user?.id ?? null);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const blockedAuthorIds = useMeLocalStore((s) => s.blockedAuthorIds);
  const hidePostLocal = useMeLocalStore((s) => s.hidePost);
  const blockAuthorLocal = useMeLocalStore((s) => s.blockAuthor);

  const [clan, setClan] = useState<Clan | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);
  const [leaveConfirm, setLeaveConfirm] = useState(false);
  const [staffConfirm, setStaffConfirm] = useState<StaffConfirm | null>(null);
  const [imageEdit, setImageEdit] = useState<{
    field: 'avatar' | 'cover';
    src: string;
  } | null>(null);
  const [imageUploading, setImageUploading] = useState(false);
  const avatarInputRef = useRef<HTMLInputElement>(null);
  const coverInputRef = useRef<HTMLInputElement>(null);

  const feedPinned = useClanFeedStore((s) => s.pinned);
  const feedPosts = useClanFeedStore((s) => s.posts);
  const feedLoading = useClanFeedStore((s) => s.loading);
  const feedLoadingMore = useClanFeedStore((s) => s.loadingMore);
  const feedError = useClanFeedStore((s) => s.error);
  const feedNextCursor = useClanFeedStore((s) => s.nextCursor);

  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  const loadClan = useCallback(async (): Promise<Clan | null> => {
    try {
      const loaded =
        handle != null
          ? await ClanService.byHandle(handle)
          : await ClanService.get(id ?? '');
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
    const request =
      handle != null ? ClanService.byHandle(handle) : ClanService.get(id ?? '');
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
      handle != null
        ? await ClanService.byHandle(handle)
        : await ClanService.get(id ?? '');
    setClan(loaded);
    setLoadError(null);
    await useClanFeedStore.getState().refresh(loaded.id);
  }, [handle, id]);

  const pinnedPost = useMemo(
    () =>
      feedPinned != null &&
      isPostVisible(feedPinned, hiddenPostIds, blockedAuthorIds)
        ? toMePost(feedPinned, formatTime)
        : null,
    [feedPinned, formatTime, hiddenPostIds, blockedAuthorIds]
  );
  const listPosts = useMemo(
    () =>
      filterVisiblePosts(feedPosts, hiddenPostIds, blockedAuthorIds).map(
        (post) => toMePost(post, formatTime)
      ),
    [feedPosts, formatTime, hiddenPostIds, blockedAuthorIds]
  );
  const allPosts = useMemo(
    () => (pinnedPost != null ? [pinnedPost, ...listPosts] : listPosts),
    [pinnedPost, listPosts]
  );

  const toggleReaction = useCallback((postId: string, type: PostReaction) => {
    void useClanFeedStore.getState().toggleReaction(postId, type);
  }, []);

  const adjustCommentCount = useCallback((postId: string, delta: number) => {
    useClanFeedStore.getState().adjustCommentCount(postId, delta);
  }, []);

  const editPost = useCallback(
    async (postId: string, draft: ComposedPost): Promise<boolean> => {
      let uploaded: UploadedImage[] = [];
      try {
        const store = useClanFeedStore.getState();
        const raw =
          store.posts.find((item) => item.id === postId) ?? store.pinned;
        const prepared = await composedToImages(
          draft,
          'existingFirst',
          raw?.images ?? []
        );
        uploaded = prepared.uploaded;
        const updated = await MeService.update(postId, {
          ...composedToUpdatePayload(draft),
          images: prepared.images,
        });
        useClanFeedStore.getState().syncPost(updated);
        toast.success(t('me.editSuccess'));
        return true;
      } catch (error) {
        await MeService.cleanupRejectedImages(error, uploaded);
        toast.error(clanErrorText(error));
        return false;
      }
    },
    [t]
  );

  const deleteOwnPost = useCallback(
    async (postId: string) => {
      try {
        await MeService.remove(postId);
        useClanFeedStore.getState().removePost(postId);
        toast.success(t('me.deleteSuccess'));
      } catch {
        toast.error(t('me.deleteError'));
      }
    },
    [t]
  );

  const addPost = useCallback(
    async (draft: ComposedPost): Promise<boolean> => {
      if (clan == null) return false;
      const prepared = await compressImagesForUpload(draft.files);
      const created = await useClanFeedStore
        .getState()
        .createPost(
          clan.id,
          composedToPayload(draft),
          prepared,
          draft.imageUrls
        );
      return created != null;
    },
    [clan]
  );

  async function handleJoin() {
    if (clan == null) return;
    try {
      const updated = await ClanService.join(clan.id);
      setClan(updated);
      useClanStore
        .getState()
        .refreshMine()
        .catch(() => undefined);
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function handleLeave() {
    if (clan == null) return;
    setLeaveConfirm(false);
    try {
      const updated = await ClanService.leave(clan.id);
      setClan(updated);
      useClanStore
        .getState()
        .refreshMine()
        .catch(() => undefined);
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function togglePinTop(post: MePost) {
    if (clan == null) return;
    try {
      if (clan.meTopPostId === post.id) {
        await ClanService.unpinPost(clan.id);
        toast.success(t('clan.unpinSuccess'));
      } else {
        await ClanService.pinPost(clan.id, post.id);
        toast.success(t('clan.pinSuccess'));
      }
      await refreshAll();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function runStaffConfirm() {
    if (clan == null || staffConfirm == null) return;
    const { type, post } = staffConfirm;
    setStaffConfirm(null);
    try {
      if (type === 'deletePost') {
        await ClanService.deletePost(clan.id, post.id);
        useClanFeedStore.getState().removePost(post.id);
      } else if (type === 'deleteByUser') {
        await ClanService.deletePostsByUser(clan.id, post.authorId);
        useClanFeedStore.getState().removePostsByAuthor(post.authorId);
      } else {
        await ClanService.ban(clan.id, post.author);
        toast.success(t('clan.banSuccess', { username: post.author }));
        await refreshAll();
        return;
      }
      toast.success(t('clan.deleteSuccess'));
      void loadClan();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  function pickImage(
    event: ChangeEvent<HTMLInputElement>,
    field: 'avatar' | 'cover'
  ) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file == null) return;
    setImageEdit({ field, src: URL.createObjectURL(file) });
  }

  function closeImageEdit() {
    setImageEdit((prev) => {
      if (prev != null) URL.revokeObjectURL(prev.src);
      return null;
    });
  }

  async function applyImage(file: File) {
    if (clan == null || imageEdit == null || imageUploading) return;
    setImageUploading(true);
    try {
      const prepared = await compressImagesForUpload([file]);
      const upload = prepared[0] ?? file;
      const result =
        imageEdit.field === 'avatar'
          ? await ClanService.uploadAvatar(clan.id, upload)
          : await ClanService.uploadCover(clan.id, upload);
      setClan({ ...clan, [imageEdit.field]: result.url });
      toast.success(t('clan.uploadSuccess'));
      closeImageEdit();
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setImageUploading(false);
    }
  }

  function extraMenuItems(post: MePost): ListOption[] {
    if (clan == null || !isClanStaff(clan)) return [];
    const items: ListOption[] = [
      {
        key: 'clanPin',
        label:
          clan.meTopPostId === post.id
            ? t('clan.unpinPost')
            : t('clan.pinPost'),
        onSelect: () => void togglePinTop(post),
      },
    ];
    if (post.authorId !== meId) {
      items.push({
        key: 'clanDelete',
        label: t('clan.deletePost'),
        danger: true,
        onSelect: () => setStaffConfirm({ type: 'deletePost', post }),
      });
      items.push({
        key: 'clanDeleteByUser',
        label: t('clan.deletePostsByUser'),
        danger: true,
        onSelect: () => setStaffConfirm({ type: 'deleteByUser', post }),
      });
      items.push({
        key: 'clanBan',
        label: t('clan.banUser'),
        danger: true,
        onSelect: () => setStaffConfirm({ type: 'ban', post }),
      });
    }
    return items;
  }

  if (clan == null) {
    return (
      <FullScreenOverlay>
        <ScreenHeader
          title={handle != null ? `#${handle}` : t('clan.title')}
          onBack={onClose}
        />
        <div className="flex flex-1 items-center justify-center px-8 text-center">
          {loadError != null ? (
            <p className="text-sm text-black/54">{loadError}</p>
          ) : (
            <Spinner size={28} />
          )}
        </div>
      </FullScreenOverlay>
    );
  }

  const isOwner = clan.myRole === CLAN_ROLE.owner;
  const privacyOptions: PostVisibility[] = canPostPublicInClan(clan)
    ? ['public', 'private']
    : ['private'];

  const source: MePostSource = {
    posts: allPosts,
    meId,
    toggleReaction,
    adjustCommentCount,
    hidePost: hidePostLocal,
    blockAuthor: blockAuthorLocal,
    editPost,
    deletePost: (postId) => void deleteOwnPost(postId),
  };

  const staffConfirmText =
    staffConfirm == null
      ? ''
      : staffConfirm.type === 'deletePost'
      ? t('clan.deletePostConfirm')
      : staffConfirm.type === 'deleteByUser'
      ? t('clan.deletePostsByUserConfirm', {
          username: staffConfirm.post.author,
        })
      : t('clan.banConfirm', { username: staffConfirm.post.author });

  return (
    <FullScreenOverlay>
      <ScreenHeader title={`#${clan.handle}`} onBack={onClose} />
      <MePostInteractions
        source={source}
        extraMenuItems={extraMenuItems}
        composerPrivacyOptions={privacyOptions}
      >
        {(handlers) => (
          <div className="flex-1 overflow-y-auto">
            <div className="mb-2 bg-white pb-4 shadow-[0_1px_3px_rgba(0,0,0,0.16)]">
              <div className="relative">
                <div className="aspect-2/1 w-full overflow-hidden bg-ola-primary-darker">
                  {clan.cover != null && clan.cover !== '' && (
                    <img
                      src={clan.cover}
                      alt=""
                      className="h-full w-full object-cover"
                    />
                  )}
                </div>
                {isOwner && (
                  <button
                    type="button"
                    aria-label={t('clan.changeCover')}
                    onClick={() => coverInputRef.current?.click()}
                    className="absolute right-1 bottom-1 rounded bg-black/38 p-1.5"
                  >
                    <img
                      src={cameraIcon}
                      alt=""
                      className="h-4 w-4 object-contain"
                    />
                  </button>
                )}
                <div className="absolute bottom-2 left-2 bg-white p-1 pb-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.24)]">
                  <div className="relative h-24 w-24 overflow-hidden bg-ola-surface-cool">
                    {clan.avatar != null && clan.avatar !== '' && (
                      <img
                        src={clan.avatar}
                        alt=""
                        className="h-full w-full object-cover"
                      />
                    )}
                    {isOwner && (
                      <button
                        type="button"
                        aria-label={t('clan.changeAvatar')}
                        onClick={() => avatarInputRef.current?.click()}
                        className="absolute right-0.5 bottom-0.5 rounded bg-black/38 p-1"
                      >
                        <img
                          src={cameraIcon}
                          alt=""
                          className="h-3.5 w-3.5 object-contain"
                        />
                      </button>
                    )}
                  </div>
                </div>
              </div>

              <div className="py-2 text-center text-2xl text-black/54">
                #{clan.handle}
              </div>
              <div className="mx-4 h-px bg-black/12" />

              <div className="flex px-2 py-2">
                {!isOwner &&
                  (clan.isMember ? (
                    <button
                      type="button"
                      onClick={() => setLeaveConfirm(true)}
                      className="flex flex-1 flex-col items-center gap-1 py-1 text-xs text-ola-primary"
                    >
                      <img
                        src={followingIcon}
                        alt=""
                        className="h-5 object-contain"
                      />
                      {t('clan.following')}
                    </button>
                  ) : (
                    <button
                      type="button"
                      onClick={() => void handleJoin()}
                      disabled={clan.policy === 3 || clan.isBanned}
                      className="flex flex-1 flex-col items-center gap-1 py-1 text-xs text-black/26 disabled:opacity-50"
                    >
                      <img
                        src={followIcon}
                        alt=""
                        className="h-5 object-contain"
                      />
                      {t('clan.follow')}
                    </button>
                  ))}
                {isOwner && (
                  <button
                    type="button"
                    onClick={() => onOpenManage(clan.id)}
                    className="flex flex-1 flex-col items-center gap-1 py-1 text-xs text-black/26"
                  >
                    <img
                      src={manageIcon}
                      alt=""
                      className="h-5 object-contain"
                    />
                    {t('clan.manage')}
                  </button>
                )}
                <button
                  type="button"
                  onClick={() => setComposerOpen(true)}
                  className="flex flex-1 flex-col items-center gap-1 py-1 text-xs text-black/26"
                >
                  <img src={postMeIcon} alt="" className="h-5 object-contain" />
                  {t('clan.writeMe')}
                </button>
              </div>
              <div className="mx-4 h-px bg-black/12" />

              <button
                type="button"
                onClick={() => onOpenMembers(clan.id)}
                className="my-4 block w-full text-center"
              >
                <span className="text-xl font-bold text-black">
                  {clan.memberCount.toLocaleString()}
                </span>
                <span className="ml-1 text-xs text-black/54">
                  {t('clan.members')}
                </span>
              </button>

              <div className="ml-4 text-xs text-black/54">
                {t('clan.createdAt', { date: formatDateSlashDMY(clan.createdAt) })}
              </div>
              {clan.owner != null && (
                <InfoRow
                  icon={CLAN_ROLE_ICONS.owner}
                  text={`@${clan.owner.username}`}
                  onClick={() =>
                    handlers.onOpenProfile(
                      clan.owner!.username,
                      colorForName(clan.owner!.username)
                    )
                  }
                />
              )}
              {clan.deputy != null && (
                <InfoRow
                  icon={CLAN_ROLE_ICONS.deputy}
                  text={`@${clan.deputy.username}`}
                  onClick={() =>
                    handlers.onOpenProfile(
                      clan.deputy!.username,
                      colorForName(clan.deputy!.username)
                    )
                  }
                />
              )}
              {clan.ambassador != null && (
                <InfoRow
                  icon={CLAN_ROLE_ICONS.ambassador}
                  text={`@${clan.ambassador.username}`}
                  onClick={() =>
                    handlers.onOpenProfile(
                      clan.ambassador!.username,
                      colorForName(clan.ambassador!.username)
                    )
                  }
                />
              )}
              <InfoRow
                icon={policyIcon}
                text={
                  clanPolicyLabel(clan.policy) +
                  (clan.memberPublicPost
                    ? ` · ${t('clan.memberPublicPost')}`
                    : '')
                }
              />
            </div>

            <h2 className="px-4 pt-1 pb-2 text-base text-black/87">
              {t('clan.postedTitle')}
            </h2>

            {feedLoading ? (
              <div className="flex justify-center py-10">
                <Spinner size={28} />
              </div>
            ) : feedError != null ? (
              <p className="px-6 py-10 text-center text-sm text-black/45">
                {clanFeedErrorText(feedError)}
              </p>
            ) : (
              <>
                {pinnedPost != null && (
                  <div className="mb-2">
                    <div className="bg-ola-primary-light px-4 py-1 text-xs font-bold text-ola-primary-dark">
                      {t('clan.meTop')}
                    </div>
                    <MePostCard
                      post={pinnedPost}
                      onToggleLike={handlers.onToggleLike}
                      onToggleDislike={handlers.onToggleDislike}
                      onOpenProfile={handlers.onOpenProfile}
                      onOpenComments={handlers.onOpenComments}
                      onQuickComment={handlers.onQuickComment}
                      onOpenMenu={handlers.onOpenMenu}
                      onOpenLikers={handlers.onOpenLikers}
                    />
                  </div>
                )}
                {listPosts.length === 0 && pinnedPost == null ? (
                  <p className="px-6 py-10 text-center text-sm text-black/45">
                    {t('clan.emptyFeed')}
                  </p>
                ) : (
                  <MeFeedList
                    posts={listPosts}
                    loading={false}
                    loadingMore={feedLoadingMore}
                    hasMore={feedNextCursor != null}
                    emptyText={t('clan.emptyFeed')}
                    onLoadMore={() =>
                      void useClanFeedStore.getState().loadMore()
                    }
                    onToggleLike={handlers.onToggleLike}
                    onToggleDislike={handlers.onToggleDislike}
                    onOpenProfile={handlers.onOpenProfile}
                    onOpenComments={handlers.onOpenComments}
                    onQuickComment={handlers.onQuickComment}
                    onOpenMenu={handlers.onOpenMenu}
                    onOpenLikers={handlers.onOpenLikers}
                  />
                )}
              </>
            )}
          </div>
        )}
      </MePostInteractions>

      <MeComposerDialog
        open={composerOpen}
        title={t('clan.writeMe')}
        privacyOptions={privacyOptions}
        onClose={() => setComposerOpen(false)}
        onPost={addPost}
      />

      <ConfirmDialog
        open={leaveConfirm}
        title={t('clan.leave')}
        message={t('clan.leaveConfirm', { name: clan.handle })}
        confirmLabel={t('clan.leave')}
        cancelLabel={t('dialog.cancel')}
        danger
        onCancel={() => setLeaveConfirm(false)}
        onConfirm={() => void handleLeave()}
      />

      <ConfirmDialog
        open={staffConfirm != null}
        title={
          staffConfirm?.type === 'ban'
            ? t('clan.banUser')
            : t('clan.deletePost')
        }
        message={staffConfirmText}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        danger
        onCancel={() => setStaffConfirm(null)}
        onConfirm={() => void runStaffConfirm()}
      />

      <input
        ref={avatarInputRef}
        type="file"
        accept="image/*"
        hidden
        onChange={(e) => pickImage(e, 'avatar')}
      />
      <input
        ref={coverInputRef}
        type="file"
        accept="image/*"
        hidden
        onChange={(e) => pickImage(e, 'cover')}
      />

      {imageEdit != null && (
        <ImageCropEditor
          src={imageEdit.src}
          aspect={imageEdit.field === 'avatar' ? 1 : 2}
          busy={imageUploading}
          onCancel={closeImageEdit}
          onApply={(file) => void applyImage(file)}
        />
      )}
    </FullScreenOverlay>
  );
}

import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  RefreshControl,
  Text,
  View,
  useWindowDimensions,
  type ImageSourcePropType,
} from 'react-native';
import { FlashList } from '@shopify/flash-list';
import {
  filterVisiblePosts,
  formatDateDMY,
  isPostVisible,
  postTimeLabel,
  createTimeFormatter,
  toApiError,
} from '@ola/shared/lib';
import { ClanService, MeService } from '@ola/shared/services';
import type { Clan, Post, PostReaction, PostVisibility } from '@ola/shared/types';
import { EDIT_WINDOW_MS } from '@ola/shared/constants';
import { useClanFeedStore } from '@ola/shared/stores/clanFeedStore';
import { useClanStore } from '@ola/shared/stores/clanStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useMeLocalStore } from '@store/meLocalStore';
import { pickCroppedImage } from '@lib/imagePicker';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { MediaViewerModal } from '@components/ui/MediaViewer';
import { MePostCard } from '@screens/me/components/MePostCard';
import { MeComposerModal } from '@screens/me/components/MeComposerModal';
import { MeCommentSheet } from '@screens/me/components/MeCommentSheet';
import { MeQuickCommentBar } from '@screens/me/components/MeQuickCommentBar';
import { MeLikersDialog } from '@screens/me/components/MeLikersDialog';
import { UserProfileScreen } from '@screens/profile/UserProfileScreen';
import {
  CLAN_ROLE_ICONS,
  canPostPublicInClan,
  clanErrorText,
  clanFeedErrorText,
  clanPolicyLabel,
  isClanStaff,
} from '@lib/clanHelpers';

const manageIcon = require('@assets/icons/clan/ic_manage_clan.png');
const followIcon = require('@assets/icons/clan/ic_follow_black_disable.png');
const followingIcon = require('@assets/icons/clan/ic_state_following.png');
const postMeIcon = require('@assets/icons/clan/ic_post_me_gray.png');
const policyIcon = require('@assets/icons/clan/ic_profile_note.png');
const cameraIcon = require('@assets/icons/me/ic_action_edit.png');

interface ClanScreenProps {
  handle?: string;
  id?: string;
  onClose: () => void;
  onOpenManage: (clanId: string) => void;
  onOpenMembers: (clanId: string) => void;
}

type StaffConfirm =
  | { type: 'deletePost'; post: Post }
  | { type: 'deleteByUser'; post: Post }
  | { type: 'ban'; post: Post };

function InfoRow({
  icon,
  text,
  onPress,
}: {
  icon: ImageSourcePropType;
  text: string;
  onPress?: () => void;
}) {
  const body = (
    <>
      <Image source={icon} style={{ width: 17, height: 15 }} resizeMode="contain" />
      <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
        {text}
      </Text>
    </>
  );
  if (onPress == null) {
    return <View className="ml-4 mt-2 flex-row items-center gap-1.5">{body}</View>;
  }
  return (
    <Pressable onPress={onPress} className="ml-4 mt-2 flex-row items-center gap-1.5">
      {body}
    </Pressable>
  );
}

function ActionItem({
  icon,
  label,
  active,
  disabled,
  onPress,
}: {
  icon: ImageSourcePropType;
  label: string;
  active?: boolean;
  disabled?: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="flex-1 items-center gap-1 py-1"
      style={{ opacity: disabled ? 0.5 : 1 }}
    >
      <Image source={icon} style={{ height: 20, width: 24 }} resizeMode="contain" />
      <Text className="text-xs" style={{ color: active ? '#7cb342' : 'rgba(0,0,0,0.26)' }}>
        {label}
      </Text>
    </Pressable>
  );
}

export function ClanScreen({ handle, id, onClose, onOpenManage, onOpenMembers }: ClanScreenProps) {
  const { t, i18n } = useTranslation();
  const { width } = useWindowDimensions();
  const pushToast = useToastStore((s) => s.push);
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
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [reportPostId, setReportPostId] = useState<string | null>(null);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const [profileUsername, setProfileUsername] = useState<string | null>(null);
  const [viewer, setViewer] = useState<{ images: string[]; index: number } | null>(null);
  const [imageUploading, setImageUploading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);

  const feedPinned = useClanFeedStore((s) => s.pinned);
  const feedPosts = useClanFeedStore((s) => s.posts);
  const feedLoading = useClanFeedStore((s) => s.loading);
  const feedLoadingMore = useClanFeedStore((s) => s.loadingMore);
  const feedError = useClanFeedStore((s) => s.error);
  const toggleReaction = useClanFeedStore((s) => s.toggleReaction);
  const adjustCommentCount = useClanFeedStore((s) => s.adjustCommentCount);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

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

  const visiblePosts = useMemo(
    () => filterVisiblePosts(feedPosts, hiddenPostIds, blockedAuthorIds),
    [feedPosts, hiddenPostIds, blockedAuthorIds]
  );

  const visiblePinned = useMemo(
    () =>
      feedPinned != null && isPostVisible(feedPinned, hiddenPostIds, blockedAuthorIds)
        ? feedPinned
        : null,
    [feedPinned, hiddenPostIds, blockedAuthorIds]
  );

  const allPosts = useMemo(
    () => (visiblePinned != null ? [visiblePinned, ...visiblePosts] : visiblePosts),
    [visiblePinned, visiblePosts]
  );

  const commentPost =
    commentPostId != null ? allPosts.find((p) => p.id === commentPostId) ?? null : null;
  const menuPost = menuPostId != null ? allPosts.find((p) => p.id === menuPostId) ?? null : null;
  const quickPost =
    quickCommentPostId != null ? allPosts.find((p) => p.id === quickCommentPostId) ?? null : null;

  const handleReaction = (postId: string, type: PostReaction) => void toggleReaction(postId, type);
  const openProfile = (nick: string) => setProfileUsername(nick);

  function openComments(postId: string, focusInput?: boolean) {
    setCommentFocusInput(focusInput === true);
    setCommentPostId(postId);
  }

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

  function requestEdit(post: Post) {
    const createdAtMs = post.createdAt != null ? new Date(post.createdAt).getTime() : 0;
    if (Date.now() - createdAtMs > EDIT_WINDOW_MS) {
      pushToast('info', t('me.editExpired'));
      return;
    }
    setEditingPost(post);
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

  function buildMenuOptions(post: Post): ListOption[] {
    if (clan == null) return [];
    const mine = meId != null && post.author?.id === meId;
    const items: ListOption[] = [];
    if (mine) {
      items.push(
        { key: 'edit', label: t('me.menuEdit'), onSelect: () => requestEdit(post) },
        {
          key: 'delete',
          label: t('me.menuDelete'),
          danger: true,
          onSelect: () => setDeletePostId(post.id),
        }
      );
    } else {
      items.push(
        {
          key: 'hide',
          label: t('me.menuHide'),
          onSelect: () => {
            hidePostLocal(post.id);
            pushToast('success', t('me.hideSuccess'));
          },
        },
        { key: 'report', label: t('report.post'), onSelect: () => setReportPostId(post.id) },
        {
          key: 'block',
          label: t('me.menuBlock'),
          danger: true,
          onSelect: () => {
            const authorId = post.author?.id;
            if (authorId == null || authorId === '') return;
            blockAuthorLocal(authorId);
            pushToast('success', t('me.blockSuccess'));
          },
        }
      );
    }
    if (isClanStaff(clan)) {
      items.push({
        key: 'clanPin',
        label: clan.meTopPostId === post.id ? t('clan.unpinPost') : t('clan.pinPost'),
        onSelect: () => void togglePinTop(post),
      });
      if (!mine) {
        items.push(
          {
            key: 'clanDelete',
            label: t('clan.deletePost'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'deletePost', post }),
          },
          {
            key: 'clanDeleteByUser',
            label: t('clan.deletePostsByUser'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'deleteByUser', post }),
          },
          {
            key: 'clanBan',
            label: t('clan.banUser'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'ban', post }),
          }
        );
      }
    }
    return items;
  }

  async function changeImage(field: 'avatar' | 'cover') {
    if (clan == null || imageUploading) return;
    try {
      const picked =
        field === 'avatar' ? await pickCroppedImage(512, 512) : await pickCroppedImage(1024, 512);
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

  async function submitQuickComment(text: string): Promise<boolean> {
    const postId = quickCommentPostId;
    const content = text.trim();
    if (postId == null || content === '') return false;
    setQuickSubmitting(true);
    try {
      await MeService.addComment(postId, { content });
      adjustCommentCount(postId, 1);
      pushToast('success', t('me.commentSent'));
      setQuickCommentPostId(null);
      return true;
    } catch (err) {
      pushToast(
        'error',
        toApiError(err).status === 403 ? t('me.commentErrFriendsOnly') : t('me.commentSendError')
      );
      return false;
    } finally {
      setQuickSubmitting(false);
    }
  }

  if (clan == null) {
    return (
      <View className="flex-1 bg-[#f3f3f3]">
        <ScreenHeader title={handle != null ? `#${handle}` : t('clan.title')} onBack={onClose} />
        <View className="flex-1 items-center justify-center px-8">
          {loadError != null ? (
            <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {loadError}
            </Text>
          ) : (
            <ActivityIndicator color="#7cb342" size="large" />
          )}
        </View>
      </View>
    );
  }

  const isOwner = clan.myRole === 'owner';
  const privacyOptions: PostVisibility[] = canPostPublicInClan(clan)
    ? ['public', 'private']
    : ['private'];
  const coverHeight = Math.round(width / 2);

  const staffConfirmText =
    staffConfirm == null
      ? ''
      : staffConfirm.type === 'deletePost'
        ? t('clan.deletePostConfirm')
        : staffConfirm.type === 'deleteByUser'
          ? t('clan.deletePostsByUserConfirm', { username: staffConfirm.post.author?.username ?? '' })
          : t('clan.banConfirm', { username: staffConfirm.post.author?.username ?? '' });

  const header = (
    <View>
      <View
        className="mb-2 bg-white pb-4"
        style={{
          shadowColor: '#000',
          shadowOpacity: 0.16,
          shadowRadius: 3,
          shadowOffset: { width: 0, height: 1 },
          elevation: 2,
        }}
      >
        <View style={{ position: 'relative' }}>
          <View style={{ width: '100%', height: coverHeight, backgroundColor: '#33691e' }}>
            {clan.cover != null && clan.cover !== '' && (
              <Image
                source={{ uri: clan.cover }}
                style={{ width: '100%', height: '100%' }}
                resizeMode="cover"
              />
            )}
          </View>
          {isOwner && (
            <Pressable
              onPress={() => void changeImage('cover')}
              className="rounded p-1.5"
              style={{
                position: 'absolute',
                right: 4,
                bottom: 4,
                backgroundColor: 'rgba(0,0,0,0.38)',
              }}
            >
              {imageUploading ? (
                <ActivityIndicator size="small" color="#ffffff" />
              ) : (
                <Image source={cameraIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
              )}
            </Pressable>
          )}
          <View
            className="bg-white p-1 pb-1.5"
            style={{
              position: 'absolute',
              bottom: 8,
              left: 8,
              shadowColor: '#000',
              shadowOpacity: 0.24,
              shadowRadius: 3,
              shadowOffset: { width: 0, height: 1 },
              elevation: 3,
            }}
          >
            <View style={{ width: 96, height: 96, backgroundColor: '#eceff1' }}>
              {clan.avatar != null && clan.avatar !== '' && (
                <Image
                  source={{ uri: clan.avatar }}
                  style={{ width: '100%', height: '100%' }}
                  resizeMode="cover"
                />
              )}
              {isOwner && (
                <Pressable
                  onPress={() => void changeImage('avatar')}
                  className="rounded p-1"
                  style={{
                    position: 'absolute',
                    right: 2,
                    bottom: 2,
                    backgroundColor: 'rgba(0,0,0,0.38)',
                  }}
                >
                  <Image
                    source={cameraIcon}
                    style={{ width: 14, height: 14 }}
                    resizeMode="contain"
                  />
                </Pressable>
              )}
            </View>
          </View>
        </View>

        <Text className="py-2 text-center text-2xl" style={{ color: 'rgba(0,0,0,0.54)' }}>
          #{clan.handle}
        </Text>
        <View className="mx-4" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

        <View className="flex-row px-2 py-2">
          {!isOwner &&
            (clan.isMember ? (
              <ActionItem
                icon={followingIcon}
                label={t('clan.following')}
                active
                onPress={() => setLeaveConfirm(true)}
              />
            ) : (
              <ActionItem
                icon={followIcon}
                label={t('clan.follow')}
                disabled={clan.policy === 3 || clan.isBanned}
                onPress={() => void handleJoin()}
              />
            ))}
          {isOwner && (
            <ActionItem
              icon={manageIcon}
              label={t('clan.manage')}
              onPress={() => onOpenManage(clan.id)}
            />
          )}
          <ActionItem
            icon={postMeIcon}
            label={t('clan.writeMe')}
            onPress={() => setComposerOpen(true)}
          />
        </View>
        <View className="mx-4" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

        <Pressable onPress={() => onOpenMembers(clan.id)} className="my-4 items-center">
          <Text>
            <Text className="text-xl font-bold" style={{ color: '#000' }}>
              {clan.memberCount.toLocaleString()}
            </Text>
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {'  '}
              {t('clan.members')}
            </Text>
          </Text>
        </Pressable>

        <Text className="ml-4 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('clan.createdAt', { date: formatDateDMY(clan.createdAt) })}
        </Text>
        {clan.owner != null && (
          <InfoRow
            icon={CLAN_ROLE_ICONS.owner}
            text={`@${clan.owner.username}`}
            onPress={() => openProfile(clan.owner!.username)}
          />
        )}
        {clan.deputy != null && (
          <InfoRow
            icon={CLAN_ROLE_ICONS.deputy}
            text={`@${clan.deputy.username}`}
            onPress={() => openProfile(clan.deputy!.username)}
          />
        )}
        {clan.ambassador != null && (
          <InfoRow
            icon={CLAN_ROLE_ICONS.ambassador}
            text={`@${clan.ambassador.username}`}
            onPress={() => openProfile(clan.ambassador!.username)}
          />
        )}
        <InfoRow
          icon={policyIcon}
          text={
            clanPolicyLabel(clan.policy) +
            (clan.memberPublicPost ? ` · ${t('clan.memberPublicPost')}` : '')
          }
        />
      </View>

      <Text className="px-4 pb-2 pt-1 text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
        {t('clan.postedTitle')}
      </Text>

      {feedLoading && <ActivityIndicator className="py-10" color="#7cb342" size="large" />}
      {!feedLoading && feedError != null && (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {clanFeedErrorText(feedError)}
        </Text>
      )}
      {!feedLoading && feedError == null && allPosts.length === 0 && (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('clan.emptyFeed')}
        </Text>
      )}
    </View>
  );

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={`#${clan.handle}`} onBack={onClose} />
      <FlashList
        data={feedLoading || feedError != null ? [] : allPosts}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={header}
        contentContainerClassName="pb-2"
        refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
        onEndReached={() => void useClanFeedStore.getState().loadMore()}
        onEndReachedThreshold={0.4}
        ListFooterComponent={
          feedLoadingMore ? <ActivityIndicator className="my-3" color="#7cb342" /> : null
        }
        renderItem={({ item, index }) => (
          <View>
            {visiblePinned != null && index === 0 && (
              <View className="bg-[#dcedc8] px-4 py-1">
                <Text className="text-xs font-bold" style={{ color: '#33691e' }}>
                  {t('clan.meTop')}
                </Text>
              </View>
            )}
            <MePostCard
              post={item}
              timeLabel={postTimeLabel(item.createdAt, timeFormatter)}
              onToggleLike={(postId) => handleReaction(postId, 'like')}
              onToggleDislike={(postId) => handleReaction(postId, 'dislike')}
              onOpenProfile={openProfile}
              onOpenComments={openComments}
              onQuickComment={(postId) => setQuickCommentPostId(postId)}
              onOpenMenu={(postId) => setMenuPostId(postId)}
              onOpenLikers={(postId) => setLikersPostId(postId)}
              onOpenPhotos={(photos, index2) => setViewer({ images: photos, index: index2 })}
            />
          </View>
        )}
      />

      <MeComposerModal
        visible={composerOpen || editingPost != null}
        editPost={editingPost}
        title={t('clan.writeMe')}
        privacyOptions={privacyOptions}
        submitPost={(payload, files, imageUrls) =>
          useClanFeedStore.getState().createPost(clan.id, payload, files, imageUrls)
        }
        onSaved={(post) => {
          if (editingPost != null) useClanFeedStore.getState().syncPost(post);
        }}
        onClose={() => {
          setComposerOpen(false);
          setEditingPost(null);
        }}
      />

      <ListOptionDialog
        visible={menuPost != null}
        title={t('me.postMenu')}
        options={menuPost != null ? buildMenuOptions(menuPost) : []}
        onClose={() => setMenuPostId(null)}
      />

      {reportPostId != null && (
        <ReportDialog
          target={{ type: 'post', id: reportPostId }}
          onClose={() => setReportPostId(null)}
        />
      )}

      {quickCommentPostId != null && (
        <MeQuickCommentBar
          contextLabel={
            quickPost == null
              ? undefined
              : quickPost.content != null && quickPost.content !== ''
                ? quickPost.content
                : quickPost.author?.username
          }
          submitting={quickSubmitting}
          onSubmit={submitQuickComment}
          onClose={() => setQuickCommentPostId(null)}
        />
      )}

      <ConfirmDialog
        visible={deletePostId != null}
        danger
        title={t('me.deleteConfirmTitle')}
        message={t('me.deleteConfirmText')}
        confirmLabel={t('me.deleteConfirmOk')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const postId = deletePostId;
          setDeletePostId(null);
          if (postId != null) void deleteOwnPost(postId);
        }}
        onCancel={() => setDeletePostId(null)}
      />

      <ConfirmDialog
        visible={leaveConfirm}
        danger
        title={t('clan.leave')}
        message={t('clan.leaveConfirm', { name: clan.handle })}
        confirmLabel={t('clan.leave')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void handleLeave()}
        onCancel={() => setLeaveConfirm(false)}
      />

      <ConfirmDialog
        visible={staffConfirm != null}
        danger
        title={staffConfirm?.type === 'ban' ? t('clan.banUser') : t('clan.deletePost')}
        message={staffConfirmText}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void runStaffConfirm()}
        onCancel={() => setStaffConfirm(null)}
      />

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={i18n.language}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={(postId) => handleReaction(postId, 'like')}
          onToggleDislike={(postId) => handleReaction(postId, 'dislike')}
          onOpenProfile={openProfile}
          onOpenLikers={(postId) => setLikersPostId(postId)}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={openProfile}
        />
      )}

      {viewer != null && (
        <MediaViewerModal
          images={viewer.images}
          index={viewer.index}
          onClose={() => setViewer(null)}
        />
      )}

      {profileUsername != null && (
        <UserProfileScreen
          key={profileUsername}
          username={profileUsername}
          language={i18n.language}
          onClose={() => setProfileUsername(null)}
          onOpenProfile={openProfile}
        />
      )}
    </View>
  );
}

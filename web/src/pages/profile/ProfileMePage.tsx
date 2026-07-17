import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { MeService, UserService } from '@services';
import { activeVipTypeId, colorForName, createDateFormatter, createTimeFormatter, toast } from '@lib';
import type { Post } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import genderIcon from '@/assets/icons/profile/ic_indicate_dynamic_gender.png';
import birthdayIcon from '@/assets/icons/profile/ic_profile_birthday.png';
import marriageIcon from '@/assets/icons/profile/ic_profile_marriage.png';
import cameraIcon from '@/assets/icons/profile/ic_action_camera.png';
import { Avatar, ScreenHeader, FullScreenOverlay, UserName, VipIcon } from '@components';
import { CoverImageEditor } from './components/CoverImageEditor';
import { FollowingListOverlay } from './components/FollowingListOverlay';
import { UserProfileView } from './UserProfileView';
import { COVER_ASPECT } from './constants';
import { MePostCard } from '../me/components/MePostCard';
import { MePostInteractions, type MePostSource } from '../me/MePostInteractions';
import { toMePost } from '../me/mappers';
import { useEditMePost } from '../me/useEditMePost';
import { usePostListActions } from '@ola/shared/stores/usePostListActions';

export function ProfileMePage() {
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const hidePost = useMeLocalStore((s) => s.hidePost);
  const blockAuthor = useMeLocalStore((s) => s.blockAuthor);
  const [posts, setPosts] = useState<Post[]>([]);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [coverPreview, setCoverPreview] = useState<{ url: string; file: File } | null>(null);
  const [spouseTarget, setSpouseTarget] = useState<{ username: string; color: string } | null>(null);
  const [followingOpen, setFollowingOpen] = useState(false);
  const [followersOpen, setFollowersOpen] = useState(false);
  const [friendTarget, setFriendTarget] = useState<{ username: string; color: string } | null>(null);
  const coverInputRef = useRef<HTMLInputElement>(null);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const formatDate = useMemo(() => createDateFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    let active = true;
    MeService.mine({ limit: 30 })
      .then((result) => {
        if (active) setPosts(result.items);
      })
      .catch(() => {});
    return () => {
      active = false;
    };
  }, []);

  const reloadAfterPin = useCallback(async () => {
    const result = await MeService.mine({ limit: 30 });
    setPosts(() => result.items);
  }, []);

  const { toggleReaction, adjustCommentCount, deletePost, togglePin } = usePostListActions({
    posts,
    setPosts,
    reloadAfterPin,
  });

  const editPost = useEditMePost(posts, setPosts);

  const uploadCover = useCallback(
    async (file: File) => {
      setUploadingCover(true);
      try {
        const { url } = await UserService.uploadAvatar(file);
        await UserService.updateMe({ coverPhoto: url });
        await refreshUser();
        toast.success(t('profileEdit.coverUpdated'));
        return true;
      } catch {
        toast.error(t('profileEdit.coverError'));
        return false;
      } finally {
        setUploadingCover(false);
      }
    },
    [refreshUser, t]
  );

  const clearCoverPreview = useCallback(() => {
    setCoverPreview((prev) => {
      if (prev) URL.revokeObjectURL(prev.url);
      return null;
    });
  }, []);

  useEffect(() => clearCoverPreview, [clearCoverPreview]);

  function pickCover(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file) return;
    clearCoverPreview();
    setCoverPreview({ url: URL.createObjectURL(file), file });
  }

  if (!user) return null;

  const nick = user.fullName || user.username;
  const color = colorForName(nick);
  const spouse = user.spouse;
  const openSpouse = () => {
    if (spouse) setSpouseTarget({ username: spouse.username, color: colorForName(spouse.username) });
  };
  const openFollowing = () => {
    if ((user.followingCount ?? 0) === 0) return;
    setFollowingOpen(true);
  };
  const openFollowers = () => {
    if ((user.followerCount ?? 0) === 0) return;
    setFollowersOpen(true);
  };
  const vipTypeId = activeVipTypeId(user.vipUsed, user.vipEndTime);
  const mePosts = posts
    .map((post) => toMePost(post, formatTime))
    .filter((post) => !hiddenPostIds.includes(post.id));

  const source: MePostSource = {
    posts: mePosts,
    meId: user.id,
    toggleReaction,
    adjustCommentCount,
    hidePost,
    blockAuthor,
    editPost,
    deletePost,
    togglePin,
  };

  return (
    <>
    <FullScreenOverlay>
      <ScreenHeader title={nick} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto">
        <div className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
          <div
            className="relative mb-12 aspect-video w-full bg-ola-primary-darker bg-cover bg-center"
            style={user.coverPhoto ? { backgroundImage: `url(${user.coverPhoto})` } : undefined}
          >
            <button
              type="button"
              onClick={() => coverInputRef.current?.click()}
              disabled={uploadingCover}
              aria-label={t('profile.changeCover')}
              className="absolute right-2 bottom-2 flex h-8 w-8 items-center justify-center rounded-full bg-black/40 disabled:opacity-60"
            >
              <img src={cameraIcon} alt="" className="h-5 w-5 object-contain brightness-0 invert" />
            </button>
            {uploadingCover && (
              <div className="absolute inset-0 flex items-center justify-center bg-black/30 text-sm text-white">
                {t('common.loading')}
              </div>
            )}
            <input
              ref={coverInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              aria-label={t('profile.changeCover')}
              onChange={pickCover}
            />
            <div className="absolute -bottom-12 left-1/2 flex -translate-x-1/2 gap-1 bg-white p-px pb-0.5 shadow-[0_1px_3px_rgba(0,0,0,0.3)]">
              <Avatar name={nick} color={color} size={96} src={user.avatar} rounded={false} />
              {spouse ? (
                <button type="button" onClick={openSpouse} className="leading-none">
                  <Avatar
                    name={spouse.fullName || spouse.username}
                    color={colorForName(spouse.username)}
                    size={96}
                    src={spouse.avatar}
                    rounded={false}
                  />
                </button>
              ) : null}
            </div>
          </div>

          {coverPreview && (
            <CoverImageEditor
              src={coverPreview.url}
              aspect={COVER_ASPECT}
              busy={uploadingCover}
              onCancel={clearCoverPreview}
              onApply={async (file) => {
                const ok = await uploadCover(file);
                if (ok) clearCoverPreview();
              }}
            />
          )}

          <div className="flex items-center justify-center p-2">
            <UserName
              name={`@${user.username}`}
              fullName={user.fullName}
              className="min-w-0 truncate text-lg text-black/87"
              fullNameClassName="text-black/54"
            />
          </div>

          <div className="mx-4 h-px bg-black/12" />

          <div className="mt-4 flex items-center justify-center gap-6">
            <button
              type="button"
              onClick={openFollowers}
              disabled={(user.followerCount ?? 0) === 0}
              className="flex items-baseline gap-1 rounded-lg px-3 py-1 transition-colors hover:bg-black/5 disabled:opacity-100 disabled:hover:bg-transparent"
            >
              <b className="text-xl text-black">{user.followerCount ?? 0}</b>
              <span className="text-xs text-black/54">{t('profile.peopleCare')}</span>
            </button>
            <button
              type="button"
              onClick={openFollowing}
              disabled={(user.followingCount ?? 0) === 0}
              className="flex items-baseline gap-1 rounded-lg px-3 py-1 transition-colors hover:bg-black/5 disabled:opacity-100 disabled:hover:bg-transparent"
            >
              <b className="text-xl text-black">{user.followingCount ?? 0}</b>
              <span className="text-xs text-black/54">{t('profile.following')}</span>
            </button>
          </div>

          {user.bio ? (
            <p className="mt-3 px-4 text-center text-xs text-black/54">{user.bio}</p>
          ) : null}

          {vipTypeId != null ? (
            <div className="mt-3 ml-4 flex items-center gap-1">
              <VipIcon typeId={vipTypeId} className="h-6 w-6" />
              <span className="text-xs font-bold text-ola-accent">{t('profile.vipAccount')}</span>
            </div>
          ) : null}

          <div className="pb-4">
            <div className="mt-2 ml-4 flex items-center gap-1 text-xs text-black/54">
              <img src={genderIcon} alt="" className="h-3.5 w-auto shrink-0 object-contain" />
              {user.gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')}
            </div>
            {user.dateOfBirth ? (
              <div className="mt-2 ml-4 flex items-center gap-1 text-xs text-black/54">
                <img src={birthdayIcon} alt="" className="h-3.5 w-auto shrink-0 object-contain" />
                {formatDate(user.dateOfBirth)}
              </div>
            ) : null}
            {user.createdAt ? (
              <div className="mt-2 ml-4 text-xs text-black/54">
                {t('profile.joinedOla')} {formatDate(user.createdAt)}
              </div>
            ) : null}
            <div className="mt-2 ml-4 flex items-center gap-1 text-xs text-black/54">
              <img src={marriageIcon} alt="" className="h-3.5 w-auto shrink-0 object-contain" />
              {spouse ? (
                <span>
                  {t('marriage.marryWithLabel')}{' '}
                  <button
                    type="button"
                    onClick={openSpouse}
                    className="text-ola-primary-darker"
                  >
                    @{spouse.username}
                  </button>
                </span>
              ) : (
                <span>{t('marriage.single')}</span>
              )}
            </div>
          </div>
        </div>

        <h3 className="mx-4 mt-2 mb-1 text-base font-medium text-black/87">{t('profile.mePosts')}</h3>
        <MePostInteractions source={source}>
          {(handlers) =>
            mePosts.map((post) => (
              <MePostCard
                key={post.id}
                post={post}
                onToggleLike={handlers.onToggleLike}
                onToggleDislike={handlers.onToggleDislike}
                onOpenProfile={handlers.onOpenProfile}
                onOpenComments={handlers.onOpenComments}
                onQuickComment={handlers.onQuickComment}
                onOpenMenu={handlers.onOpenMenu}
                onOpenLikers={handlers.onOpenLikers}
              />
            ))
          }
        </MePostInteractions>
      </div>
    </FullScreenOverlay>
    {followingOpen ? (
      <FollowingListOverlay
        userId={user.id}
        kind="following"
        onClose={() => setFollowingOpen(false)}
        onSelect={(friend) => {
          setFollowingOpen(false);
          setFriendTarget({ username: friend.name, color: friend.color });
        }}
      />
    ) : null}
    {followersOpen ? (
      <FollowingListOverlay
        title={t('profile.peopleCare')}
        userId={user.id}
        kind="followers"
        onClose={() => setFollowersOpen(false)}
        onSelect={(friend) => {
          setFollowersOpen(false);
          setFriendTarget({ username: friend.name, color: friend.color });
        }}
      />
    ) : null}
    {friendTarget ? (
      <UserProfileView
        key={friendTarget.username}
        username={friendTarget.username}
        color={friendTarget.color}
        onClose={() => setFriendTarget(null)}
        onOpenFriend={(friend) => setFriendTarget({ username: friend.name, color: friend.color })}
      />
    ) : null}
    {spouseTarget ? (
      <UserProfileView
        key={spouseTarget.username}
        username={spouseTarget.username}
        color={spouseTarget.color}
        onClose={() => setSpouseTarget(null)}
        onOpenFriend={(friend) => setSpouseTarget({ username: friend.name, color: friend.color })}
      />
    ) : null}
    </>
  );
}

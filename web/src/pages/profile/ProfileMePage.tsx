import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { MeService } from '@services';
import { colorForName, createDateFormatter, createTimeFormatter, toast } from '@lib';
import type { Post, PostReaction } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import genderIcon from '@/assets/icons/profile/ic_indicate_dynamic_gender.png';
import birthdayIcon from '@/assets/icons/profile/ic_profile_birthday.png';
import { Avatar, ScreenHeader, FullScreenOverlay } from '@components';
import { MePostCard } from '../me/components/MePostCard';
import { MePostInteractions, type MePostSource } from '../me/MePostInteractions';
import { composedToImages, composedToPayload } from '../me/composer';
import { toMePost } from '../me/mappers';
import type { ComposedPost } from '../me/components/MeComposerDialog';

export function ProfileMePage() {
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const hidePost = useMeLocalStore((s) => s.hidePost);
  const blockAuthor = useMeLocalStore((s) => s.blockAuthor);
  const [posts, setPosts] = useState<Post[]>([]);

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

  const toggleReaction = useCallback(
    async (id: string, type: PostReaction) => {
      const post = posts.find((item) => item.id === id);
      if (post == null) return;
      const isActive = post.myReaction === type;
      try {
        const updated = isActive
          ? await MeService.removeReaction(id)
          : await MeService.react(id, type);
        setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
      } catch {
        toast.error(t('me.reactionError'));
      }
    },
    [posts, t]
  );

  const adjustCommentCount = useCallback((id: string, delta: number) => {
    setPosts((current) =>
      current.map((item) =>
        item.id === id ? { ...item, commentCount: Math.max(0, item.commentCount + delta) } : item
      )
    );
  }, []);

  const editPost = useCallback(
    async (id: string, draft: ComposedPost): Promise<boolean> => {
      try {
        const images = await composedToImages(draft, 'existingFirst');
        const updated = await MeService.update(id, { ...composedToPayload(draft), images });
        setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
        toast.success(t('me.editSuccess'));
        return true;
      } catch {
        toast.error(t('me.editError'));
        return false;
      }
    },
    [t]
  );

  const deletePost = useCallback(
    async (id: string) => {
      try {
        await MeService.remove(id);
        setPosts((current) => current.filter((item) => item.id !== id));
        toast.success(t('me.deleteSuccess'));
      } catch {
        toast.error(t('me.deleteError'));
      }
    },
    [t]
  );

  const togglePin = useCallback(
    async (id: string, pinned: boolean) => {
      try {
        if (pinned) await MeService.pin(id);
        else await MeService.unpin(id);
        const result = await MeService.mine({ limit: 30 });
        setPosts(result.items);
        toast.success(t(pinned ? 'me.pinSuccess' : 'me.unpinSuccess'));
      } catch {
        toast.error(t('me.pinError'));
      }
    },
    [t]
  );

  if (!user) return null;

  const nick = user.fullName || user.username;
  const color = colorForName(nick);
  const isVip = Boolean(user.vipUsed);
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
    <FullScreenOverlay>
      <ScreenHeader title={nick} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto">
        <div className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
          <div className="relative mb-12 aspect-[16/9] w-full bg-ola-primary-darker">
            <div className="absolute -bottom-12 left-1/2 flex -translate-x-1/2 bg-white p-1 pb-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.3)]">
              <Avatar name={nick} color={color} size={96} src={user.avatar} rounded={false} />
            </div>
          </div>

          <div className="flex items-center justify-center p-2">
            <span className="text-lg text-black/54">{nick}</span>
          </div>

          <div className="mx-4 h-px bg-black/12" />

          <div className="mt-4 flex items-center justify-center gap-6">
            <div className="flex items-baseline gap-1">
              <b className="text-xl text-black">{user.followerCount ?? 0}</b>
              <span className="text-xs text-black/54">{t('profile.peopleCare')}</span>
            </div>
            <div className="flex items-baseline gap-1">
              <b className="text-xl text-black">{user.followingCount ?? 0}</b>
              <span className="text-xs text-black/54">{t('profile.following')}</span>
            </div>
          </div>

          {user.bio ? (
            <p className="mt-3 px-4 text-center text-xs text-black/54">{user.bio}</p>
          ) : null}

          {isVip ? (
            <div className="mt-3 ml-4 flex items-center gap-1">
              <span className="flex h-6 w-6 items-center justify-center rounded-full bg-ola-accent text-xs font-bold text-white">
                ★
              </span>
              <span className="text-xs font-bold text-ola-accent">{t('profile.vipAccount')}</span>
            </div>
          ) : null}

          <div className="pb-4">
            <div className="mt-2 ml-4 flex items-center gap-1 text-xs text-black/54">
              <img src={genderIcon} alt="" className="h-4 w-4 object-contain" />
              {user.gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')}
            </div>
            {user.dateOfBirth ? (
              <div className="mt-2 ml-4 flex items-center gap-1 text-xs text-black/54">
                <img src={birthdayIcon} alt="" className="h-4 w-4 object-contain" />
                {formatDate(user.dateOfBirth)}
              </div>
            ) : null}
            {user.createdAt ? (
              <div className="mt-2 ml-4 text-xs text-black/54">
                {t('profile.joinedOla')} {formatDate(user.createdAt)}
              </div>
            ) : null}
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
  );
}

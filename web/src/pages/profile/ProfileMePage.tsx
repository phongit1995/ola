import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { MeService } from '@services';
import { colorForName, createDateFormatter, createTimeFormatter, toast } from '@lib';
import type { Post, PostReaction } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import genderIcon from '@/assets/icons/profile/ic_indicate_dynamic_gender.png';
import birthdayIcon from '@/assets/icons/profile/ic_profile_birthday.png';
import { Avatar } from '@components';
import { MePostCard } from '../me/components/MePostCard';
import { toMePost } from '../me/mappers';

export function ProfileMePage() {
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
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

  if (!user) return null;

  const nick = user.fullName || user.username;
  const color = colorForName(nick);
  const isVip = Boolean(user.vipUsed);
  const mePosts = posts.map((post) => toMePost(post, formatTime));

  async function toggle(id: string, type: PostReaction) {
    const post = posts.find((item) => item.id === id);
    if (!post) return;
    const isActive = post.myReaction === type;
    try {
      const updated = isActive ? await MeService.removeReaction(id) : await MeService.react(id, type);
      setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
    } catch {
      toast.error(t('me.reactionError'));
    }
  }

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={() => navigate(ROUTES.home)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">{nick}</span>
      </header>

      <div className="flex-1 overflow-y-auto">
        <div className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
          <div className="relative mb-12 aspect-[16/9] w-full bg-ola-primary-darker">
            <div className="absolute -bottom-12 left-1/2 flex -translate-x-1/2 bg-white p-1 pb-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.3)]">
              {user.avatar ? (
                <img src={user.avatar} alt="" className="h-24 w-24 object-cover" />
              ) : (
                <Avatar name={nick} color={color} size={96} />
              )}
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
        {mePosts.map((post) => (
          <MePostCard
            key={post.id}
            post={post}
            onToggleLike={(id) => toggle(id, 'like')}
            onToggleDislike={(id) => toggle(id, 'dislike')}
          />
        ))}
      </div>
    </div>
  );
}

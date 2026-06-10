import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MePostCard } from '../me/components/MePostCard';
import type { MePost } from '../me/types';
import { ProfileCard } from './components/ProfileCard';
import { ProfileMediaStore } from './components/ProfileMediaStore';
import { ProfileFollowing } from './components/ProfileFollowing';
import { EditProfilePage } from './EditProfilePage';
import type { ProfileFriend, UserProfile } from './types';

interface ProfilePageProps {
  profile: UserProfile;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
}

export function ProfilePage({ profile, onClose, onOpenFriend }: ProfilePageProps) {
  const { t } = useTranslation();
  const [posts, setPosts] = useState<MePost[]>(profile.posts);
  const [editOpen, setEditOpen] = useState(false);

  function toggleLike(id: string) {
    setPosts((current) =>
      current.map((post) =>
        post.id === id
          ? { ...post, liked: !post.liked, likes: post.likes + (post.liked ? -1 : 1) }
          : post
      )
    );
  }

  function toggleDislike(id: string) {
    setPosts((current) =>
      current.map((post) =>
        post.id === id ? { ...post, disliked: !post.disliked } : post
      )
    );
  }

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={onClose}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">{profile.nick}</span>
      </header>

      <div className="flex-1 overflow-y-auto">
        <ProfileCard
          profile={profile}
          onPostMe={() => {}}
          onUpdateInfo={() => setEditOpen(true)}
        />
        <ProfileMediaStore media={profile.media} />
        <ProfileFollowing following={profile.following} onSelect={onOpenFriend} />

        <h3 className="mx-4 mt-2 mb-1 text-base font-medium text-black/87">
          {t('profile.mePosts')}
        </h3>
        {posts.map((post) => (
          <MePostCard
            key={post.id}
            post={post}
            onToggleLike={toggleLike}
            onToggleDislike={toggleDislike}
          />
        ))}
      </div>

      {editOpen && (
        <EditProfilePage profile={profile} onClose={() => setEditOpen(false)} />
      )}
    </div>
  );
}

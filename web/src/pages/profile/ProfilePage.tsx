import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScreenHeader, FullScreenOverlay } from '@components';
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
    <FullScreenOverlay>
      <ScreenHeader title={profile.nick} onBack={onClose} />

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
    </FullScreenOverlay>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScreenHeader, FullScreenOverlay } from '@components';
import type { RelationshipInfo } from '@app-types';
import { MePostCard } from '../me/components/MePostCard';
import { ProfileCard } from './components/ProfileCard';
import { ProfileMediaStore } from './components/ProfileMediaStore';
import { ProfileFollowing } from './components/ProfileFollowing';
import { EditProfilePage } from './EditProfilePage';
import type { ProfileActions, ProfileFriend, ProfileSecondary, UserProfile } from './types';

interface PostOverride {
  liked: boolean;
  disliked: boolean;
  likes: number;
}

interface ProfilePageProps {
  profile: UserProfile;
  relationship: RelationshipInfo;
  actions: ProfileActions;
  secondary: ProfileSecondary;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
}

export function ProfilePage({
  profile,
  relationship,
  actions,
  secondary,
  onClose,
  onOpenFriend,
}: ProfilePageProps) {
  const { t } = useTranslation();
  const [overrides, setOverrides] = useState<Record<string, PostOverride>>({});
  const [editOpen, setEditOpen] = useState(false);

  const posts = secondary.posts.map((post) => {
    const override = overrides[post.id];
    return override ? { ...post, ...override } : post;
  });

  function toggleLike(id: string) {
    setOverrides((current) => {
      const base = secondary.posts.find((post) => post.id === id);
      if (!base) return current;
      const merged = { ...base, ...current[id] };
      return {
        ...current,
        [id]: { liked: !merged.liked, disliked: merged.disliked, likes: merged.likes + (merged.liked ? -1 : 1) },
      };
    });
  }

  function toggleDislike(id: string) {
    setOverrides((current) => {
      const base = secondary.posts.find((post) => post.id === id);
      if (!base) return current;
      const merged = { ...base, ...current[id] };
      return { ...current, [id]: { liked: merged.liked, disliked: !merged.disliked, likes: merged.likes } };
    });
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={profile.nick} onBack={onClose} />

      <div className="flex-1 overflow-y-auto">
        <ProfileCard
          profile={profile}
          relationship={relationship}
          actions={actions}
          onPostMe={() => {}}
          onUpdateInfo={() => setEditOpen(true)}
        />
        {secondary.media.length > 0 && <ProfileMediaStore media={secondary.media} />}
        {secondary.following.length > 0 && (
          <ProfileFollowing following={secondary.following} onSelect={onOpenFriend} />
        )}

        <h3 className="mx-4 mt-2 mb-1 text-base font-medium text-black/87">{t('profile.mePosts')}</h3>
        {secondary.loading && posts.length === 0 ? (
          <div className="flex justify-center py-6">
            <div className="h-6 w-6 animate-spin rounded-full border-2 border-ola-primary border-t-transparent" />
          </div>
        ) : (
          posts.map((post) => (
            <MePostCard
              key={post.id}
              post={post}
              onToggleLike={toggleLike}
              onToggleDislike={toggleDislike}
            />
          ))
        )}
      </div>

      {editOpen && <EditProfilePage profile={profile} onClose={() => setEditOpen(false)} />}
    </FullScreenOverlay>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScreenHeader, FullScreenOverlay, Spinner } from '@components';
import { colorForName } from '@lib';
import composeIcon from '@/assets/icons/chat/ic_action_compose_message.png';
import { useAuthStore } from '@/store/authStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import type { RelationshipInfo } from '@app-types';
import { MePostCard } from '../me/components/MePostCard';
import { MeComposerDialog } from '../me/components/MeComposerDialog';
import { MePostInteractions, type MePostSource } from '../me/MePostInteractions';
import { ProfileCard } from './components/ProfileCard';
import { ProfileMediaStore } from './components/ProfileMediaStore';
import { ProfileFollowing } from './components/ProfileFollowing';
import { FollowingListOverlay } from './components/FollowingListOverlay';
import { PeerVipStoreDialog } from './components/PeerVipStoreDialog';
import { EditProfileMePage } from './EditProfileMePage';
import type {
  ProfileActions,
  ProfileFriend,
  ProfilePostActions,
  ProfileSecondary,
  UserProfile,
} from './types';

interface ProfilePageProps {
  profile: UserProfile;
  userId: string;
  relationship: RelationshipInfo;
  actions: ProfileActions;
  secondary: ProfileSecondary;
  postActions: ProfilePostActions;
  onClose: () => void;
  onOpenFriend: (friend: ProfileFriend) => void;
  z?: 40 | 50 | 60;
}

export function ProfilePage({
  profile,
  userId,
  relationship,
  actions,
  secondary,
  postActions,
  onClose,
  onOpenFriend,
  z = 40,
}: ProfilePageProps) {
  const { t } = useTranslation();
  const meId = useAuthStore((s) => s.user?.id ?? null);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const hidePost = useMeLocalStore((s) => s.hidePost);
  const blockAuthor = useMeLocalStore((s) => s.blockAuthor);
  const [editOpen, setEditOpen] = useState(false);
  const [composerOpen, setComposerOpen] = useState(false);
  const [followersOpen, setFollowersOpen] = useState(false);
  const [vipStoreOpen, setVipStoreOpen] = useState(false);

  const posts = secondary.posts.filter((post) => !hiddenPostIds.includes(post.id));

  const source: MePostSource = {
    posts,
    meId,
    toggleReaction: postActions.toggleReaction,
    adjustCommentCount: postActions.adjustCommentCount,
    hidePost,
    blockAuthor,
    editPost: postActions.editPost,
    deletePost: postActions.deletePost,
    togglePin: postActions.togglePin,
  };

  return (
    <FullScreenOverlay z={z}>
      <ScreenHeader title={profile.nick} onBack={onClose} />

      <div className="flex-1 overflow-y-auto">
        <ProfileCard
          userId={userId}
          profile={profile}
          relationship={relationship}
          actions={actions}
          onPostMe={() => setComposerOpen(true)}
          onUpdateInfo={() => setEditOpen(true)}
          onViewVipStore={() => setVipStoreOpen(true)}
          onOpenUser={(nick) => onOpenFriend({ name: nick, color: colorForName(nick) })}
          onOpenFollowers={() => setFollowersOpen(true)}
        />
        {secondary.media.length > 0 && <ProfileMediaStore media={secondary.media} />}
        {secondary.following.length > 0 && (
          <ProfileFollowing userId={userId} following={secondary.following} onSelect={onOpenFriend} />
        )}

        <h3 className="mx-4 mt-2 mb-1 text-base font-medium text-black/87">{t('profile.mePosts')}</h3>
        <MePostInteractions source={source}>
          {(handlers) =>
            secondary.loading && posts.length === 0 ? (
              <div className="flex justify-center py-6">
                <Spinner size={24} />
              </div>
            ) : (
              posts.map((post) => (
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
            )
          }
        </MePostInteractions>
      </div>

      {!profile.isSelf && (
        <button
          type="button"
          aria-label={t('profile.message')}
          onClick={actions.message}
          className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg"
        >
          <img src={composeIcon} alt="" className="h-6 w-6 object-contain brightness-0 invert" />
        </button>
      )}

      {editOpen && <EditProfileMePage onClose={() => setEditOpen(false)} />}

      <MeComposerDialog
        open={composerOpen}
        onClose={() => setComposerOpen(false)}
        onPost={postActions.addPost}
      />

      {vipStoreOpen && (
        <PeerVipStoreDialog
          userId={userId}
          name={profile.username}
          onClose={() => setVipStoreOpen(false)}
        />
      )}

      {followersOpen && (
        <FollowingListOverlay
          title={t('profile.peopleCare')}
          userId={userId}
          kind="followers"
          onClose={() => setFollowersOpen(false)}
          onSelect={(friend) => {
            setFollowersOpen(false);
            onOpenFriend(friend);
          }}
        />
      )}
    </FullScreenOverlay>
  );
}

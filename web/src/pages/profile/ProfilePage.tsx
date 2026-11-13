import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ScreenHeader,
  FullScreenOverlay,
  GiftPickerDialog,
  Spinner,
} from '@components';
import { GIFT_SOURCE } from '@constants';
import { useGiftCatalogStore } from '@ola/shared/stores/gift/giftCatalogStore';
import { colorForName } from '@lib';
import composeIcon from '@/assets/icons/chat/ic_action_compose_message.png';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useMeLocalStore } from '@ola/shared/stores/meLocalStore';
import type { RelationshipInfo } from '@app-types';
import { MePostCard } from '../me/components/MePostCard';
import { MeComposerDialog } from '../me/components/MeComposerDialog';
import {
  MePostInteractions,
  type MePostSource,
} from '../me/MePostInteractions';
import { ProfileCard } from './components/ProfileCard';
import { ProfileMediaStore } from './components/ProfileMediaStore';
import { ProfileFollowing } from './components/ProfileFollowing';
import { FollowingListOverlay } from './components/FollowingListOverlay';
import { PeerVipStoreDialog } from './components/PeerVipStoreDialog';
import { PeerAvatarFrameStoreDialog } from './components/PeerAvatarFrameStoreDialog';
import { GiftWallSection } from './components/GiftWallSection';
import { GiftHistoryPage } from '../gift/GiftHistoryPage';
import { EditProfileMePage } from './EditProfileMePage';
import type {
  ProfileActions,
  ProfileFriend,
  ProfilePostActions,
  ProfileSecondary,
  UserProfile,
} from './types';

const POSTS_PREFETCH_MARGIN = '320px';

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
  const [frameStoreOpen, setFrameStoreOpen] = useState(false);
  const [giftOpen, setGiftOpen] = useState(false);
  const [giftWallKey, setGiftWallKey] = useState(0);
  const [giftHistoryOpen, setGiftHistoryOpen] = useState(false);
  const giftsEnabled = useGiftCatalogStore((s) => s.settings.enabled);
  const loadGiftSettings = useGiftCatalogStore((s) => s.loadSettings);
  const scrollRef = useRef<HTMLDivElement>(null);
  const postsEndRef = useRef<HTMLDivElement>(null);
  const { hasMorePosts, loadingMorePosts } = secondary;
  const loadMorePosts = postActions.loadMorePosts;
  const loadedPostCount = secondary.posts.length;

  useEffect(() => {
    const end = postsEndRef.current;
    const root = scrollRef.current;
    if (end == null || root == null || !hasMorePosts) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0]?.isIntersecting) void loadMorePosts();
      },
      { root, rootMargin: POSTS_PREFETCH_MARGIN }
    );
    observer.observe(end);
    return () => observer.disconnect();
  }, [hasMorePosts, loadMorePosts, loadedPostCount]);

  useEffect(() => {
    void loadGiftSettings();
  }, [loadGiftSettings]);

  const posts = secondary.posts.filter(
    (post) => !hiddenPostIds.includes(post.id)
  );

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

      <div ref={scrollRef} className="flex-1 overflow-y-auto">
        <ProfileCard
          userId={userId}
          profile={profile}
          relationship={relationship}
          actions={actions}
          onPostMe={() => setComposerOpen(true)}
          onUpdateInfo={() => setEditOpen(true)}
          onViewVipStore={() => setVipStoreOpen(true)}
          onViewAvatarFrameStore={() => setFrameStoreOpen(true)}
          onOpenUser={(nick) =>
            onOpenFriend({ name: nick, color: colorForName(nick) })
          }
          onOpenFollowers={() => setFollowersOpen(true)}
          onSendGift={
            !profile.isSelf && giftsEnabled
              ? () => setGiftOpen(true)
              : undefined
          }
        />
        {profile.canViewGiftWall && (
          <GiftWallSection
            userId={userId}
            isSelf={profile.isSelf}
            refreshKey={giftWallKey}
            onOpenHistory={() => setGiftHistoryOpen(true)}
          />
        )}
        {secondary.media.length > 0 && (
          <ProfileMediaStore media={secondary.media} />
        )}
        {secondary.following.length > 0 && (
          <ProfileFollowing
            userId={userId}
            following={secondary.following}
            onSelect={onOpenFriend}
          />
        )}

        <h3 className="mx-4 mt-2 mb-1 text-base font-medium text-black/87">
          {t('profile.mePosts')}
        </h3>
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
                  showPinned
                />
              ))
            )
          }
        </MePostInteractions>
        {hasMorePosts && (
          <div ref={postsEndRef} className="flex justify-center py-4">
            {loadingMorePosts && <Spinner size={20} />}
          </div>
        )}
      </div>

      {!profile.isSelf && (
        <button
          type="button"
          aria-label={t('profile.message')}
          onClick={actions.message}
          className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg"
        >
          <img
            src={composeIcon}
            alt=""
            className="h-7 w-7 object-contain icon-on-primary"
          />
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

      {frameStoreOpen && (
        <PeerAvatarFrameStoreDialog
          userId={userId}
          name={profile.username}
          onClose={() => setFrameStoreOpen(false)}
        />
      )}

      {!profile.isSelf && (
        <GiftPickerDialog
          open={giftOpen}
          source={GIFT_SOURCE.profile}
          onClose={() => setGiftOpen(false)}
          receiver={{
            id: userId,
            name: profile.nick,
            username: profile.username,
            avatar: profile.avatar,
            avatarFrameId: profile.avatarFrameId,
            color: profile.color,
          }}
          onSent={(result) => {
            actions.applyCharm(result.receiverCharm);
            setGiftWallKey((key) => key + 1);
          }}
        />
      )}

      {giftHistoryOpen && (
        <GiftHistoryPage
          z={60}
          onClose={() => setGiftHistoryOpen(false)}
          onOpenUser={(user) =>
            onOpenFriend({
              name: user.username,
              color: colorForName(user.username),
            })
          }
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

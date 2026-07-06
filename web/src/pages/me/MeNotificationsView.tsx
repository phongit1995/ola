import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Avatar, Spinner } from '@components';
import { colorForName, createTimeFormatter, toast } from '@lib';
import { MeService } from '@services';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import type { MeNotification, MeNotificationType, PostReaction } from '@app-types';
import likeIcon from '@/assets/icons/notify/ic_notification_like.png';
import commentIcon from '@/assets/icons/notify/ic_notification_comment.png';
import mentionIcon from '@/assets/icons/notify/ic_notification_mention.png';
import { toMePost, applyMeReaction, meSelfLiker, reconcileMeLikers } from './mappers';
import type { MePost } from './types';
import { MeCommentSheet } from './components/MeCommentSheet';
import { UserProfileView } from '../profile/UserProfileView';

const TYPE_ICON: Record<MeNotificationType, string> = {
  like: likeIcon,
  comment: commentIcon,
  mention: mentionIcon,
};

interface MeNotificationsViewProps {
  onClose: () => void;
}

export function MeNotificationsView({ onClose }: MeNotificationsViewProps) {
  const { t, i18n } = useTranslation();
  const items = useMeNotificationStore((s) => s.items);
  const loading = useMeNotificationStore((s) => s.loading);
  const load = useMeNotificationStore((s) => s.load);
  const markAllRead = useMeNotificationStore((s) => s.markAllRead);

  const [openPost, setOpenPost] = useState<MePost | null>(null);
  const [openingId, setOpeningId] = useState<string | null>(null);
  const [profileTarget, setProfileTarget] = useState<{ username: string; color: string } | null>(
    null,
  );

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  function labelFor(type: MeNotificationType): string {
    if (type === 'comment') return t('me.notifComment');
    if (type === 'mention') return t('me.notifMention');
    return t('me.notifLike');
  }

  useEffect(() => {
    void load().then(() => markAllRead());
  }, [load, markAllRead]);

  async function openNotification(item: MeNotification) {
    if (openingId != null) return;
    setOpeningId(item.id);
    try {
      const post = await MeService.getById(item.postId);
      setOpenPost(toMePost(post, formatTime));
    } catch {
      toast.error(t('me.commentLoadError'));
    } finally {
      setOpeningId(null);
    }
  }

  async function toggleReaction(id: string, type: PostReaction) {
    if (openPost == null) return;
    const optimistic = applyMeReaction(openPost, type, meSelfLiker());
    setOpenPost(optimistic);
    const wasActive = type === 'like' ? openPost.liked : openPost.disliked;
    try {
      const updated = wasActive
        ? await MeService.removeReaction(id)
        : await MeService.react(id, type);
      setOpenPost(reconcileMeLikers(toMePost(updated, formatTime), optimistic));
      useMeFeedStore.getState().syncPost(updated);
    } catch {
      setOpenPost(openPost);
    }
  }

  function adjustCommentCount(postId: string, delta: number) {
    setOpenPost((prev) => (prev == null ? prev : { ...prev, comments: prev.comments + delta }));
    useMeFeedStore.getState().adjustCommentCount(postId, delta);
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('me.notifTitle')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#f3f3f3]">
        {loading && items.length === 0 ? (
          <div className="flex justify-center py-10">
            <Spinner size={24} />
          </div>
        ) : items.length === 0 ? (
          <div className="py-16 text-center text-sm text-black/54">{t('me.notifEmpty')}</div>
        ) : (
          <ul>
            {items.map((item) => {
              const icon = TYPE_ICON[item.type];
              const name = item.actor?.fullName || item.actor?.username || '';
              return (
                <li key={item.id} className="bg-white/80">
                  <button
                    type="button"
                    onClick={() => openNotification(item)}
                    className="flex w-full items-start gap-3 p-4 text-left active:bg-black/5"
                  >
                    <Avatar name={name} src={item.actor?.avatar} color={colorForName(name)} />
                    <div className="min-w-0 flex-1">
                      <p className="text-sm leading-snug text-black/87">
                        <span className="font-bold">{name}</span>{' '}
                        {labelFor(item.type)}
                      </p>
                      {item.type === 'comment' && item.preview != null && item.preview !== '' && (
                        <p className="mt-0.5 truncate text-sm text-black/54">{item.preview}</p>
                      )}
                      <div className="mt-1 flex items-center gap-1">
                        {icon != null && (
                          <img src={icon} alt="" className="h-4 w-4 object-contain" />
                        )}
                        <span className="text-xs text-black/45">{formatTime(item.createdAt)}</span>
                      </div>
                    </div>
                    {openingId === item.id && <Spinner size={16} />}
                  </button>
                  <div className="mx-4 h-px bg-black/12" />
                </li>
              );
            })}
          </ul>
        )}
      </div>

      {openPost != null && (
        <MeCommentSheet
          post={openPost}
          onClose={() => setOpenPost(null)}
          onToggleLike={(id) => toggleReaction(id, 'like')}
          onToggleDislike={(id) => toggleReaction(id, 'dislike')}
          onOpenProfile={(nick, color) => setProfileTarget({ username: nick, color })}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          z={60}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget({ username: friend.name, color: friend.color })}
        />
      )}
    </FullScreenOverlay>
  );
}

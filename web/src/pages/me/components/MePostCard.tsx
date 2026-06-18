import { lazy, memo, Suspense, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import moreIcon from '@/assets/icons/me/ic_more.png';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import dislikeIcon from '@/assets/icons/me/ic_dislike_gray.png';
import dislikeIconActive from '@/assets/icons/me/ic_dislike_black.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import likeStickerFly from '@/assets/icons/me/sticker_like.png';
import likeSoundUrl from '@/assets/sounds/like_me.mp3';
import { Avatar } from '@components';
import { DEFAULT_AVATAR_COLOR } from '@lib';
import { PostContent } from './PostContent';
import { MediaGrid } from './MediaGrid';
import { CheckInCard } from './CheckInCard';
import { stickerImage } from '../stickers';
import type { MePost } from '../types';

const MediaViewer = lazy(() => import('./MediaViewer').then((m) => ({ default: m.MediaViewer })));

function popClass(anim: 'in' | 'out' | null): string {
  if (anim === 'in') return 'animate-ola-pop';
  if (anim === 'out') return 'animate-ola-pop-out';
  return '';
}

function playLikeSound() {
  const audio = new Audio(likeSoundUrl);
  audio.play().catch(() => undefined);
}

function formatLikeCount(count: number): string {
  return count > 9 ? '9+' : String(count);
}

interface MePostCardProps {
  post: MePost;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (author: string, color: string) => void;
  onOpenComments?: (id: string, focusInput?: boolean) => void;
  onQuickComment?: (id: string) => void;
  onOpenMenu?: (id: string) => void;
  onOpenLikers?: (id: string) => void;
}

function MePostCardComponent({
  post,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenComments,
  onQuickComment,
  onOpenMenu,
  onOpenLikers,
}: MePostCardProps) {
  const { t } = useTranslation();
  const [viewerIndex, setViewerIndex] = useState<number | null>(null);
  const [likeAnim, setLikeAnim] = useState<'in' | 'out' | null>(null);
  const [dislikeAnim, setDislikeAnim] = useState<'in' | 'out' | null>(null);
  const [fly, setFly] = useState<{ x: number; y: number; id: number } | null>(null);
  const likeIconRef = useRef<HTMLImageElement>(null);
  const flySeq = useRef(0);
  const hasComments = post.comments > 0;
  const hasLikes = post.likes > 0;

  function onCommentIconClick() {
    if (onQuickComment) {
      onQuickComment(post.id);
    } else {
      onOpenComments?.(post.id, true);
    }
  }

  function onLikeClick() {
    const becomingLiked = !post.liked;
    setLikeAnim(becomingLiked ? 'in' : 'out');
    if (becomingLiked) {
      const icon = likeIconRef.current;
      if (icon != null) {
        const rect = icon.getBoundingClientRect();
        flySeq.current += 1;
        setFly({ x: rect.left + rect.width / 2, y: rect.top + rect.height / 2, id: flySeq.current });
      }
      playLikeSound();
    }
    onToggleLike(post.id);
  }

  function onDislikeClick() {
    setDislikeAnim(post.disliked ? 'out' : 'in');
    onToggleDislike(post.id);
  }

  return (
    <article className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div className="flex items-start gap-4 px-4 pt-4">
        <button
          type="button"
          onClick={() => onOpenProfile?.(post.author, post.color)}
          className="flex min-w-0 flex-1 items-start gap-4 text-left"
        >
          <Avatar name={post.author} color={post.color} />
          <span className="min-w-0 flex-1">
            <span className="block truncate text-base text-black/87">{post.author}</span>
            <span className="mt-0.5 block text-xs text-black/54">{post.time}</span>
          </span>
        </button>
        <button
          type="button"
          aria-label={t('me.postMenu')}
          onClick={() => onOpenMenu?.(post.id)}
          className="p-2"
        >
          <img src={moreIcon} alt="" className="h-4 w-4 object-contain" />
        </button>
      </div>

      <PostContent
        content={post.content}
        onMention={(nick) => onOpenProfile?.(nick, DEFAULT_AVATAR_COLOR)}
        leading={
          post.image == null ? undefined : stickerImage(post.image) != null ? (
            <img
              src={stickerImage(post.image) ?? ''}
              alt=""
              className="h-[84px] shrink-0 object-contain"
            />
          ) : (
            <span className="shrink-0 text-5xl leading-none">{post.image}</span>
          )
        }
      />

      {post.checkIn != null && <CheckInCard checkIn={post.checkIn} label={t('me.postMenu')} />}

      {post.photos != null && post.photos.length > 0 && (
        <MediaGrid photos={post.photos} onOpen={setViewerIndex} />
      )}

      {viewerIndex != null && post.photos != null && (
        <Suspense fallback={null}>
          <MediaViewer
            photos={post.photos}
            index={viewerIndex}
            onClose={() => setViewerIndex(null)}
          />
        </Suspense>
      )}

      <div className="mx-4 mt-4 flex items-end gap-1 text-xs text-black/54">
        <button
          type="button"
          disabled={!hasComments}
          onClick={() => onOpenComments?.(post.id)}
          className={`flex-1 text-left ${
            hasComments ? 'cursor-pointer hover:text-black/87 hover:underline' : 'cursor-default'
          }`}
        >
          {t('me.commentCount', { count: post.comments })}
        </button>
        {hasLikes &&
          (onOpenLikers != null ? (
            <button
              type="button"
              onClick={() => onOpenLikers(post.id)}
              className="ml-2 cursor-pointer hover:text-black/87 hover:underline"
            >
              {t('me.likeCount', { value: formatLikeCount(post.likes) })}
            </button>
          ) : (
            <span className="ml-2">{t('me.likeCount', { value: formatLikeCount(post.likes) })}</span>
          ))}
      </div>

      <div className="mx-4 mt-1 h-px bg-black/12" />

      <div className="flex px-4 pt-3 pb-3">
        <button
          type="button"
          onClick={onCommentIconClick}
          className="flex h-7 flex-1 items-center justify-center gap-1 text-sm text-black/26"
        >
          <img src={replyIcon} alt="" className="h-full object-contain" />
          {t('me.comment')}
        </button>
        <button
          type="button"
          onClick={onDislikeClick}
          className={`flex h-7 flex-1 items-center justify-center gap-1 text-sm ${
            post.disliked ? 'text-black/87' : 'text-black/26'
          }`}
        >
          <img
            src={post.disliked ? dislikeIconActive : dislikeIcon}
            alt=""
            onAnimationEnd={() => setDislikeAnim(null)}
            className={`h-full object-contain ${popClass(dislikeAnim)}`}
          />
          {t('me.dislike')}
        </button>
        <button
          type="button"
          onClick={onLikeClick}
          className={`flex h-7 flex-1 items-center justify-center gap-1 text-sm ${
            post.liked ? 'text-ola-primary' : 'text-black/26'
          }`}
        >
          <img
            ref={likeIconRef}
            src={post.liked ? likeIconActive : likeIcon}
            alt=""
            onAnimationEnd={() => setLikeAnim(null)}
            className={`h-full object-contain ${popClass(likeAnim)}`}
          />
          {post.liked ? t('me.liked') : t('me.like')}
        </button>
      </div>

      {fly != null &&
        createPortal(
          <img
            key={fly.id}
            src={likeStickerFly}
            alt=""
            onAnimationEnd={() => setFly(null)}
            style={{ left: fly.x, top: fly.y }}
            className="pointer-events-none fixed z-50 -mt-12 -ml-12 h-24 w-24 animate-ola-fly object-contain"
          />,
          document.body
        )}
    </article>
  );
}

export const MePostCard = memo(MePostCardComponent);

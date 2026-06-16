import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import moreIcon from '@/assets/icons/me/ic_more.png';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import dislikeIcon from '@/assets/icons/me/ic_dislike_gray.png';
import dislikeIconActive from '@/assets/icons/me/ic_dislike_black.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import { Avatar } from '@components';
import { PostContent } from './PostContent';
import { MediaGrid } from './MediaGrid';
import { MediaViewer } from './MediaViewer';
import { CheckInCard } from './CheckInCard';
import { stickerImage } from '../stickers';
import type { MePost } from '../types';

interface MePostCardProps {
  post: MePost;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (author: string, color: string) => void;
  onOpenComments?: (id: string, focusInput?: boolean) => void;
  onQuickComment?: (id: string) => void;
}

export function MePostCard({
  post,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenComments,
  onQuickComment,
}: MePostCardProps) {
  const { t } = useTranslation();
  const [viewerIndex, setViewerIndex] = useState<number | null>(null);
  const hasComments = post.comments > 0;

  function onCommentIconClick() {
    if (onQuickComment) {
      onQuickComment(post.id);
    } else {
      onOpenComments?.(post.id, true);
    }
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
        <button type="button" aria-label={t('me.postMenu')} className="p-2">
          <img src={moreIcon} alt="" className="h-4 w-4 object-contain" />
        </button>
      </div>

      <PostContent
        content={post.content}
        onMention={(nick) => onOpenProfile?.(nick, '#7cb342')}
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
        <MediaViewer
          photos={post.photos}
          index={viewerIndex}
          onClose={() => setViewerIndex(null)}
        />
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
        <span className="flex items-center -space-x-1">
          {post.likers.map((color, index) => (
            <span
              key={index}
              className="inline-block h-5 w-5 rounded-full border border-white"
              style={{ backgroundColor: color }}
            />
          ))}
        </span>
        <span className="ml-2">{t('me.likeCount', { count: post.likes })}</span>
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
          onClick={() => onToggleDislike(post.id)}
          className={`flex h-7 flex-1 items-center justify-center gap-1 text-sm ${
            post.disliked ? 'text-black/87' : 'text-black/26'
          }`}
        >
          <img
            src={post.disliked ? dislikeIconActive : dislikeIcon}
            alt=""
            className="h-full object-contain"
          />
          {t('me.dislike')}
        </button>
        <button
          type="button"
          onClick={() => onToggleLike(post.id)}
          className={`flex h-7 flex-1 items-center justify-center gap-1 text-sm ${
            post.liked ? 'text-ola-primary' : 'text-black/26'
          }`}
        >
          <img
            src={post.liked ? likeIconActive : likeIcon}
            alt=""
            className="h-full object-contain"
          />
          {post.liked ? t('me.liked') : t('me.like')}
        </button>
      </div>
    </article>
  );
}

import { useLayoutEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import moreIcon from '@/assets/icons/me/ic_more.png';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import dislikeIcon from '@/assets/icons/me/ic_dislike_gray.png';
import dislikeIconActive from '@/assets/icons/me/ic_dislike_black.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import { Avatar } from '../../chat/components/Avatar';
import type { MePost } from '../types';

interface MePostCardProps {
  post: MePost;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (author: string, color: string) => void;
}

const TOKEN_PATTERN = /(@[A-Za-z0-9_]+|#[A-Za-z0-9_.]+)/g;

function renderContent(content: string, onMention: (nick: string) => void): ReactNode[] {
  return content.split(TOKEN_PATTERN).map((part, index) => {
    if (part.startsWith('@')) {
      return (
        <button
          key={index}
          type="button"
          onClick={() => onMention(part.slice(1))}
          className="text-ola-primary-darker hover:underline"
        >
          {part}
        </button>
      );
    }
    if (part.startsWith('#')) {
      return (
        <span key={index} className="text-ola-primary-darker">
          {part}
        </span>
      );
    }
    return <span key={index}>{part}</span>;
  });
}

function MediaGrid({ photos }: { photos: string[] }) {
  const shown = photos.slice(0, 5);
  const top = shown.slice(0, 2);
  const bottom = shown.slice(2, 5);
  const extra = photos.length - 5;
  return (
    <div className="mx-4 mt-3 flex flex-col gap-2">
      {top.length > 0 && (
        <div className={`grid gap-2 ${top.length === 1 ? 'grid-cols-1' : 'grid-cols-2'}`}>
          {top.map((url, index) => (
            <img key={index} src={url} alt="" className="h-44 w-full rounded object-cover" />
          ))}
        </div>
      )}
      {bottom.length > 0 && (
        <div className="grid grid-cols-3 gap-2">
          {bottom.map((url, index) => {
            const isLast = index === bottom.length - 1 && extra > 0;
            return (
              <div key={index} className="relative">
                <img src={url} alt="" className="aspect-square w-full rounded object-cover" />
                {isLast && (
                  <div className="absolute inset-0 flex items-center justify-center rounded bg-black/50 text-lg font-medium text-white">
                    +{extra}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

function CheckInCard({ venue, label }: { venue: string; label: string }) {
  return (
    <div className="mx-4 mt-3 flex h-24 items-end overflow-hidden rounded bg-gradient-to-br from-ola-primary to-ola-primary-darker">
      <div className="flex w-full items-center gap-2 bg-black/50 px-3 py-2 text-white">
        <span className="text-lg leading-none">📍</span>
        <span className="flex-1 truncate text-sm">{venue}</span>
        <span aria-label={label} className="text-base text-white/80">
          ›
        </span>
      </div>
    </div>
  );
}

export function MePostCard({
  post,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
}: MePostCardProps) {
  const { t } = useTranslation();
  const contentRef = useRef<HTMLParagraphElement>(null);
  const [expanded, setExpanded] = useState(false);
  const [clamped, setClamped] = useState(false);

  useLayoutEffect(() => {
    const el = contentRef.current;
    if (el == null) return;
    setClamped(el.scrollHeight > el.clientHeight + 1);
  }, [post.content]);

  function openMention(nick: string) {
    onOpenProfile?.(nick, '#7cb342');
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

      <div className="px-4 pt-3">
        <p
          ref={contentRef}
          className={`text-sm leading-relaxed whitespace-pre-wrap text-black/87 ${expanded ? '' : 'line-clamp-5'}`}
        >
          {renderContent(post.content, openMention)}
        </p>
        {clamped && !expanded && (
          <button
            type="button"
            onClick={() => setExpanded(true)}
            className="mt-0.5 text-sm text-ola-primary-dark"
          >
            {t('me.seeMore')}
          </button>
        )}
      </div>

      {post.checkIn != null && post.checkIn !== '' && (
        <CheckInCard venue={post.checkIn} label={t('me.postMenu')} />
      )}

      {post.photos != null && post.photos.length > 0 ? (
        <MediaGrid photos={post.photos} />
      ) : post.image != null ? (
        <div className="mx-4 mt-3 flex h-44 items-center justify-center rounded bg-ola-primary-light text-6xl">
          {post.image}
        </div>
      ) : null}

      <div className="mx-4 mt-4 flex items-end gap-1 text-xs text-black/54">
        <span className="flex-1">
          {t('me.commentCount', { count: post.comments })}
        </span>
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

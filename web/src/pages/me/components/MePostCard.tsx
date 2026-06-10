import { useTranslation } from 'react-i18next';
import moreIcon from '@/assets/icons/me/ic_more.png';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import dislikeIcon from '@/assets/icons/me/ic_dislike_gray.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import { Avatar } from '../../chat/components/Avatar';
import type { MePost } from '../types';

interface MePostCardProps {
  post: MePost;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
}

export function MePostCard({ post, onToggleLike, onToggleDislike }: MePostCardProps) {
  const { t } = useTranslation();
  return (
    <article className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div className="flex items-start gap-4 px-4 pt-4">
        <Avatar name={post.author} color={post.color} />
        <div className="min-w-0 flex-1">
          <p className="truncate text-base text-black/87">{post.author}</p>
          <p className="mt-0.5 text-xs text-black/54">{post.time}</p>
        </div>
        <button type="button" aria-label={t('me.postMenu')} className="p-2">
          <img src={moreIcon} alt="" className="h-4 w-4 object-contain" />
        </button>
      </div>

      <div className="px-4 pt-3">
        <p className="text-sm leading-relaxed text-black/87">{post.content}</p>
      </div>

      {post.image != null && (
        <div className="mx-4 mt-3 flex h-44 items-center justify-center rounded bg-ola-primary-light text-6xl">
          {post.image}
        </div>
      )}

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
            post.disliked ? 'text-ola-error' : 'text-black/26'
          }`}
        >
          <img src={dislikeIcon} alt="" className="h-full object-contain" />
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

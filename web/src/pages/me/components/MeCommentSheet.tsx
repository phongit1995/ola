import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useAuthStore } from '@/store/authStore';
import { MePostCard } from './MePostCard';
import { MeCommentItem } from './MeCommentItem';
import { MeCommentComposer } from './MeCommentComposer';
import { useMeComments } from '../useMeComments';
import { createTimeFormatter } from '../mappers';
import type { MePost } from '../types';

interface MeCommentSheetProps {
  post: MePost;
  autoFocusInput?: boolean;
  onClose: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onCommentDelta: (postId: string, delta: number) => void;
}

const CLOSE_ANIMATION_MS = 200;

export function MeCommentSheet({
  post,
  autoFocusInput = false,
  onClose,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onCommentDelta,
}: MeCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const me = useAuthStore((state) => state.user);
  const [shown, setShown] = useState(false);

  const { comments, total, loading, error, submitting, add, remove } = useMeComments(post.id, {
    onDelta: (delta) => onCommentDelta(post.id, delta),
  });

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    const id = requestAnimationFrame(() => setShown(true));
    return () => cancelAnimationFrame(id);
  }, []);

  function handleClose() {
    setShown(false);
    window.setTimeout(onClose, CLOSE_ANIMATION_MS);
  }

  return (
    <div className="fixed inset-0 z-50 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={handleClose}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">
          {t('me.commentsTitle')}
          {total > 0 ? ` (${total})` : ''}
        </span>
      </header>

      <div
        className={`flex min-h-0 flex-1 flex-col bg-[#eceff1] transition-transform duration-200 ${
          shown ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        <div className="min-h-0 flex-1 overflow-y-auto">
          <MePostCard
            post={post}
            onToggleLike={onToggleLike}
            onToggleDislike={onToggleDislike}
            onOpenProfile={onOpenProfile}
          />

          <div className="py-2">
            {loading && (
              <div className="py-8 text-center text-sm text-black/54">{t('common.loading')}</div>
            )}
            {!loading && error && (
              <div className="py-8 text-center text-sm text-ola-error">
                {t('me.commentLoadError')}
              </div>
            )}
            {!loading && !error && comments.length === 0 && (
              <div className="py-8 text-center text-sm text-black/54">{t('me.commentEmpty')}</div>
            )}
            {!loading &&
              !error &&
              comments.map((comment) => (
                <MeCommentItem
                  key={comment.id}
                  comment={comment}
                  time={formatTime(comment.createdAt)}
                  canDelete={me != null && comment.author?.id === me.id}
                  onDelete={remove}
                  onOpenProfile={onOpenProfile}
                />
              ))}
          </div>
        </div>

        <MeCommentComposer submitting={submitting} onSubmit={add} autoFocus={autoFocusInput} />
      </div>
    </div>
  );
}

import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useAuthStore } from '@/store/authStore';
import { MePostCard } from './MePostCard';
import { MeCommentItem } from './MeCommentItem';
import { MeCommentComposer } from './MeCommentComposer';
import { useMeComments } from '../useMeComments';
import { createTimeFormatter } from '@lib';
import { ScreenHeader, FullScreenOverlay, Spinner } from '@components';
import type { MePost } from '../types';
import { CLOSE_ANIMATION_MS } from '../constants';

interface MeCommentSheetProps {
  post: MePost;
  autoFocusInput?: boolean;
  onClose: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onOpenLikers?: (id: string) => void;
  onCommentDelta: (postId: string, delta: number) => void;
}

export function MeCommentSheet({
  post,
  autoFocusInput = false,
  onClose,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenLikers,
  onCommentDelta,
}: MeCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const me = useAuthStore((state) => state.user);
  const [shown, setShown] = useState(false);

  const handleCommentDelta = useCallback(
    (delta: number) => onCommentDelta(post.id, delta),
    [onCommentDelta, post.id]
  );

  const {
    comments,
    total,
    loading,
    error,
    submitting,
    add,
    remove,
    like,
    replyTarget,
    setReplyTarget,
  } = useMeComments(post.id, { onDelta: handleCommentDelta });

  const replyingToUsername =
    replyTarget != null ? replyTarget.author?.username ?? null : null;

  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  useEffect(() => {
    const id = requestAnimationFrame(() => setShown(true));
    return () => cancelAnimationFrame(id);
  }, []);

  function handleClose() {
    setShown(false);
    window.setTimeout(onClose, CLOSE_ANIMATION_MS);
  }

  return (
    <FullScreenOverlay z={50}>
      <ScreenHeader
        title={`${t('me.commentsTitle')}${total > 0 ? ` (${total})` : ''}`}
        onBack={handleClose}
      />

      <div
        className={`flex min-h-0 flex-1 flex-col bg-ola-surface-cool transition-transform duration-200 ${
          shown ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        <div className="min-h-0 flex-1 overflow-y-auto">
          <MePostCard
            post={post}
            onToggleLike={onToggleLike}
            onToggleDislike={onToggleDislike}
            onOpenProfile={onOpenProfile}
            onOpenLikers={onOpenLikers}
          />

          <div className="py-2">
            {loading && (
              <div className="flex justify-center py-8">
                <Spinner size={24} />
              </div>
            )}
            {!loading && error && (
              <div className="py-8 text-center text-sm text-ola-error">
                {t('me.commentLoadError')}
              </div>
            )}
            {!loading && !error && comments.length === 0 && (
              <div className="py-8 text-center text-sm text-black/54">
                {t('me.commentEmpty')}
              </div>
            )}
            {!loading &&
              !error &&
              comments.map((comment) => {
                const isOwn = me != null && comment.author?.id === me.id;
                return (
                  <MeCommentItem
                    key={comment.id}
                    comment={comment}
                    time={formatTime(comment.createdAt)}
                    canDelete={isOwn}
                    canReport={!isOwn}
                    onDelete={remove}
                    onReply={isOwn ? undefined : setReplyTarget}
                    onToggleLike={like}
                    onOpenProfile={onOpenProfile}
                  />
                );
              })}
          </div>
        </div>

        <MeCommentComposer
          key={replyTarget?.id ?? 'root'}
          submitting={submitting}
          onSubmit={add}
          autoFocus={autoFocusInput}
          initialDraft={
            replyingToUsername != null ? `@${replyingToUsername} ` : ''
          }
          replyingTo={replyingToUsername}
          onCancelReply={() => setReplyTarget(null)}
        />
      </div>
    </FullScreenOverlay>
  );
}

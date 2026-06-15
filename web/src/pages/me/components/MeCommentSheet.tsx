import { useEffect, useMemo, useRef, useState, type KeyboardEvent } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '../../chat/components/Avatar';
import { MePostCard } from './MePostCard';
import { MeCommentItem } from './MeCommentItem';
import { ComposerSmileyPanel } from './ComposerSmileyPanel';
import { useMeComments } from '../useMeComments';
import { createTimeFormatter, colorFromName } from '../mappers';
import type { MePost } from '../types';

interface MeCommentSheetProps {
  post: MePost;
  onClose: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onCommentDelta: (postId: string, delta: number) => void;
}

const CLOSE_ANIMATION_MS = 200;

export function MeCommentSheet({
  post,
  onClose,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onCommentDelta,
}: MeCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const me = useAuthStore((state) => state.user);
  const [shown, setShown] = useState(false);
  const [draft, setDraft] = useState('');
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<HTMLTextAreaElement>(null);

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

  function insertSmiley(code: string) {
    const token = `${code} `;
    const el = inputRef.current;
    setDraft((current) => {
      if (el == null) return current + token;
      const at = el.selectionStart ?? current.length;
      return current.slice(0, at) + token + current.slice(at);
    });
  }

  async function submit() {
    const ok = await add(draft);
    if (ok) {
      setDraft('');
      setSmileyOpen(false);
    }
  }

  function onInputKeyDown(event: KeyboardEvent<HTMLTextAreaElement>) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      submit();
    }
  }

  const myName = me?.username ?? t('home.guest');

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

        {smileyOpen && (
          <div className="border-t border-black/12 bg-white px-2">
            <ComposerSmileyPanel onPick={insertSmiley} />
          </div>
        )}

        <div className="flex shrink-0 items-end gap-2 border-t border-black/12 bg-white px-3 py-2">
          <Avatar name={myName} color={colorFromName(myName)} size={36} />
          <textarea
            ref={inputRef}
            value={draft}
            onChange={(event) => setDraft(event.target.value)}
            onKeyDown={onInputKeyDown}
            placeholder={t('me.commentInputHint')}
            rows={1}
            className="max-h-28 min-h-9 flex-1 resize-none rounded-2xl border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
          />
          <button
            type="button"
            aria-label={t('chat.attachTabSmiley')}
            onClick={() => setSmileyOpen((open) => !open)}
            className="flex h-9 w-9 shrink-0 items-center justify-center"
          >
            <img src={smileyIcon} alt="" className="h-6 w-6 object-contain" />
          </button>
          <button
            type="button"
            onClick={submit}
            disabled={submitting || draft.trim() === ''}
            className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-medium text-white disabled:opacity-40"
          >
            {t('me.commentSend')}
          </button>
        </div>
      </div>
    </div>
  );
}

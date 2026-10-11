import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import {
  ComposerSmileyPanel,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import { useOutsideClick } from '@hooks';
import { cn, toApiError, toast } from '@lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../interface';

const HTTP_TOO_MANY_REQUESTS = 429;

interface StoryCommentComposerProps {
  storyId: string;
  palette: ReaderPalette;
  replyTarget: StoryComment | null;
  onCancelReply: () => void;
  onSent: () => void;
}

export function StoryCommentComposer({
  storyId,
  palette,
  replyTarget,
  onCancelReply,
  onSent,
}: StoryCommentComposerProps) {
  const { t } = useTranslation();
  const access = useStoryStore(
    (state) => state.storyAccess[storyId] ?? state.stories[storyId]?.access
  );
  const send = useStoryCommentStore((state) => state.send);
  const [draft, setDraft] = useState('');
  const [sending, setSending] = useState(false);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<SmileyInputHandle>(null);
  const areaRef = useRef<HTMLDivElement>(null);
  const content = draft.trim();
  const length = [...content].length;
  const needsUnlock =
    access != null && access.enabled && !access.vip && !access.unlocked;

  useOutsideClick(areaRef, smileyOpen, () => setSmileyOpen(false));

  useEffect(() => {
    if (replyTarget) inputRef.current?.focus();
  }, [replyTarget]);

  async function submit() {
    if (content === '' || sending) return;
    setSending(true);
    try {
      const result = await send(storyId, content, replyTarget?.id);
      setDraft('');
      setSmileyOpen(false);
      onSent();
      if (result.unlocked && needsUnlock) {
        toast.success(t('story.commentUnlocked'));
      }
    } catch (error) {
      toast.error(
        t(
          toApiError(error).status === HTTP_TOO_MANY_REQUESTS
            ? 'story.commentRateLimited'
            : 'story.commentSendError'
        )
      );
    } finally {
      setSending(false);
    }
  }

  return (
    <div
      ref={areaRef}
      className="shrink-0 border-t font-sans"
      style={{ borderColor: palette.border }}
    >
      {replyTarget && (
        <div
          className="flex items-center gap-2 px-4 pt-2 text-xs"
          style={{ color: palette.muted }}
        >
          <span className="min-w-0 flex-1 truncate">
            {t('story.commentReplyingTo', {
              name:
                replyTarget.author?.fullName ||
                replyTarget.author?.username ||
                '',
            })}
          </span>
          <button
            type="button"
            onClick={onCancelReply}
            className="shrink-0 font-medium text-ola-primary-ink"
          >
            {t('story.commentCancelReply')}
          </button>
        </div>
      )}
      {needsUnlock && (
        <div
          className="flex items-start gap-2 px-4 pt-2 text-xs leading-5"
          style={{ color: palette.muted }}
        >
          <span className="min-w-0 flex-1">
            {t('story.commentUnlockHint', { count: access.commentMinChars })}
          </span>
          <span
            className={cn(
              'shrink-0 tabular-nums',
              length >= access.commentMinChars &&
                'font-semibold text-ola-primary-ink'
            )}
          >
            {length}/{access.commentMinChars}
          </span>
        </div>
      )}
      <div className="flex items-end gap-2 px-3 py-2">
        <SmileyInput
          ref={inputRef}
          value={draft}
          onChange={setDraft}
          onEnter={submit}
          placeholder={t('story.commentPlaceholder')}
          multiline
          className="max-h-28 min-h-9 flex-1 overflow-y-auto rounded-2xl border border-black/12 bg-white px-3 py-2 text-base text-black/87 focus:border-ola-primary"
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
          disabled={sending || content === ''}
          className="h-9 shrink-0 rounded-full bg-ola-button px-4 text-sm font-medium text-ola-on-primary disabled:opacity-40"
        >
          {t('story.commentSend')}
        </button>
      </div>
      {smileyOpen && (
        <div className="border-t border-black/12 bg-white">
          <ComposerSmileyPanel
            onPick={(code) => inputRef.current?.insertCode(code, true)}
          />
        </div>
      )}
    </div>
  );
}

import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import {
  ComposerSmileyPanel,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import { MOMENT_COMMENT_MAX_CHARS } from '@constants';
import { isMomentCommentTooLong, toast } from '@lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { MomentSendIcon } from './MomentIcons';

interface MomentCommentSheetProps {
  momentId: string;
  onClose: () => void;
}

export function MomentCommentSheet({
  momentId,
  onClose,
}: MomentCommentSheetProps) {
  const { t } = useTranslation();
  const comment = useMomentStore((s) => s.comment);
  const [draft, setDraft] = useState('');
  const [sending, setSending] = useState(false);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<SmileyInputHandle>(null);
  const openRef = useRef(true);

  useEffect(() => {
    openRef.current = true;
    inputRef.current?.focus();
    return () => {
      openRef.current = false;
    };
  }, []);

  useEffect(() => {
    function handleKey(event: KeyboardEvent) {
      if (event.key === 'Escape') onClose();
    }
    document.addEventListener('keydown', handleKey);
    return () => document.removeEventListener('keydown', handleKey);
  }, [onClose]);

  async function submit() {
    if (sending || draft.trim() === '') return;
    if (isMomentCommentTooLong(draft)) {
      toast.error(
        t('moment.commentTooLong', { max: MOMENT_COMMENT_MAX_CHARS })
      );
      return;
    }
    setSending(true);
    try {
      const created = await comment(momentId, draft);
      if (!created) toast.info(t('moment.commentAlready'));
      if (openRef.current) onClose();
    } catch {
      toast.error(t('moment.commentFailed'));
    } finally {
      setSending(false);
    }
  }

  return (
    <div
      role="presentation"
      onClick={(event) => {
        if (event.target === event.currentTarget) onClose();
      }}
      className="absolute inset-0 z-20 flex flex-col justify-end bg-black/60 select-text"
    >
      <div
        role="dialog"
        aria-label={t('moment.comments')}
        className="w-full bg-gradient-to-t from-black via-black/90 to-transparent px-3 pt-10 pb-3"
      >
        <div className="mx-auto w-full max-w-md">
          <p className="px-1 pb-2 text-xs text-white/70">
            {t('moment.commentOnce')}
          </p>
          <div className="flex items-end gap-2">
            <div className="flex min-w-0 flex-1 items-end rounded-3xl border border-white/40 bg-white/10 pr-1 pl-4 focus-within:border-white/70">
              <SmileyInput
                ref={inputRef}
                value={draft}
                onChange={setDraft}
                onEnter={submit}
                placeholder={t('moment.commentPlaceholder')}
                multiline
                className="max-h-28 min-h-11 min-w-0 flex-1 overflow-y-auto py-2.5 text-base text-white caret-white empty:before:text-white/60!"
              />
              <button
                type="button"
                aria-label={t('chat.attachTabSmiley')}
                aria-pressed={smileyOpen}
                onClick={() => setSmileyOpen((open) => !open)}
                className="flex h-11 w-10 shrink-0 items-center justify-center"
              >
                <img
                  src={smileyIcon}
                  alt=""
                  className="h-6 w-6 object-contain opacity-85 brightness-0 invert"
                />
              </button>
            </div>
            <button
              type="button"
              aria-label={t('me.commentSend')}
              onClick={() => void submit()}
              disabled={sending || draft.trim() === ''}
              className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-ola-primary text-ola-on-primary transition-opacity disabled:opacity-40"
            >
              <MomentSendIcon className="h-5 w-5 -translate-x-px translate-y-px" />
            </button>
          </div>
          {smileyOpen && (
            <div className="mt-2 overflow-hidden rounded-2xl bg-white">
              <ComposerSmileyPanel
                onPick={(code) => inputRef.current?.insertCode(code, true)}
              />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar, ComposerSmileyPanel, SmileyInput, type SmileyInputHandle } from '@components';
import { useOutsideClick } from '@hooks';
import { colorForName } from '@lib';

interface MeCommentComposerProps {
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  autoFocus?: boolean;
  initialDraft?: string;
  replyingTo?: string | null;
  onCancelReply?: () => void;
}

export function MeCommentComposer({
  submitting,
  onSubmit,
  autoFocus = false,
  initialDraft = '',
  replyingTo,
  onCancelReply,
}: MeCommentComposerProps) {
  const { t } = useTranslation();
  const me = useAuthStore((state) => state.user);
  const [draft, setDraft] = useState(initialDraft);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const composerRef = useRef<SmileyInputHandle>(null);
  const areaRef = useRef<HTMLDivElement>(null);

  useOutsideClick(areaRef, smileyOpen, () => setSmileyOpen(false));

  useEffect(() => {
    if (autoFocus || initialDraft !== '') composerRef.current?.focus();
  }, [autoFocus, initialDraft]);

  function insertSmiley(code: string) {
    composerRef.current?.insertCode(code, true);
  }

  async function submit() {
    const ok = await onSubmit(draft);
    if (ok) {
      setDraft('');
      setSmileyOpen(false);
    }
  }

  const myName = me?.username ?? t('home.guest');

  return (
    <div ref={areaRef}>
      {replyingTo != null && replyingTo !== '' && (
        <div className="flex items-center gap-2 border-t border-black/12 bg-[#eceff1] px-4 py-1.5 text-xs text-black/54">
          <span className="min-w-0 flex-1 truncate">
            {t('me.replyingTo', { name: `@${replyingTo}` })}
          </span>
          <button
            type="button"
            aria-label={t('me.cancelReply')}
            onClick={onCancelReply}
            className="shrink-0 rounded-full p-1 text-black/45 hover:text-ola-error"
          >
            <svg viewBox="0 0 24 24" className="h-3.5 w-3.5" fill="none" stroke="currentColor" strokeWidth="2.5" aria-hidden="true">
              <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
            </svg>
          </button>
        </div>
      )}
      <div className="flex shrink-0 items-end gap-2 border-t border-black/12 bg-white px-3 py-2">
        <Avatar name={myName} src={me?.avatar} color={colorForName(myName)} size={36} />
        <SmileyInput
          ref={composerRef}
          value={draft}
          onChange={setDraft}
          onEnter={submit}
          placeholder={t('me.commentInputHint')}
          multiline
          className="max-h-28 min-h-9 flex-1 overflow-y-auto rounded-2xl border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary"
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

      {smileyOpen && (
        <div className="border-t border-black/12 bg-white">
          <ComposerSmileyPanel onPick={insertSmiley} />
        </div>
      )}
    </div>
  );
}

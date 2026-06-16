import { useEffect, useRef, useState, type KeyboardEvent } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '@components';
import { ComposerSmileyPanel } from '@components';
import { colorForName, insertAtCursor } from '@lib';

interface MeCommentComposerProps {
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  autoFocus?: boolean;
}

export function MeCommentComposer({ submitting, onSubmit, autoFocus = false }: MeCommentComposerProps) {
  const { t } = useTranslation();
  const me = useAuthStore((state) => state.user);
  const [draft, setDraft] = useState('');
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    if (autoFocus) inputRef.current?.focus();
  }, [autoFocus]);

  function insertSmiley(code: string) {
    setDraft((current) => insertAtCursor(current, `${code} `, inputRef.current));
  }

  async function submit() {
    const ok = await onSubmit(draft);
    if (ok) {
      setDraft('');
      setSmileyOpen(false);
    }
  }

  function onKeyDown(event: KeyboardEvent<HTMLTextAreaElement>) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      submit();
    }
  }

  const myName = me?.username ?? t('home.guest');

  return (
    <>
      {smileyOpen && (
        <div className="border-t border-black/12 bg-white px-2">
          <ComposerSmileyPanel onPick={insertSmiley} />
        </div>
      )}

      <div className="flex shrink-0 items-end gap-2 border-t border-black/12 bg-white px-3 py-2">
        <Avatar name={myName} color={colorForName(myName)} size={36} />
        <textarea
          ref={inputRef}
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          onKeyDown={onKeyDown}
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
    </>
  );
}

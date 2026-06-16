import { useEffect, useRef, useState, type KeyboardEvent } from 'react';
import { useTranslation } from 'react-i18next';
import type { RoomMessage } from '@app-types';
import { colorForName, insertAtCursor, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '@components';
import { ComposerSmileyPanel } from '../../me/components/ComposerSmileyPanel';
import { buildRoomFeed } from '../messageGroups';
import { RoomDateSeparator } from './RoomDateSeparator';
import { RoomMessageGroup } from './RoomMessageGroup';
import type { RoomChatStatus } from '@/store/roomChatStore';

interface RoomMessagesTabProps {
  currentUserId: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  active: boolean;
  onSend: (content: string) => Promise<void>;
  onOpenProfile?: (nick: string, color: string) => void;
}

export function RoomMessagesTab({
  currentUserId,
  messages,
  status,
  active,
  onSend,
  onOpenProfile,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();
  const me = useAuthStore((state) => state.user);

  const [draft, setDraft] = useState('');
  const [smileyOpen, setSmileyOpen] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    if (!active) return;
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [messages, active]);

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || status !== 'joined') return;
    setDraft('');
    setSmileyOpen(false);
    try {
      await onSend(trimmed);
    } catch {
      setDraft(trimmed);
      toast.error(t('room.sendError'));
    }
  }

  function insertSmiley(code: string) {
    setDraft((current) => insertAtCursor(current, `${code} `, inputRef.current));
    inputRef.current?.focus();
  }

  function insertMention(name: string) {
    const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
    setDraft((current) =>
      alreadyTagged.test(current) ? current : insertAtCursor(current, `@${name} `, inputRef.current)
    );
    inputRef.current?.focus();
  }

  function onKeyDown(event: KeyboardEvent<HTMLTextAreaElement>) {
    if (event.key === 'Enter' && !event.shiftKey && !event.nativeEvent.isComposing) {
      event.preventDefault();
      sendText(draft);
    }
  }

  const canSend = status === 'joined';
  const myName = me?.username ?? t('home.guest');

  return (
    <div className={`flex flex-1 flex-col overflow-hidden ${active ? '' : 'hidden'}`}>
      {status !== 'joined' && (
        <div className="bg-black/5 py-1.5 text-center text-sm text-black/54">
          {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
        </div>
      )}

      <div ref={scrollRef} className="flex flex-1 flex-col gap-2 overflow-y-auto p-3">
        {buildRoomFeed(messages, currentUserId).map((item) =>
          item.kind === 'date' ? (
            <RoomDateSeparator key={item.key} iso={item.createdAt} />
          ) : (
            <RoomMessageGroup
              key={item.key}
              group={item}
              onOpenProfile={onOpenProfile}
              onQuickMention={insertMention}
            />
          )
        )}
      </div>

      {smileyOpen && (
        <div className="border-t border-black/12 bg-white px-2">
          <ComposerSmileyPanel onPick={insertSmiley} />
        </div>
      )}

      <div className="flex shrink-0 items-end gap-2 border-t border-black/12 bg-white px-3 py-2">
        {me?.avatar != null && me.avatar !== '' ? (
          <img src={me.avatar} alt="" className="h-9 w-9 shrink-0 rounded-full object-cover" />
        ) : (
          <Avatar name={myName} color={colorForName(myName)} size={36} />
        )}
        <textarea
          ref={inputRef}
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          onKeyDown={onKeyDown}
          onFocus={() => setSmileyOpen(false)}
          disabled={!canSend}
          placeholder={t('room.chatInputHint')}
          rows={1}
          className="max-h-28 min-h-9 flex-1 resize-none rounded-2xl border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary disabled:opacity-50"
        />
        <button
          type="button"
          aria-label={t('chat.attachTabSmiley')}
          disabled={!canSend}
          onClick={() => setSmileyOpen((open) => !open)}
          className="flex h-9 w-9 shrink-0 items-center justify-center disabled:opacity-50"
        >
          <span className="text-2xl leading-none">😀</span>
        </button>
        <button
          type="button"
          onClick={() => sendText(draft)}
          disabled={!canSend || draft.trim() === ''}
          className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-medium text-white disabled:opacity-40"
        >
          {t('chat.send')}
        </button>
      </div>
    </div>
  );
}

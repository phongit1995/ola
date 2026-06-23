import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { RoomMessage } from '@app-types';
import { colorForName, kulToken, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { useLongPress } from '@hooks';
import {
  AttachmentBar,
  type AttachTab,
  Avatar,
  DateSeparator,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import { buildRoomFeed } from '../messageGroups';
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
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const draftRef = useRef(draft);
  const stickToBottomRef = useRef(true);
  const suppressLikeClick = useRef(false);
  const likeLongPress = useLongPress(() => {
    suppressLikeClick.current = true;
    void sendText('(Y)');
  });

  useEffect(() => {
    draftRef.current = draft;
  }, [draft]);

  useEffect(() => {
    if (!active) return;
    if (stickToBottomRef.current) {
      scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
    }
  }, [messages, active]);

  function handleScroll() {
    const element = scrollRef.current;
    if (element == null) return;
    const distanceFromBottom = element.scrollHeight - element.scrollTop - element.clientHeight;
    stickToBottomRef.current = distanceFromBottom < 80;
  }

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || status !== 'joined') return;
    stickToBottomRef.current = true;
    setDraft('');
    setOpenTab(null);
    try {
      await onSend(trimmed);
    } catch {
      setDraft(trimmed);
      toast.error(t('room.sendError'));
    }
  }

  const insertMention = useCallback((name: string) => {
    const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
    if (!alreadyTagged.test(draftRef.current)) composerRef.current?.insertText(`@${name} `);
    composerRef.current?.focus();
  }, []);

  const canSend = status === 'joined';
  const isTyping = draft.trim() !== '';
  const myName = me?.username ?? t('home.guest');
  const feed = useMemo(() => buildRoomFeed(messages, currentUserId), [messages, currentUserId]);

  return (
    <div className={`flex flex-1 flex-col overflow-hidden ${active ? '' : 'hidden'}`}>
      {status !== 'joined' && (
        <div className="bg-black/5 py-1.5 text-center text-sm text-black/54">
          {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
        </div>
      )}

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        className="flex flex-1 flex-col gap-2 overflow-y-auto p-3"
      >
        {feed.map((item) =>
          item.kind === 'date' ? (
            <DateSeparator key={item.key} iso={item.createdAt} />
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

      <div className="flex shrink-0 items-end gap-2 border-t border-black/12 bg-white px-3 py-2">
        {me?.avatar != null && me.avatar !== '' ? (
          <img src={me.avatar} alt="" className="h-9 w-9 shrink-0 rounded-full object-cover" />
        ) : (
          <Avatar name={myName} color={colorForName(myName)} size={36} />
        )}
        <SmileyInput
          ref={composerRef}
          value={draft}
          onChange={setDraft}
          onEnter={() => sendText(draft)}
          onFocus={() => setOpenTab(null)}
          disabled={!canSend}
          placeholder={t('room.chatInputHint')}
          multiline
          className={`max-h-28 min-h-9 flex-1 overflow-y-auto rounded-2xl border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary ${
            canSend ? '' : 'opacity-50'
          }`}
        />
        {isTyping ? (
          <button
            type="button"
            onClick={() => sendText(draft)}
            disabled={!canSend}
            className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-semibold text-white shadow-sm transition active:scale-95 disabled:opacity-40"
          >
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            disabled={!canSend}
            {...likeLongPress}
            onPointerDown={(event) => {
              suppressLikeClick.current = false;
              likeLongPress.onPointerDown(event);
            }}
            onClick={() => {
              if (suppressLikeClick.current) {
                suppressLikeClick.current = false;
                return;
              }
              void sendText('(y)');
            }}
            className="flex h-9 w-9 shrink-0 select-none items-center justify-center disabled:opacity-40"
          >
            <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
          </button>
        )}
      </div>

      {canSend && (
        <AttachmentBar
          tabs={['smiley', 'kul']}
          openTab={openTab}
          onToggleTab={(tab) => setOpenTab((current) => (current === tab ? null : tab))}
          onPickEmoji={(code) => composerRef.current?.insertCode(code)}
          onBackspace={() => composerRef.current?.backspace()}
          onPickImage={() => undefined}
          onSendKul={(index) => {
            void sendText(kulToken(index));
            setOpenTab(null);
          }}
          onSend={() => undefined}
        />
      )}
    </div>
  );
}

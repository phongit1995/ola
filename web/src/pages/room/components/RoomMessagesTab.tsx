import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import type { RoomMessage } from '@app-types';
import { Avatar } from '../../chat/components/Avatar';
import { AttachmentBar, type AttachTab } from '../../chat/components/AttachmentBar';
import { colorForName } from '../avatarColor';
import type { RoomChatStatus } from '@/store/roomChatStore';

interface RoomMessagesTabProps {
  roomName: string;
  currentUserId: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  active: boolean;
  onSend: (content: string) => Promise<void>;
}

export function RoomMessagesTab({
  roomName,
  currentUserId,
  messages,
  status,
  active,
  onSend,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();

  const [draft, setDraft] = useState('');
  const [attachOpen, setAttachOpen] = useState(false);
  const [attachTab, setAttachTab] = useState<AttachTab>('smiley');
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!active) return;
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [messages, active]);

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || status !== 'joined') return;
    setDraft('');
    try {
      await onSend(trimmed);
    } catch {
      setDraft(trimmed);
    }
  }

  const isTyping = draft.trim() !== '';
  const canSend = status === 'joined';

  return (
    <div className={`flex flex-1 flex-col overflow-hidden ${active ? '' : 'hidden'}`}>
      {status !== 'joined' && (
        <div className="bg-black/5 py-1.5 text-center text-sm text-black/54">
          {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
        </div>
      )}

      <div ref={scrollRef} className="flex flex-1 flex-col gap-3 overflow-y-auto p-3">
        {messages.map((message) => {
          if (message.senderId === currentUserId) {
            return (
              <div
                key={message.id}
                className="max-w-[80%] self-end rounded-lg bg-[#dcedc8] px-3 py-2 text-base text-black/87"
              >
                {message.content}
              </div>
            );
          }
          const senderName = message.senderName ?? message.senderId;
          return (
            <div key={message.id} className="flex max-w-[85%] items-start gap-2 self-start">
              <Avatar name={senderName} color={colorForName(senderName)} size={32} />
              <div className="min-w-0">
                <span className="mb-0.5 block text-xs text-black/54">{senderName}</span>
                <div className="rounded-lg bg-white px-3 py-2 text-base text-black/87 shadow-sm">
                  {message.content}
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <form
        onSubmit={(event) => {
          event.preventDefault();
          sendText(draft);
        }}
        className="flex items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
      >
        <button
          type="button"
          aria-label={t('chat.attachTabSmiley')}
          onClick={() => {
            setAttachTab('smiley');
            setAttachOpen((open) => !open);
          }}
          className="flex h-9 w-9 shrink-0 items-center justify-center"
        >
          <img
            src={attachOpen ? smileyIconActive : smileyIcon}
            alt=""
            className="h-6 w-6 object-contain"
          />
        </button>
        <input
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          onFocus={() => setAttachOpen(false)}
          disabled={!canSend}
          placeholder={t('room.chatInputHint', { name: roomName })}
          className="min-h-9 flex-1 bg-transparent px-2 text-base text-black/87 outline-none placeholder:text-black/38 disabled:opacity-50"
        />
        {isTyping ? (
          <button
            type="submit"
            disabled={!canSend}
            className="min-w-12 px-2 text-base font-medium text-ola-primary disabled:opacity-50"
          >
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            disabled={!canSend}
            onClick={() => sendText('👍')}
            className="flex h-9 w-9 items-center justify-center disabled:opacity-50"
          >
            <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
          </button>
        )}
      </form>

      {attachOpen && (
        <AttachmentBar
          activeTab={attachTab}
          onTabChange={setAttachTab}
          onPickEmoji={(emoji) => setDraft((current) => current + emoji)}
          onClose={() => setAttachOpen(false)}
        />
      )}
    </div>
  );
}

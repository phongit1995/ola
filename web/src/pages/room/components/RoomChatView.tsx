import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import { Avatar } from '../../chat/components/Avatar';
import { AttachmentBar, type AttachTab } from '../../chat/components/AttachmentBar';
import type { ChatMessage, Contact } from '../../chat/types';

interface RoomChatViewProps {
  name: string;
  color: string;
  seedMessage?: string;
  members: Contact[];
  onClose: () => void;
}

const AUTO_REPLIES = [
  'Chào cả phòng 👋',
  'Phòng mình vui ghê 😄',
  'Ai ở Sài Gòn điểm danh nào!',
  'Loa loa, nghe nhạc không mọi người 🎧',
  'Hôm nay trời đẹp thật 🌤️',
];

let roomMessageSeed = 0;
function nextMessageId() {
  roomMessageSeed += 1;
  return `r${roomMessageSeed}`;
}

function pickMember(members: Contact[]): Contact | undefined {
  if (members.length === 0) return undefined;
  return members[Math.floor(Math.random() * members.length)];
}

export function RoomChatView({
  name,
  color,
  seedMessage,
  members,
  onClose,
}: RoomChatViewProps) {
  const { t } = useTranslation();

  const [messages, setMessages] = useState<ChatMessage[]>(() => {
    if (seedMessage == null) return [];
    const sender = pickMember(members);
    return [
      {
        id: nextMessageId(),
        text: seedMessage,
        direction: 'in',
        senderName: sender?.name,
        senderColor: sender?.color,
      },
    ];
  });
  const [draft, setDraft] = useState('');
  const [attachOpen, setAttachOpen] = useState(false);
  const [attachTab, setAttachTab] = useState<AttachTab>('smiley');
  const [membersOpen, setMembersOpen] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [messages]);

  function appendBroadcast() {
    const sender = pickMember(members);
    const text = AUTO_REPLIES[Math.floor(Math.random() * AUTO_REPLIES.length)];
    setMessages((current) => [
      ...current,
      {
        id: nextMessageId(),
        text,
        direction: 'in',
        senderName: sender?.name,
        senderColor: sender?.color,
      },
    ]);
  }

  function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    setMessages((current) => [
      ...current,
      { id: nextMessageId(), text: trimmed, direction: 'out' },
    ]);
    setDraft('');
    window.setTimeout(appendBroadcast, 900);
  }

  const isTyping = draft.trim() !== '';

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={onClose}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <Avatar name={name} color={color} size={32} />
        <span className="min-w-0 flex-1">
          <span className="block truncate text-base leading-tight font-medium">{name}</span>
          <span className="block truncate text-xs leading-tight text-white/80">
            {t('room.memberCount', { count: members.length })}
          </span>
        </span>
        <button
          type="button"
          aria-label={t('room.membersTitle')}
          onClick={() => setMembersOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor" aria-hidden="true">
            <path d="M16 11c1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3zm-8 0c1.66 0 3-1.34 3-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" />
          </svg>
        </button>
      </header>

      <div ref={scrollRef} className="flex flex-1 flex-col gap-3 overflow-y-auto p-3">
        {messages.map((message) =>
          message.direction === 'out' ? (
            <div
              key={message.id}
              className="max-w-[80%] self-end rounded-lg bg-[#dcedc8] px-3 py-2 text-base text-black/87"
            >
              {message.text}
            </div>
          ) : (
            <div key={message.id} className="flex max-w-[85%] items-start gap-2 self-start">
              <Avatar
                name={message.senderName ?? name}
                color={message.senderColor ?? color}
                size={32}
              />
              <div className="min-w-0">
                <span className="mb-0.5 block text-xs text-black/54">
                  {message.senderName ?? name}
                </span>
                <div className="rounded-lg bg-white px-3 py-2 text-base text-black/87 shadow-sm">
                  {message.text}
                </div>
              </div>
            </div>
          )
        )}
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
          placeholder={t('room.chatInputHint', { name })}
          className="min-h-9 flex-1 bg-transparent px-2 text-base text-black/87 outline-none placeholder:text-black/38"
        />
        {isTyping ? (
          <button
            type="submit"
            className="min-w-12 px-2 text-base font-medium text-ola-primary"
          >
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            onClick={() => sendText('👍')}
            className="flex h-9 w-9 items-center justify-center"
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

      {membersOpen && (
        <div
          role="presentation"
          onClick={() => setMembersOpen(false)}
          className="absolute inset-0 z-10 bg-black/40"
        >
          <div
            role="dialog"
            aria-modal="true"
            onClick={(event) => event.stopPropagation()}
            className="absolute top-0 right-0 flex h-full w-72 flex-col bg-white shadow-lg"
          >
            <div className="flex h-12 shrink-0 items-center bg-ola-primary px-4 text-base font-medium text-white">
              {t('room.membersTitle')}
            </div>
            <ul className="flex-1 overflow-y-auto">
              {members.map((member) => (
                <li
                  key={member.name}
                  className="flex items-center gap-2 border-b border-black/12 px-4 py-3"
                >
                  <img
                    src={member.gender === 'male' ? maleIcon : femaleIcon}
                    alt=""
                    className="h-4 w-4 shrink-0 self-start object-contain"
                  />
                  <Avatar name={member.name} color={member.color} />
                  <span className="min-w-0 flex-1 truncate text-base text-black/87">
                    {member.name}
                  </span>
                  {member.online && (
                    <span className="shrink-0 text-xs text-ola-primary">
                      {t('chat.online')}
                    </span>
                  )}
                </li>
              ))}
            </ul>
            <button
              type="button"
              aria-label={t('room.addMember')}
              className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg"
            >
              <img
                src={addFriendIcon}
                alt=""
                className="h-6 w-6 object-contain brightness-0 invert"
              />
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

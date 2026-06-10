import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ListOptionDialog, type ListOption } from '@components';
import { HomeHeader } from '@components/HomeHeader';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import { ConversationList } from './components/ConversationList';
import { ContactList } from './components/ContactList';
import { ComposeButton } from './components/ComposeButton';
import { ComposeDialog } from './components/ComposeDialog';
import { ChatConversationView } from './components/ChatConversationView';
import { CONTACTS, CONVERSATIONS } from './data';
import type { Conversation } from './types';

type ChatSub = 'messages' | 'contacts';

interface ActiveChat {
  name: string;
  color: string;
  seedMessage?: string;
}

const FALLBACK_COLOR = '#7cb342';

export function ChatPanel() {
  const { t } = useTranslation();
  const [sub, setSub] = useState<ChatSub>('messages');
  const [conversations, setConversations] = useState<Conversation[]>(CONVERSATIONS);
  const [activeChat, setActiveChat] = useState<ActiveChat | null>(null);
  const [composeOpen, setComposeOpen] = useState(false);
  const [headerMenuOpen, setHeaderMenuOpen] = useState(false);

  function openConversation(conversation: Conversation) {
    setConversations((current) =>
      current.map((item) =>
        item.name === conversation.name ? { ...item, unread: 0 } : item
      )
    );
    setActiveChat({
      name: conversation.name,
      color: conversation.color,
      seedMessage: conversation.last,
    });
  }

  function startChatWith(name: string, color = FALLBACK_COLOR, seedMessage?: string) {
    setComposeOpen(false);
    setActiveChat({ name, color, seedMessage });
  }

  function deleteConversation(name: string) {
    setConversations((current) => current.filter((item) => item.name !== name));
  }

  const headerMenuOptions: ListOption[] = [
    { key: 'compose', label: t('chat.composeTitle'), onSelect: () => setComposeOpen(true) },
  ];

  function renderTab(value: ChatSub, label: string) {
    const isActive = sub === value;
    return (
      <button
        type="button"
        onClick={() => setSub(value)}
        className={`flex-1 self-stretch text-base font-medium ${
          isActive ? 'border-b-2 border-white text-white' : 'text-white/70'
        }`}
      >
        {label}
      </button>
    );
  }

  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center">
          {renderTab('messages', t('home.subMessages'))}
          {renderTab('contacts', t('home.subContacts'))}
          <button
            type="button"
            aria-label="Menu"
            onClick={() => setHeaderMenuOpen(true)}
            className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
          >
            <img src={moreIcon} alt="" className="h-5 w-5 object-contain" />
          </button>
        </div>
      </HomeHeader>

      <main className="relative flex-1 overflow-y-auto">
        {sub === 'messages' ? (
          <div className="relative h-full bg-[#f3f3f3]">
            <ConversationList
              conversations={conversations}
              onSelect={openConversation}
              onDelete={deleteConversation}
            />
            <ComposeButton onClick={() => setComposeOpen(true)} />
          </div>
        ) : (
          <ContactList
            contacts={CONTACTS}
            onSelect={(contact) =>
              startChatWith(contact.name, contact.color, contact.status)
            }
          />
        )}
      </main>

      {activeChat != null && (
        <ChatConversationView
          name={activeChat.name}
          color={activeChat.color}
          seedMessage={activeChat.seedMessage}
          onClose={() => setActiveChat(null)}
        />
      )}

      <ComposeDialog
        open={composeOpen}
        onClose={() => setComposeOpen(false)}
        onStart={(name) => startChatWith(name)}
      />
      <ListOptionDialog
        open={headerMenuOpen}
        title={t('home.tabChat')}
        options={headerMenuOptions}
        onClose={() => setHeaderMenuOpen(false)}
      />
    </>
  );
}

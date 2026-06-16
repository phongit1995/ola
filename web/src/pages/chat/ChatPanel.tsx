import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  Dialog,
  ListOptionDialog,
  type ListOption,
} from '@components';
import { ROUTES } from '@constants';
import { DEFAULT_AVATAR_COLOR, toast } from '@lib';
import { HomeHeader } from '@components/HomeHeader';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import { AuthService } from '@services';
import { useAuthStore } from '@/store/authStore';
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

export function ChatPanel() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const clearUser = useAuthStore((s) => s.clearUser);

  const [sub, setSub] = useState<ChatSub>('messages');
  const [conversations, setConversations] = useState<Conversation[]>(CONVERSATIONS);
  const [activeChat, setActiveChat] = useState<ActiveChat | null>(null);
  const [composeOpen, setComposeOpen] = useState(false);
  const [headerMenuOpen, setHeaderMenuOpen] = useState(false);
  const [showStrangers, setShowStrangers] = useState(true);
  const [deleteAllOpen, setDeleteAllOpen] = useState(false);
  const [blockedListOpen, setBlockedListOpen] = useState(false);
  const [logoutOpen, setLogoutOpen] = useState(false);

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

  function startChatWith(name: string, color = DEFAULT_AVATAR_COLOR, seedMessage?: string) {
    setComposeOpen(false);
    setActiveChat({ name, color, seedMessage });
  }

  function deleteConversation(name: string) {
    setConversations((current) => current.filter((item) => item.name !== name));
  }

  function confirmDeleteAll() {
    setConversations([]);
    setDeleteAllOpen(false);
  }

  async function confirmLogout() {
    setLogoutOpen(false);
    try {
      await AuthService.logout();
    } catch {
      toast.error(t('chat.logoutError'));
    } finally {
      clearUser();
      navigate(ROUTES.login);
    }
  }

  const messagesMenu: ListOption[] = [
    { key: 'delete-all', label: t('chat.menuDeleteAll'), danger: true, onSelect: () => setDeleteAllOpen(true) },
    {
      key: 'strangers',
      label: showStrangers ? t('chat.menuDeleteStrangers') : t('chat.menuShowStrangers'),
      onSelect: () => setShowStrangers((value) => !value),
    },
    { key: 'block-list', label: t('chat.menuBlockList'), onSelect: () => setBlockedListOpen(true) },
  ];

  const contactsMenu: ListOption[] = [
    { key: 'change-avatar', label: t('chat.menuChangeAvatar'), onSelect: () => {} },
    { key: 'logout', label: t('chat.menuLogout'), onSelect: () => setLogoutOpen(true) },
    { key: 'logout-all', label: t('chat.menuLogoutAll'), onSelect: () => setLogoutOpen(true) },
    { key: 'buy-vip', label: t('chat.menuBuyVip'), onSelect: () => {} },
  ];

  const headerMenuOptions = sub === 'messages' ? messagesMenu : contactsMenu;

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
            aria-label={t('common.menu')}
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
        title={sub === 'messages' ? t('home.subMessages') : t('home.subContacts')}
        options={headerMenuOptions}
        onClose={() => setHeaderMenuOpen(false)}
      />
      <ConfirmDialog
        open={deleteAllOpen}
        danger
        title={t('chat.menuDeleteAll')}
        message={t('chat.menuDeleteAllConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmDeleteAll}
        onCancel={() => setDeleteAllOpen(false)}
      />
      <ConfirmDialog
        open={logoutOpen}
        showIcon={false}
        danger
        title={t('dialog.logoutTitle')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmLogout}
        onCancel={() => setLogoutOpen(false)}
      />
      <Dialog
        open={blockedListOpen}
        onClose={() => setBlockedListOpen(false)}
        title={t('chat.menuBlockList')}
      >
        <p className="py-2 text-center text-black/54">{t('chat.blockListEmpty')}</p>
      </Dialog>
    </>
  );
}

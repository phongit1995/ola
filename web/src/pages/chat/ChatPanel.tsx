import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  Dialog,
  ListOptionDialog,
  type ListOption,
} from '@components';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import { HomeHeader } from '@components/HomeHeader';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import { AuthService } from '@services';
import { useAuthStore } from '@/store/authStore';
import { useChatStore } from '@/store/chatStore';
import { ConversationList } from './components/ConversationList';
import { ContactList } from './components/ContactList';
import { ComposeButton } from './components/ComposeButton';
import { ComposeDialog } from './components/ComposeDialog';
import { ChangeAvatarScreen } from './components/ChangeAvatarScreen';
import { CONTACTS } from './data';

type ChatSub = 'messages' | 'contacts';

export function ChatPanel() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const clearUser = useAuthStore((s) => s.clearUser);

  const conversations = useChatStore((s) => s.conversations);
  const loadConversations = useChatStore((s) => s.loadConversations);
  const openConversation = useChatStore((s) => s.openConversation);
  const hideConversation = useChatStore((s) => s.hideConversation);
  const startDirect = useChatStore((s) => s.startDirect);

  const [sub, setSub] = useState<ChatSub>('messages');
  const [composeOpen, setComposeOpen] = useState(false);
  const [headerMenuOpen, setHeaderMenuOpen] = useState(false);
  const [showStrangers, setShowStrangers] = useState(true);
  const [deleteAllOpen, setDeleteAllOpen] = useState(false);
  const [blockedListOpen, setBlockedListOpen] = useState(false);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [avatarOpen, setAvatarOpen] = useState(false);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  function comingSoon() {
    toast.info(t('chat.comingSoon'));
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
    { key: 'change-avatar', label: t('chat.menuChangeAvatar'), onSelect: () => setAvatarOpen(true) },
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
              onDelete={hideConversation}
            />
            <ComposeButton onClick={() => setComposeOpen(true)} />
          </div>
        ) : (
          <ContactList contacts={CONTACTS} onSelect={comingSoon} />
        )}
      </main>

      {composeOpen && (
        <ComposeDialog
          open
          onClose={() => setComposeOpen(false)}
          onStart={(friendId) => {
            setComposeOpen(false);
            void startDirect(friendId);
          }}
        />
      )}
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
        onConfirm={() => {
          setDeleteAllOpen(false);
          comingSoon();
        }}
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
      <ChangeAvatarScreen open={avatarOpen} onClose={() => setAvatarOpen(false)} />
    </>
  );
}

import { useEffect, useRef, useState } from 'react';
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
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import { AuthService, RelationshipService } from '@services';
import { useAuthStore } from '@/store/authStore';
import { useChatStore } from '@/store/chatStore';
import { ConversationList } from './components/ConversationList';
import { ContactList } from './components/ContactList';
import { ComposeButton } from './components/ComposeButton';
import { ComposeDialog } from './components/ComposeDialog';
import { ChangeAvatarScreen } from './components/ChangeAvatarScreen';
import { StatusEditDialog } from './components/StatusEditDialog';
import { MediaViewer } from '@/pages/me/components/MediaViewer';
import { mapFriendsToContacts } from './friends';
import type { Contact } from './types';

type ChatSub = 'messages' | 'contacts';

export function ChatPanel() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const clearUser = useAuthStore((s) => s.clearUser);
  const user = useAuthStore((s) => s.user);

  const conversations = useChatStore((s) => s.conversations);
  const loadingConversations = useChatStore((s) => s.loadingConversations);
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
  const [logoutAll, setLogoutAll] = useState(false);
  const [avatarOpen, setAvatarOpen] = useState(false);
  const [statusOpen, setStatusOpen] = useState(false);
  const [statusImageOpen, setStatusImageOpen] = useState(false);
  const [buddyImage, setBuddyImage] = useState<string | null>(null);
  const [friends, setFriends] = useState<Contact[]>([]);
  const friendsLoadedRef = useRef(false);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  useEffect(() => {
    if (sub !== 'contacts' || friendsLoadedRef.current) return;
    friendsLoadedRef.current = true;
    RelationshipService.friends()
      .then((res) => setFriends(mapFriendsToContacts(res.friends)))
      .catch(() => {
        friendsLoadedRef.current = false;
        toast.error(t('chat.loadFriendsError'));
      });
  }, [sub, t]);

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
    { key: 'buy-vip', label: t('chat.menuBuyVip'), onSelect: () => comingSoon() },
    { key: 'change-avatar', label: t('chat.menuChangeAvatar'), onSelect: () => setAvatarOpen(true) },
    { key: 'logout', label: t('chat.menuLogout'), onSelect: () => { setLogoutAll(false); setLogoutOpen(true); } },
    { key: 'logout-all', label: t('chat.menuLogoutAll'), onSelect: () => { setLogoutAll(true); setLogoutOpen(true); } },
  ];

  const headerMenuOptions = sub === 'messages' ? messagesMenu : contactsMenu;
  const totalUnread = conversations.reduce((sum, item) => sum + (item.unreadCount ?? 0), 0);

  function renderTab(value: ChatSub, label: string, badge = 0) {
    const isActive = sub === value;
    return (
      <button
        type="button"
        onClick={() => setSub(value)}
        className={`flex-1 self-stretch text-base font-medium ${
          isActive ? 'border-b-2 border-white text-white' : 'text-white/70'
        }`}
      >
        <span className="relative inline-flex items-center">
          {label}
          {badge > 0 && (
            <span className="absolute -top-1 -right-5 flex h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1 text-[10px] font-bold text-white ring-2 ring-ola-primary">
              {badge > 99 ? '99+' : badge}
            </span>
          )}
        </span>
      </button>
    );
  }

  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center">
          {renderTab('messages', t('home.subMessages'), totalUnread)}
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
            {loadingConversations && conversations.length === 0 ? (
              <div className="flex h-full items-center justify-center">
                <span className="h-8 w-8 animate-spin rounded-full border-4 border-ola-primary/30 border-t-ola-primary" />
              </div>
            ) : (
              <>
                <ConversationList
                  conversations={conversations}
                  onSelect={openConversation}
                  onDelete={hideConversation}
                />
                <ComposeButton onClick={() => setComposeOpen(true)} />
              </>
            )}
          </div>
        ) : (
          <div className="relative h-full">
            <ContactList
              contacts={friends}
              onSelect={comingSoon}
              me={user}
              onAccountMenu={() => setHeaderMenuOpen(true)}
              onEditStatus={() => setStatusOpen(true)}
              onPreviewImage={() => setStatusImageOpen(true)}
              onPreviewBuddyImage={setBuddyImage}
              onComingSoon={comingSoon}
            />
            <button
              type="button"
              onClick={comingSoon}
              aria-label={t('chat.menuAddContact')}
              className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-[0_3px_6px_rgba(0,0,0,.3)]"
            >
              <img src={addFriendIcon} alt="" className="h-6 w-6 object-contain brightness-0 invert" />
            </button>
          </div>
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
        title={logoutAll ? t('chat.menuLogoutAll') : t('chat.menuLogout')}
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
      {statusOpen && <StatusEditDialog open onClose={() => setStatusOpen(false)} />}
      {statusImageOpen && user?.bioImage != null && user.bioImage !== '' && (
        <MediaViewer photos={[user.bioImage]} index={0} onClose={() => setStatusImageOpen(false)} />
      )}
      {buddyImage != null && (
        <MediaViewer photos={[buddyImage]} index={0} onClose={() => setBuddyImage(null)} />
      )}
    </>
  );
}

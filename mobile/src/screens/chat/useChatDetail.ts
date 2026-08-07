import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { currentUserId } from '@ola/shared/stores/chat/chatHelpers';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import {
  chatFriendActionLabel,
  createDateSeparatorFormatter,
  formatClockHM,
  formatLastActive,
} from '@ola/shared/lib';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import { useFocusPresence } from '@hooks/usePresence';

export function useChatDetail(conversationId: string | null | undefined) {
  const { t, i18n } = useTranslation();
  const push = useToastStore((s) => s.push);

  const conversations = useChatStore((s) => s.conversations);
  const messages = useChatStore((s) => s.messages);
  const loadingMessages = useChatStore((s) => s.loadingMessages);
  const hasMore = useChatStore((s) => s.hasMore);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const openConversation = useChatStore((s) => s.openConversation);
  const closeConversation = useChatStore((s) => s.closeConversation);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const sendText = useChatStore((s) => s.sendText);
  const sendImage = useChatStore((s) => s.sendImage);
  const sendAudio = useChatStore((s) => s.sendAudio);
  const resendMessage = useChatStore((s) => s.resendMessage);
  const reactToMessage = useChatStore((s) => s.reactToMessage);
  const deleteMessage = useChatStore((s) => s.deleteMessage);
  const editMessage = useChatStore((s) => s.editMessage);
  const replyTarget = useChatStore((s) => s.replyTarget);
  const setReplyTarget = useChatStore((s) => s.setReplyTarget);
  const clearReplyTarget = useChatStore((s) => s.clearReplyTarget);
  const blockPeer = useChatStore((s) => s.blockPeer);
  const unblockPeer = useChatStore((s) => s.unblockPeer);
  const friendAction = useChatStore((s) => s.friendAction);
  const peerProfile = useChatStore((s) => s.peerProfile);
  const peerRelationship = useChatStore((s) => s.peerRelationship);
  const peerCardRoll = useChatStore((s) => s.peerCardRoll);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const draftRecipient = useChatStore((s) => s.draftRecipient);

  useEffect(() => {
    if (conversationId != null) void openConversation(conversationId);
    return () => closeConversation();
  }, [conversationId, openConversation, closeConversation]);

  const activeConversationId = conversationId ?? currentConversationId ?? null;
  const conversation = conversations.find((item) => item.id === activeConversationId);
  const title =
    conversation?.otherUser?.fullName ??
    conversation?.otherUser?.username ??
    conversation?.name ??
    draftRecipient?.name ??
    peerProfile?.fullName ??
    peerProfile?.username ??
    '';
  const peerAvatar =
    conversation?.otherUser?.avatar ?? draftRecipient?.avatar ?? peerProfile?.avatar;
  const myId = currentUserId();
  const timeFormatter = formatClockHM;
  const dateFormatter = useMemo(
    () => createDateSeparatorFormatter(i18n.language),
    [i18n.language],
  );

  const peerId = peerProfile?.id ?? conversation?.otherUser?.id ?? draftRecipient?.id ?? '';
  const livePresence = useFocusPresence(peerId !== '' ? peerId : null);
  const peerOnline =
    (livePresence?.isOnline ?? peerProfile?.isOnline ?? conversation?.otherUser?.isOnline) === true;
  const peerLastActiveAt =
    livePresence?.lastActiveAt ?? peerProfile?.lastActiveAt ?? conversation?.otherUser?.lastActiveAt;
  const [now, setNow] = useState(() => Date.now());

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), 60_000);
    return () => clearInterval(interval);
  }, []);

  const lastActiveTime = formatLastActive(i18n.language, peerLastActiveAt, now);

  const subtitle =
    typingUsers.length > 0
      ? t('chat.typing', { name: typingUsers[0]?.username ?? '' })
      : peerOnline
        ? t('chat.statusActive')
        : lastActiveTime == null
          ? ''
          : t('chat.statusLastActive', { time: lastActiveTime });

  const conversationSeen =
    conversation == null ? false : !conversation.isLastMessageFromMe ? true : conversation.seen;

  const blockStatus = peerRelationship?.status ?? null;
  const blockedByMe = blockStatus === RELATIONSHIP_STATUS.blockedByMe;
  const blockedByThem = blockStatus === RELATIONSHIP_STATUS.blockedByThem;
  const blocked = blockedByMe || blockedByThem;
  const friendLabel = chatFriendActionLabel(t, blockStatus);

  const lastOwnId = useMemo(() => {
    for (let i = messages.length - 1; i >= 0; i -= 1) {
      if (messages[i]!.senderId === myId) return messages[i]!.id;
    }
    return null;
  }, [messages, myId]);

  async function handleFriendAction() {
    if (blocked) {
      push('info', t('chat.makeFriendBlocked'));
      return;
    }
    const result = await friendAction();
    if (result === 'error') {
      push('error', t('chat.actionError'));
      return;
    }
    if (result === 'request') push('success', t('chat.friendRequestSent'));
    else if (result === 'cancel') push('success', t('chat.requestCancelled'));
    else if (result === 'accept') push('success', t('chat.friendAccepted'));
    else if (result === 'unfriend') push('success', t('chat.unfriendDone'));
  }

  async function handleBlock() {
    const ok = await blockPeer();
    push(ok ? 'success' : 'error', ok ? t('chat.blockDone', { name: title }) : t('chat.actionError'));
  }

  async function handleUnblock() {
    const ok = await unblockPeer();
    push(ok ? 'success' : 'error', ok ? t('chat.unblockDone', { name: title }) : t('chat.actionError'));
  }

  return {
    conversation,
    title,
    peerAvatar,
    myId,
    peerId,
    peerProfile,
    peerCardRoll,
    messages,
    loadingMessages,
    hasMore,
    typingUsers,
    replyTarget,
    timeFormatter,
    dateFormatter,
    subtitle,
    conversationSeen,
    blocked,
    blockedByMe,
    blockStatus,
    friendLabel,
    lastOwnId,
    loadMoreMessages,
    sendText,
    sendImage,
    sendAudio,
    resendMessage,
    reactToMessage,
    deleteMessage,
    editMessage,
    setReplyTarget,
    clearReplyTarget,
    notifyTyping,
    handleFriendAction,
    handleBlock,
    handleUnblock,
  };
}

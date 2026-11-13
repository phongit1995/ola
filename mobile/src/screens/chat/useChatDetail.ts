import { useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { currentUserId } from '@ola/shared/stores/chat/chatHelpers';
import {
  chatFriendActionLabel,
  createDateSeparatorFormatter,
  formatClockHM,
  formatLastActive,
} from '@ola/shared/lib';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import { useFocusPresence } from './usePresence';
import { clearPushNotification, dmNotifId } from '@lib/push';
import { useMinuteNow } from '@ola/shared/stores/useMinuteNow';
import { useChatPeerActions } from '@ola/shared/stores/chat/useChatPeerActions';

export function useChatDetail(conversationId: string | null | undefined) {
  const { t, i18n } = useTranslation();

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
  const peerProfile = useChatStore((s) => s.peerProfile);
  const peerRelationship = useChatStore((s) => s.peerRelationship);
  const peerCardRoll = useChatStore((s) => s.peerCardRoll);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const draftRecipient = useChatStore((s) => s.draftRecipient);

  useEffect(() => {
    if (conversationId != null) {
      void openConversation(conversationId);
      void clearPushNotification(dmNotifId(conversationId));
    }
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
  const peerAvatarFrameId =
    peerProfile != null ? peerProfile.avatarFrameId : conversation?.otherUser?.avatarFrameId;
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
  const now = useMinuteNow();

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
  const { handleFriendAction, handleBlock, handleUnblock } = useChatPeerActions(title, blocked);

  const lastOwnId = useMemo(() => {
    for (let i = messages.length - 1; i >= 0; i -= 1) {
      if (messages[i]!.senderId === myId) return messages[i]!.id;
    }
    return null;
  }, [messages, myId]);

  return {
    conversation,
    title,
    peerAvatar,
    peerAvatarFrameId,
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

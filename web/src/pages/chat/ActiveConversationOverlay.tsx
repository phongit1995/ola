import { colorForName } from '@lib';
import { useChatStore } from '@/store/chat/chatStore';
import { ChatConversationView } from './components/ChatConversationView';
import { toConversationView } from './chatView';
import { useFocusPresence } from './usePresence';

export function ActiveConversationOverlay() {
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const conversations = useChatStore((s) => s.conversations);
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const peerProfile = useChatStore((s) => s.peerProfile);
  const peerRelationship = useChatStore((s) => s.peerRelationship);
  const closeConversation = useChatStore((s) => s.closeConversation);

  const conversation =
    currentConversationId != null
      ? conversations.find((item) => item.id === currentConversationId) ?? null
      : null;
  const peerId = conversation?.otherUser?.id ?? draftRecipient?.id ?? null;
  const live = useFocusPresence(peerId);

  if (currentConversationId != null) {
    if (conversation == null) return null;
    const view = toConversationView(conversation);
    return (
      <ChatConversationView
        name={view.name}
        username={view.username}
        title={view.title}
        color={view.color}
        avatar={view.avatar}
        online={
          live?.isOnline ??
          peerProfile?.isOnline ??
          conversation.otherUser?.isOnline ??
          false
        }
        lastActiveAt={
          live?.lastActiveAt ??
          peerProfile?.lastActiveAt ??
          conversation.otherUser?.lastActiveAt
        }
        blockStatus={peerRelationship?.status ?? null}
        onClose={closeConversation}
      />
    );
  }

  if (draftRecipient != null) {
    return (
      <ChatConversationView
        name={draftRecipient.name}
        username={peerProfile?.username}
        color={colorForName(draftRecipient.name)}
        avatar={draftRecipient.avatar}
        online={live?.isOnline ?? peerProfile?.isOnline ?? false}
        lastActiveAt={live?.lastActiveAt ?? peerProfile?.lastActiveAt}
        blockStatus={peerRelationship?.status ?? null}
        onClose={closeConversation}
      />
    );
  }

  return null;
}

import { colorForName } from '@lib';
import { useChatStore } from '@/store/chat/chatStore';
import { ChatConversationView } from './components/ChatConversationView';
import { toConversationView } from './chatView';

export function ActiveConversationOverlay() {
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const conversations = useChatStore((s) => s.conversations);
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const peerRelationship = useChatStore((s) => s.peerRelationship);
  const closeConversation = useChatStore((s) => s.closeConversation);

  if (currentConversationId != null) {
    const conversation = conversations.find((item) => item.id === currentConversationId) ?? null;
    if (conversation == null) return null;
    const view = toConversationView(conversation);
    return (
      <ChatConversationView
        name={view.name}
        username={view.username}
        title={view.title}
        color={view.color}
        avatar={view.avatar}
        online={conversation.otherUser?.isOnline ?? false}
        lastActiveAt={conversation.otherUser?.lastActiveAt}
        blockStatus={peerRelationship?.status ?? null}
        onClose={closeConversation}
      />
    );
  }

  if (draftRecipient != null) {
    return (
      <ChatConversationView
        name={draftRecipient.name}
        color={colorForName(draftRecipient.name)}
        avatar={draftRecipient.avatar}
        online={false}
        blockStatus={peerRelationship?.status ?? null}
        onClose={closeConversation}
      />
    );
  }

  return null;
}

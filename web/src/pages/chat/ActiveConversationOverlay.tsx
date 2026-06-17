import { colorForName } from '@lib';
import { useChatStore } from '@/store/chatStore';
import { ChatConversationView } from './components/ChatConversationView';
import { toConversationView } from './chatView';

export function ActiveConversationOverlay() {
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const conversations = useChatStore((s) => s.conversations);
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const peerStatus = useChatStore((s) => s.peerStatus);
  const closeConversation = useChatStore((s) => s.closeConversation);

  if (currentConversationId != null) {
    const conversation = conversations.find((item) => item.id === currentConversationId) ?? null;
    if (conversation == null) return null;
    const view = toConversationView(conversation);
    return (
      <ChatConversationView
        name={view.name}
        title={view.title}
        color={view.color}
        avatar={view.avatar}
        online={conversation.otherUser?.isOnline ?? false}
        blockStatus={peerStatus}
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
        blockStatus={peerStatus}
        onClose={closeConversation}
      />
    );
  }

  return null;
}

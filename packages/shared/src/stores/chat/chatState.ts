import type { ChatReactionNotice, Conversation, Message } from '../../types/api/chat.type';
import type { PublicProfile, RelationshipInfo } from '../../types/api/user.type';
import type {
  ChatState,
  ChatStateData,
  DraftRecipient,
  TypingUser,
} from '../../types/client/chat.type';

export type { ChatGet, ChatSet } from '../../types/client/chat.type';

export const initialChatState: ChatStateData = {
  conversations: [] as Conversation[],
  currentConversationId: null,
  draftRecipient: null as DraftRecipient | null,
  peerRelationship: null as RelationshipInfo | null,
  peerProfile: null as PublicProfile | null,
  peerCardRoll: false,
  messages: [] as Message[],
  hasMore: false,
  messagesCursor: null,
  loadingConversations: false,
  loadingMessages: false,
  loadingMore: false,
  typingUsers: [] as TypingUser[],
  replyTarget: null,
  reactionNotice: null as ChatReactionNotice | null,
};

export const clearedPeerView: Pick<
  ChatState,
  'peerRelationship' | 'peerProfile' | 'peerCardRoll'
> = {
  peerRelationship: null,
  peerProfile: null,
  peerCardRoll: false,
};

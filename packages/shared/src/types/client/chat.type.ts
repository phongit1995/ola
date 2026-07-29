import type { StoreApi } from 'zustand';
import type { UploadFile } from './upload.type';
import type {
  ChatReplySnapshot,
  ChatReactionNotice,
  Conversation,
  Message,
  MessageType,
  ReactionType,
} from '../api/chat.type';
import type { PublicProfile, RelationshipInfo } from '../api/user.type';

export interface TypingUser {
  userId: string;
  username: string;
}

export interface DraftRecipient {
  id: string;
  name: string;
  avatar?: string;
}

export type FriendActionResult =
  | 'request'
  | 'cancel'
  | 'accept'
  | 'unfriend'
  | 'none'
  | 'error';

export interface ChatState {
  conversations: Conversation[];
  currentConversationId: string | null;
  draftRecipient: DraftRecipient | null;
  peerRelationship: RelationshipInfo | null;
  peerProfile: PublicProfile | null;
  peerCardRoll: boolean;
  messages: Message[];
  hasMore: boolean;
  messagesCursor: string | null;
  loadingConversations: boolean;
  loadingMessages: boolean;
  loadingMore: boolean;
  typingUsers: TypingUser[];
  replyTarget: Message | null;
  reactionNotice: ChatReactionNotice | null;
  setReplyTarget: (message: Message) => void;
  clearReplyTarget: () => void;
  clearReactionNotice: (seq: number) => void;
  loadConversations: () => Promise<void>;
  syncCurrentConversation: () => Promise<void>;
  openConversation: (conversationId: string) => Promise<void>;
  startDirect: (recipientId: string) => Promise<Conversation | null>;
  closeConversation: () => void;
  hideConversation: (
    conversationId: string,
    options?: { clearMessages?: boolean }
  ) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  sendText: (content: string) => Promise<void>;
  sendFirstToDraft: (content: string) => Promise<void>;
  sendImage: (file: UploadFile) => Promise<void>;
  sendAudio: (blob: UploadFile, duration: number, waveform?: number[]) => Promise<boolean>;
  resendMessage: (messageId: string) => Promise<boolean>;
  reactToMessage: (messageId: string, type: ReactionType) => Promise<void>;
  deleteMessage: (messageId: string) => Promise<void>;
  deleteAllConversations: () => Promise<void>;
  editMessage: (messageId: string, content: string) => Promise<void>;
  blockPeer: () => Promise<boolean>;
  unblockPeer: () => Promise<boolean>;
  friendAction: () => Promise<FriendActionResult>;
  notifyTyping: () => void;
  markRead: (conversationId: string) => Promise<void>;
  reset: () => void;
}

export type ChatSet = StoreApi<ChatState>['setState'];
export type ChatGet = StoreApi<ChatState>['getState'];

export type ChatStateData = Pick<
  ChatState,
  | 'conversations'
  | 'currentConversationId'
  | 'draftRecipient'
  | 'peerRelationship'
  | 'peerProfile'
  | 'peerCardRoll'
  | 'messages'
  | 'hasMore'
  | 'messagesCursor'
  | 'loadingConversations'
  | 'loadingMessages'
  | 'loadingMore'
  | 'typingUsers'
  | 'replyTarget'
  | 'reactionNotice'
>;

export type ChatConversationActions = Pick<
  ChatState,
  | 'loadConversations'
  | 'syncCurrentConversation'
  | 'openConversation'
  | 'startDirect'
  | 'closeConversation'
  | 'hideConversation'
  | 'loadMoreMessages'
  | 'deleteAllConversations'
  | 'markRead'
>;

export type ChatMessageActions = Pick<
  ChatState,
  | 'sendText'
  | 'sendFirstToDraft'
  | 'sendImage'
  | 'sendAudio'
  | 'resendMessage'
  | 'reactToMessage'
  | 'deleteMessage'
  | 'editMessage'
  | 'notifyTyping'
>;

export type ChatRelationshipActions = Pick<
  ChatState,
  'blockPeer' | 'unblockPeer' | 'friendAction'
>;

export interface OptimisticMessageInput {
  clientMsgId: string;
  conversationId: string;
  type: MessageType;
  status: Message['status'];
  content?: string;
  metadata?: string;
  replyTo?: ChatReplySnapshot;
}

import { RelationshipService } from '../../services/relationship.service';
import type { ChatRelationshipActions } from '../../types/client/chat.type';
import type { ChatGet, ChatSet } from './chatState';

export function createChatRelationshipActions(
  set: ChatSet,
  get: ChatGet
): ChatRelationshipActions {
  const peerUserId = (): string => {
    const state = get();
    const conversation = state.conversations.find(
      (item) => item.id === state.currentConversationId
    );
    return conversation?.otherUser?.id ?? state.draftRecipient?.id ?? '';
  };

  return {
    blockPeer: async () => {
      const userId = peerUserId();
      if (userId === '') return false;
      try {
        const relationship = await RelationshipService.block(userId);
        const current = get().peerRelationship;
        set({
          peerRelationship: {
            status: 'blocked_by_me',
            requestId: relationship.id,
            isFollowing: current?.isFollowing ?? false,
            followsMe: current?.followsMe ?? false,
          },
        });
        return true;
      } catch {
        return false;
      }
    },

    unblockPeer: async () => {
      const current = get().peerRelationship;
      if (current?.requestId == null || current.requestId === '') return false;
      try {
        await RelationshipService.unblock(current.requestId);
        set({
          peerRelationship: {
            ...current,
            status: 'none',
            requestId: undefined,
          },
        });
        return true;
      } catch {
        return false;
      }
    },

    friendAction: async () => {
      const current = get().peerRelationship;
      const status = current?.status ?? 'none';
      const requestId = current?.requestId ?? '';
      const base = {
        isFollowing: current?.isFollowing ?? false,
        followsMe: current?.followsMe ?? false,
      };
      try {
        if (status === 'none') {
          const userId = peerUserId();
          if (userId === '') return 'none';
          const relationship = await RelationshipService.sendRequest(userId);
          set({
            peerRelationship: {
              ...base,
              status: 'pending_outgoing',
              requestId: relationship.id,
            },
          });
          return 'request';
        }
        if (status === 'pending_outgoing' && requestId !== '') {
          await RelationshipService.cancel(requestId);
          set({
            peerRelationship: { ...base, status: 'none', requestId: undefined },
          });
          return 'cancel';
        }
        if (status === 'pending_incoming' && requestId !== '') {
          await RelationshipService.respond(requestId, 'accept');
          set({ peerRelationship: { ...base, status: 'friend', requestId } });
          return 'accept';
        }
        if (status === 'friend' && requestId !== '') {
          await RelationshipService.unfriend(requestId);
          set({
            peerRelationship: { ...base, status: 'none', requestId: undefined },
          });
          return 'unfriend';
        }
        return 'none';
      } catch {
        return 'error';
      }
    },
  };
}

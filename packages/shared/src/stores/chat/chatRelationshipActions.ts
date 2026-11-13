import { RelationshipService } from '../../services/relationship.service';
import type { ChatRelationshipActions } from '../../types/client/chat.type';
import type { ChatGet, ChatSet } from './chatState';
import { RELATIONSHIP_STATUS } from '../../constants/relationship';

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
            status: RELATIONSHIP_STATUS.blockedByMe,
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
            status: RELATIONSHIP_STATUS.none,
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
        if (status === RELATIONSHIP_STATUS.none) {
          const userId = peerUserId();
          if (userId === '') return 'none';
          const relationship = await RelationshipService.sendRequest(userId);
          set({
            peerRelationship: {
              ...base,
              status: RELATIONSHIP_STATUS.pendingOutgoing,
              requestId: relationship.id,
            },
          });
          return 'request';
        }
        if (status === RELATIONSHIP_STATUS.pendingOutgoing && requestId !== '') {
          await RelationshipService.cancel(requestId);
          set({
            peerRelationship: { ...base, status: RELATIONSHIP_STATUS.none, requestId: undefined },
          });
          return 'cancel';
        }
        if (status === RELATIONSHIP_STATUS.pendingIncoming && requestId !== '') {
          await RelationshipService.respond(requestId, 'accept');
          set({ peerRelationship: { ...base, status: RELATIONSHIP_STATUS.friend, requestId } });
          return 'accept';
        }
        if (status === RELATIONSHIP_STATUS.friend && requestId !== '') {
          await RelationshipService.unfriend(requestId);
          set({
            peerRelationship: { ...base, status: RELATIONSHIP_STATUS.none, requestId: undefined },
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

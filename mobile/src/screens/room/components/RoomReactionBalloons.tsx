import { useRoomChatStore } from '@ola/shared/stores/room/roomChatStore';
import { ReactionBalloons } from '@components/chat/ReactionBalloons';

function subscribeToRoomReactions(
  onReaction: (type: string) => void,
): () => void {
  return useRoomChatStore.subscribe((state, previousState) => {
    const notice = state.reactionNotice;
    if (notice == null || notice === previousState.reactionNotice) return;
    onReaction(notice.type);
  });
}

export function RoomReactionBalloons() {
  return <ReactionBalloons subscribe={subscribeToRoomReactions} />;
}

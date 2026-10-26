import { ReactionBalloons } from '@components';
import { useRoomChatStore } from '@/store/roomChatStore';

function subscribeRoomReactions(onReaction: (type: string) => void) {
  return useRoomChatStore.subscribe((state, prevState) => {
    const notice = state.reactionNotice;
    if (notice == null || notice === prevState.reactionNotice) return;
    onReaction(notice.type);
  });
}

export function RoomReactionBalloons() {
  return <ReactionBalloons subscribe={subscribeRoomReactions} />;
}

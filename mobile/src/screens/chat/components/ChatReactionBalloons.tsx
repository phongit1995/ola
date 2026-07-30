import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { ReactionBalloons } from '@components/chat/ReactionBalloons';

function subscribeToChatReactions(
  onReaction: (type: string) => void,
): () => void {
  return useChatStore.subscribe((state, previousState) => {
    const notice = state.reactionNotice;
    if (notice == null || notice === previousState.reactionNotice) return;
    onReaction(notice.type);
  });
}

export function ChatReactionBalloons() {
  return <ReactionBalloons subscribe={subscribeToChatReactions} />;
}

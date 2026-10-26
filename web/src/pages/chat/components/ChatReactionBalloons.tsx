import { ReactionBalloons } from '@components';
import { useChatStore } from '@/store/chat/chatStore';

function subscribeChatReactions(onReaction: (type: string) => void) {
  return useChatStore.subscribe((state, prevState) => {
    const notice = state.reactionNotice;
    if (notice == null || notice === prevState.reactionNotice) return;
    onReaction(notice.type);
  });
}

export function ChatReactionBalloons() {
  return <ReactionBalloons subscribe={subscribeChatReactions} />;
}

import { chatBotGrouping } from '@ola/shared/lib';
import type { ChatBotMessage, ChatBotSurfaceKind } from '@ola/shared/types';
import { bubbleSurface } from '@lib';
import type { MessageGrouping } from './interface';

export {
  chatBotIso as isoOf,
  pickChatBotSuggestions as pickSuggestions,
  renderableChatBotMessages as renderableMessages,
} from '@ola/shared/lib';

function surfaceOf(kind: ChatBotSurfaceKind): string {
  return bubbleSurface(kind === 'out', kind === 'failed');
}

export function groupingOf(
  message: ChatBotMessage,
  prev?: ChatBotMessage,
  next?: ChatBotMessage
): MessageGrouping {
  const grouping = chatBotGrouping(message, prev, next);
  return { ...grouping, surface: surfaceOf(grouping.surfaceKind) };
}

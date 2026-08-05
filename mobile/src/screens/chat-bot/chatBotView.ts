import { chatBotGrouping } from '@ola/shared/lib';
import type { ChatBotMessage, ChatBotSurfaceKind } from '@ola/shared/types';
import { BOT_SURFACE_FAILED, BOT_SURFACE_IN, BOT_SURFACE_OUT } from './constants';
import type { MessageGrouping } from './interface';

export {
  chatBotIso as isoOf,
  pickChatBotSuggestions as pickSuggestions,
  renderableChatBotMessages as renderableMessages,
} from '@ola/shared/lib';

const SURFACES: Record<ChatBotSurfaceKind, string> = {
  out: BOT_SURFACE_OUT,
  in: BOT_SURFACE_IN,
  failed: BOT_SURFACE_FAILED,
};

export function groupingOf(
  message: ChatBotMessage,
  prev?: ChatBotMessage,
  next?: ChatBotMessage
): MessageGrouping {
  const grouping = chatBotGrouping(message, prev, next);
  return { ...grouping, surface: SURFACES[grouping.surfaceKind] };
}

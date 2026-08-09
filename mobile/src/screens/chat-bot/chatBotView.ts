import { chatBotGrouping } from '@ola/shared/lib';
import type { ChatBotMessage, ChatBotSurfaceKind } from '@ola/shared/types';
import { BOT_SURFACE_FAILED, BOT_SURFACE_IN } from './constants';
import type { MessageGrouping } from './interface';

export { chatBotIso as isoOf } from '@ola/shared/lib';

export function groupingOf(
  message: ChatBotMessage,
  outSurface: string,
  prev?: ChatBotMessage,
  next?: ChatBotMessage
): MessageGrouping {
  const grouping = chatBotGrouping(message, prev, next);
  const surfaces: Record<ChatBotSurfaceKind, string> = {
    out: outSurface,
    in: BOT_SURFACE_IN,
    failed: BOT_SURFACE_FAILED,
  };
  return { ...grouping, surface: surfaces[grouping.surfaceKind] };
}

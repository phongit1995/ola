import type { ChatBotGrouping } from '@ola/shared/types';

export type { ChatBotViewer } from '@ola/shared/types';

export type MessageGrouping = ChatBotGrouping & { surface: string };

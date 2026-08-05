import { fetchChatBotTransport } from '@ola/shared/services/chatBotFetchTransport';
import { streamChatBot as streamWithTransport } from '@services';
import type { StreamChatBotOptions } from '@services';

export { ChatBotStreamError } from '@services';

export function streamChatBot(
  options: Omit<StreamChatBotOptions, 'transport'>
): Promise<boolean> {
  return streamWithTransport({ ...options, transport: fetchChatBotTransport });
}

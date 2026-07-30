import { kulImageForText } from './kul';

interface MessageView {
  type?: string;
  content: string;
}

export interface ReplyExcerptLabels {
  image: string;
  audio: string;
  sticker: string;
}

function messageType(message: MessageView): string {
  return message.type ?? 'text';
}

export function isCopyableMessageText(message: MessageView): boolean {
  return (
    messageType(message) === 'text' &&
    message.content.trim() !== '' &&
    kulImageForText(message.content) == null
  );
}

export function messageReplyExcerpt(
  message: MessageView,
  labels: ReplyExcerptLabels,
): string {
  const type = messageType(message);
  if (type === 'image') return labels.image;
  if (type === 'audio') return labels.audio;
  return kulImageForText(message.content) != null
    ? labels.sticker
    : message.content;
}

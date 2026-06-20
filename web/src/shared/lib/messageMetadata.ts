export interface MessageMetadata {
  url?: string;
  duration?: number;
}

export function parseMessageMetadata(metadata?: string | null): MessageMetadata {
  if (metadata == null || metadata === '') return {};
  try {
    return JSON.parse(metadata) as MessageMetadata;
  } catch {
    return {};
  }
}

import type { ReactNode } from 'react';
import { SmileyText } from './SmileyText';

const POST_TOKEN_PATTERN = /(@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]|#[A-Za-z0-9_.]+)/g;

export function renderRichText(content: string, onMention: (nick: string) => void): ReactNode[] {
  return content.split(POST_TOKEN_PATTERN).map((part, index) => {
    if (part.startsWith('@')) {
      return (
        <button
          key={index}
          type="button"
          onClick={() => onMention(part.slice(1))}
          className="text-ola-primary-darker hover:underline"
        >
          {part}
        </button>
      );
    }
    if (part.startsWith('#')) {
      return (
        <span key={index} className="text-ola-primary-darker">
          {part}
        </span>
      );
    }
    return <SmileyText key={index} text={part} />;
  });
}

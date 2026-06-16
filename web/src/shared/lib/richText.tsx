import type { ReactNode } from 'react';
import { smileyImage } from './smileys';

const POST_TOKEN_PATTERN = /(@[A-Za-z0-9_]+|#[A-Za-z0-9_.]+|:ola\d{1,2}:)/g;

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
    const smiley = smileyImage(part);
    if (smiley != null) {
      return (
        <img
          key={index}
          src={smiley}
          alt={part}
          className="inline-block h-6 w-auto align-text-bottom"
        />
      );
    }
    return <span key={index}>{part}</span>;
  });
}

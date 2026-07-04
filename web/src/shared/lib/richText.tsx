import type { ReactNode } from 'react';
import { SmileyText } from './SmileyText';
import { URL_SOURCE, isUrlToken, renderUrlToken } from './urlText';

const POST_TOKEN_PATTERN = new RegExp(
  `(@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]|#[A-Za-z0-9_.]+|${URL_SOURCE})`,
  'g'
);

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
    if (isUrlToken(part)) {
      return renderUrlToken(part, index);
    }
    return <SmileyText key={index} text={part} />;
  });
}

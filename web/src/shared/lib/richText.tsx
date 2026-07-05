import type { ReactNode } from 'react';
import { SmileyText } from './SmileyText';
import { URL_SOURCE, isUrlToken, renderUrlToken } from './urlText';

const MENTION_SOURCE = '@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]';
const HASHTAG_SOURCE = '#[A-Za-z0-9_.]+';

const POST_TOKEN_PATTERN = new RegExp(
  `(${MENTION_SOURCE}|${HASHTAG_SOURCE}|${URL_SOURCE})`,
  'g'
);

const MENTION_TOKEN_PATTERN = new RegExp(`^(?:${MENTION_SOURCE})$`);
const HASHTAG_TOKEN_PATTERN = new RegExp(`^(?:${HASHTAG_SOURCE})$`);

export function renderRichText(content: string, onMention: (nick: string) => void): ReactNode[] {
  return content.split(POST_TOKEN_PATTERN).map((part, index) => {
    if (MENTION_TOKEN_PATTERN.test(part)) {
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
    if (HASHTAG_TOKEN_PATTERN.test(part)) {
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

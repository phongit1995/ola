import { useLayoutEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { POST_TOKEN_PATTERN } from '../constants';
import { smileyImage } from '../smileys';

interface PostContentProps {
  content: string;
  onMention: (nick: string) => void;
  leading?: ReactNode;
}

function renderTokens(content: string, onMention: (nick: string) => void): ReactNode[] {
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
          className="inline-block h-5 w-5 align-text-bottom"
        />
      );
    }
    return <span key={index}>{part}</span>;
  });
}

export function PostContent({ content, onMention, leading }: PostContentProps) {
  const { t } = useTranslation();
  const contentRef = useRef<HTMLParagraphElement>(null);
  const [expanded, setExpanded] = useState(false);
  const [clamped, setClamped] = useState(false);

  useLayoutEffect(() => {
    const el = contentRef.current;
    if (el == null) return;
    setClamped(el.scrollHeight > el.clientHeight + 1);
  }, [content]);

  return (
    <div className="flex items-start gap-2 px-4 pt-3">
      {leading}
      <div className="min-w-0 flex-1">
        <p
          ref={contentRef}
          className={`text-sm leading-relaxed whitespace-pre-wrap text-black/87 ${expanded ? '' : 'line-clamp-5'}`}
        >
          {renderTokens(content, onMention)}
        </p>
        {clamped && !expanded && (
          <button
            type="button"
            onClick={() => setExpanded(true)}
            className="mt-0.5 text-sm text-ola-primary-dark"
          >
            {t('me.seeMore')}
          </button>
        )}
      </div>
    </div>
  );
}

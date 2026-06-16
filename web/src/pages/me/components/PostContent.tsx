import { useLayoutEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { renderRichText } from '@lib';

interface PostContentProps {
  content: string;
  onMention: (nick: string) => void;
  leading?: ReactNode;
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
          {renderRichText(content, onMention)}
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

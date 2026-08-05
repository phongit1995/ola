import { memo, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import type { ReactNode } from 'react';
import { isUrlToken, renderUrlToken, toast } from '@lib';
import copyActionIcon from '@/assets/icons/chat/ic_menu_copy.svg';

const CODE_FENCE_PATTERN = /```([a-zA-Z0-9_+-]*)\n?([\s\S]*?)```/g;
const INLINE_PATTERN =
  /(\*\*[^*]+\*\*|`[^`]+`|https?:\/\/[^\s]+|www\.[^\s]+)/g;
const BULLET_PATTERN = /^\s*[*\-•]\s+/;
const NUMBERED_PATTERN = /^\s*(\d+)[.)]\s+/;
const HEADING_PATTERN = /^\s*#{1,6}\s+/;

function renderInline(text: string, keyPrefix: string): ReactNode[] {
  return text.split(INLINE_PATTERN).map((part, index) => {
    const key = `${keyPrefix}-${index}`;
    if (part.startsWith('**') && part.endsWith('**') && part.length > 4) {
      return (
        <strong key={key} className="font-semibold">
          {part.slice(2, -2)}
        </strong>
      );
    }
    if (part.startsWith('`') && part.endsWith('`') && part.length > 2) {
      return (
        <code
          key={key}
          className="rounded bg-black/8 px-1 py-0.5 font-mono text-[13px]"
        >
          {part.slice(1, -1)}
        </code>
      );
    }
    if (isUrlToken(part)) return renderUrlToken(part, index);
    return <span key={key}>{part}</span>;
  });
}

function CodeBlock({ code }: { code: string }) {
  const { t } = useTranslation();

  const copy = () => {
    void navigator.clipboard
      .writeText(code)
      .then(() => toast.success(t('chat.chatBotCodeCopied')))
      .catch(() => toast.error(t('chat.chatBotCodeCopyFailed')));
  };

  return (
    <div className="my-1 overflow-hidden rounded-lg bg-[#263238]">
      <div className="flex items-center justify-end border-b border-white/10 px-2 py-1">
        <button
          type="button"
          onClick={copy}
          aria-label={t('chat.chatBotCopyCode')}
          className="flex items-center gap-1 rounded px-1.5 py-0.5 text-[11px] text-white/70 hover:bg-white/10"
        >
          <img
            src={copyActionIcon}
            alt=""
            className="h-3.5 w-3.5 object-contain brightness-0 invert"
          />
          {t('chat.chatBotCopyCode')}
        </button>
      </div>
      <pre className="overflow-x-auto px-3 py-2 font-mono text-[12px] leading-relaxed text-[#eceff1]">
        {code}
      </pre>
    </div>
  );
}

function renderParagraphs(text: string, keyPrefix: string): ReactNode[] {
  const blocks: ReactNode[] = [];
  let bullets: string[] = [];

  const flushBullets = () => {
    if (bullets.length === 0) return;
    blocks.push(
      <ul key={`${keyPrefix}-ul-${blocks.length}`} className="my-0.5 pl-4">
        {bullets.map((item, index) => (
          <li key={index} className="list-disc">
            {renderInline(item, `${keyPrefix}-li-${index}`)}
          </li>
        ))}
      </ul>
    );
    bullets = [];
  };

  text.split('\n').forEach((line, index) => {
    const trimmed = line.trim();
    if (trimmed === '') {
      flushBullets();
      return;
    }
    if (BULLET_PATTERN.test(line)) {
      bullets.push(line.replace(BULLET_PATTERN, ''));
      return;
    }
    flushBullets();
    if (HEADING_PATTERN.test(line)) {
      blocks.push(
        <p key={`${keyPrefix}-h-${index}`} className="mt-1 font-semibold">
          {renderInline(line.replace(HEADING_PATTERN, ''), `${keyPrefix}-h-${index}`)}
        </p>
      );
      return;
    }
    const numbered = NUMBERED_PATTERN.exec(line);
    if (numbered != null) {
      blocks.push(
        <p key={`${keyPrefix}-n-${index}`} className="pl-1">
          <span className="font-semibold">{numbered[1]}. </span>
          {renderInline(line.replace(NUMBERED_PATTERN, ''), `${keyPrefix}-n-${index}`)}
        </p>
      );
      return;
    }
    blocks.push(
      <p key={`${keyPrefix}-p-${index}`}>
        {renderInline(line, `${keyPrefix}-p-${index}`)}
      </p>
    );
  });

  flushBullets();
  return blocks;
}

function buildBlocks(content: string): ReactNode[] {
  const parts: ReactNode[] = [];
  let cursor = 0;
  CODE_FENCE_PATTERN.lastIndex = 0;

  for (;;) {
    const match = CODE_FENCE_PATTERN.exec(content);
    if (match == null) break;
    const before = content.slice(cursor, match.index);
    if (before.trim() !== '') {
      parts.push(...renderParagraphs(before, `t${cursor}`));
    }
    parts.push(<CodeBlock key={`code-${match.index}`} code={match[2] ?? ''} />);
    cursor = match.index + match[0].length;
  }

  const tail = content.slice(cursor);
  if (tail.trim() !== '') parts.push(...renderParagraphs(tail, `t${cursor}`));

  return parts;
}

function BotMarkdownComponent({ content }: { content: string }) {
  const blocks = useMemo(() => buildBlocks(content), [content]);

  return <div className="space-y-0.5 break-words">{blocks}</div>;
}

export const BotMarkdown = memo(BotMarkdownComponent);

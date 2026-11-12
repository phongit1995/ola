import { Fragment, useEffect, useRef, useState, type ReactNode } from 'react';
import type { ChatMessageData } from '../../src/sdk';
import { CHAT_MAX_LENGTH, chatKeys } from '../helpers/chat';
import { UiIconButton } from './Ui';

export function ChatLog({ messages, className, empty, renderLine }: { messages: ChatMessageData[]; className: string; empty: ReactNode; renderLine: (msg: ChatMessageData) => ReactNode }) {
  const logRef = useRef<HTMLDivElement>(null);
  const keys = chatKeys(messages);

  useEffect(() => {
    logRef.current?.scrollTo({ top: logRef.current.scrollHeight });
  }, [messages]);

  return (
    <div ref={logRef} className={className} aria-live="polite">
      {messages.length === 0 ? empty : null}
      {messages.map((msg, index) => (
        <Fragment key={keys[index]}>{renderLine(msg)}</Fragment>
      ))}
    </div>
  );
}

export function ChatInput({ className, onSend }: { className: string; onSend: (text: string) => void }) {
  const [draft, setDraft] = useState('');

  const send = () => {
    if (!draft.trim()) return;
    onSend(draft);
    setDraft('');
  };

  return (
    <div className={className}>
      <input
        value={draft}
        maxLength={CHAT_MAX_LENGTH}
        placeholder="Nhập tin nhắn…"
        aria-label="Tin nhắn"
        onChange={(event) => setDraft(event.target.value)}
        onKeyDown={(event) => {
          if (event.key === 'Enter' && !event.nativeEvent.isComposing) send();
        }}
      />
      <UiIconButton icon="send" tone="gold" size="sm" label="Gửi" disabled={!draft.trim()} onClick={send} />
    </div>
  );
}

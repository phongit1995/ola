import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  SmileyInput,
  type ListOption,
  type SmileyInputHandle,
} from '@components';
import { useStickyScroll } from '@hooks';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import sendIcon from '@/assets/icons/chat/ic_action_send_white.png';
import { chatBotHistory } from '@services';
import type { ChatBotErrorCode, ChatBotMessage } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useChatBotStore } from '@/store/chatBotStore';
import { ChatBotStreamError, streamChatBot } from '../chatBotStream';
import { BotMarkdown } from './BotMarkdown';

const SUGGESTION_KEYS = [
  'chat.chatBotSuggestion1',
  'chat.chatBotSuggestion2',
  'chat.chatBotSuggestion3',
] as const;

const ERROR_KEYS = {
  auth: 'chat.chatBotErrorAuth',
  rateLimited: 'chat.chatBotErrorRateLimited',
  upstream: 'chat.chatBotErrorUpstream',
  network: 'chat.chatBotErrorNetwork',
  emptyPrompt: 'chat.chatBotErrorUpstream',
} as const satisfies Record<ChatBotErrorCode, string>;

function TypingDots() {
  return (
    <span className="flex items-center gap-1 py-1">
      {[0, 1, 2].map((index) => (
        <span
          key={index}
          className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/35"
          style={{ animationDelay: `${index * 150}ms` }}
        />
      ))}
    </span>
  );
}

interface BubbleProps {
  message: ChatBotMessage;
  streaming: boolean;
}

function Bubble({ message, streaming }: BubbleProps) {
  const isUser = message.role === 'user';
  const surface = isUser ? 'bg-[#dcedc8]' : 'bg-white shadow-sm';
  const waiting = streaming && message.content === '';

  return (
    <div className={`flex px-3 py-0.5 ${isUser ? 'justify-end' : 'justify-start'}`}>
      <div
        className={`max-w-[300px] rounded-2xl px-3 py-2 text-sm text-black/87 ${surface}`}
      >
        {isUser ? (
          <span className="break-words whitespace-pre-wrap">{message.content}</span>
        ) : waiting ? (
          <TypingDots />
        ) : (
          <>
            <BotMarkdown content={message.content} />
            {streaming && (
              <span className="ml-0.5 inline-block h-4 w-0.5 animate-pulse bg-black/60 align-middle" />
            )}
          </>
        )}
      </div>
    </div>
  );
}

interface ChatBotViewProps {
  onClose: () => void;
}

export function ChatBotView({ onClose }: ChatBotViewProps) {
  const { t, i18n } = useTranslation();
  const userId = useAuthStore((s) => s.user?.id ?? null);
  const messages = useChatBotStore((s) => s.messages);
  const activeTurnId = useChatBotStore((s) => s.activeTurnId);
  const error = useChatBotStore((s) => s.error);
  const beginTurn = useChatBotStore((s) => s.beginTurn);
  const appendDelta = useChatBotStore((s) => s.appendDelta);
  const finishTurn = useChatBotStore((s) => s.finishTurn);
  const failTurn = useChatBotStore((s) => s.failTurn);
  const dropLastTurn = useChatBotStore((s) => s.dropLastTurn);
  const syncOwner = useChatBotStore((s) => s.syncOwner);
  const clear = useChatBotStore((s) => s.clear);
  const streaming = activeTurnId != null;

  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [clearOpen, setClearOpen] = useState(false);
  const composerRef = useRef<SmileyInputHandle>(null);
  const abortRef = useRef<AbortController | null>(null);

  const last = messages.at(-1) ?? null;
  const { scrollRef, handleScroll, scrollToBottomIfPinned } = useStickyScroll({
    count: messages.length,
    lastId: last?.id ?? null,
    hasMore: false,
    loadingMore: false,
    onLoadMore: () => undefined,
  });

  useEffect(() => {
    syncOwner(userId);
  }, [syncOwner, userId]);

  useEffect(() => {
    scrollToBottomIfPinned();
  }, [last?.content.length, scrollToBottomIfPinned]);

  useEffect(() => () => abortRef.current?.abort(), []);

  async function run(prompt: string) {
    const turnId = beginTurn(prompt);
    const controller = new AbortController();
    abortRef.current = controller;
    const history = chatBotHistory(useChatBotStore.getState().messages);

    try {
      const completed = await streamChatBot({
        messages: history,
        language: i18n.language,
        signal: controller.signal,
        onDelta: (delta) => appendDelta(turnId, delta),
      });
      if (completed) finishTurn(turnId);
    } catch (streamError) {
      failTurn(
        turnId,
        streamError instanceof ChatBotStreamError ? streamError.code : 'upstream'
      );
    } finally {
      if (abortRef.current === controller) abortRef.current = null;
    }
  }

  function send() {
    const prompt = draft.trim();
    if (prompt === '' || streaming) return;
    setDraft('');
    composerRef.current?.reset();
    void run(prompt);
  }

  function stop() {
    if (activeTurnId == null) return;
    abortRef.current?.abort();
    abortRef.current = null;
    finishTurn(activeTurnId);
  }

  function retry() {
    const prompt = dropLastTurn();
    if (prompt == null) return;
    void run(prompt);
  }

  const menuOptions: ListOption[] = [
    {
      key: 'clear',
      label: t('chat.chatBotClear'),
      danger: true,
      onSelect: () => setClearOpen(true),
    },
  ];

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={t('chat.chatBot')} onBack={onClose} align="center">
        <button
          type="button"
          aria-label={t('common.menu')}
          onClick={() => setMenuOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <img src={moreIcon} alt="" className="h-5 w-5 object-contain" />
        </button>
      </ScreenHeader>

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto bg-[#f3f3f3] py-2"
      >
        {messages.length === 0 ? (
          <div className="flex h-full flex-col items-center justify-center px-8 text-center">
            <span className="flex h-14 w-14 items-center justify-center rounded-2xl bg-ola-primary text-lg font-bold text-white">
              AI
            </span>
            <p className="mt-3 text-sm text-black/54">
              {t('chat.chatBotEmptyTitle')}
            </p>
            <div className="mt-4 flex w-full flex-col gap-2">
              {SUGGESTION_KEYS.map((key) => (
                <button
                  key={key}
                  type="button"
                  onClick={() => void run(t(key))}
                  className="rounded-full border border-black/12 bg-white px-4 py-2 text-sm text-black/70"
                >
                  {t(key)}
                </button>
              ))}
            </div>
          </div>
        ) : (
          <>
            {messages.map((message) => (
              <Bubble
                key={message.id}
                message={message}
                streaming={streaming && message.id === last?.id}
              />
            ))}
            {error != null && (
              <div className="flex flex-col items-center gap-2 py-3">
                <span className="rounded-lg bg-[#f8d7d7] px-3 py-2 text-xs text-black/70">
                  {t(ERROR_KEYS[error])}
                </span>
                <button
                  type="button"
                  onClick={retry}
                  className="rounded-full bg-ola-primary px-4 py-1.5 text-xs font-bold text-white"
                >
                  {t('chat.chatBotRetry')}
                </button>
              </div>
            )}
          </>
        )}
      </div>

      {streaming && (
        <div className="flex shrink-0 justify-center border-t border-black/12 bg-white py-1.5">
          <button
            type="button"
            onClick={stop}
            className="rounded-full border border-black/20 px-4 py-1 text-xs text-black/70"
          >
            {t('chat.chatBotStop')}
          </button>
        </div>
      )}

      <div className="relative flex min-h-12 shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5">
        <div className="min-w-0 flex-1">
          <SmileyInput
            ref={composerRef}
            value={draft}
            onChange={setDraft}
            onEnter={send}
            placeholder={t('chat.chatBotPlaceholder')}
            disabled={streaming}
            multiline
          />
        </div>
        <button
          type="button"
          onClick={send}
          disabled={streaming || draft.trim() === ''}
          aria-label={t('chat.send')}
          className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-ola-primary disabled:opacity-40"
        >
          <img
            src={sendIcon}
            alt=""
            className="h-5 w-5 object-contain brightness-0 invert"
          />
        </button>
      </div>

      <ListOptionDialog
        open={menuOpen}
        title={t('chat.chatBot')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      <ConfirmDialog
        open={clearOpen}
        danger
        title={t('chat.chatBotClear')}
        message={t('chat.chatBotClearConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          setClearOpen(false);
          abortRef.current?.abort();
          abortRef.current = null;
          clear();
        }}
        onCancel={() => setClearOpen(false)}
      />
    </FullScreenOverlay>
  );
}

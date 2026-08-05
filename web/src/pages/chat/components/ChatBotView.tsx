import { Fragment, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  DateSeparator,
  FullScreenOverlay,
  ScreenHeader,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import { useStickyScroll } from '@hooks';
import { colorForName, formatClockHM, isSameDay } from '@lib';
import deleteIcon from '@/assets/icons/chat/ic_menu_delete.png';
import sendIcon from '@/assets/icons/chat/ic_action_send_white.png';
import chatBotAvatar from '@/assets/icons/chat/ic_chat_bot_ola.png';
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
  'chat.chatBotSuggestion4',
  'chat.chatBotSuggestion5',
  'chat.chatBotSuggestion6',
  'chat.chatBotSuggestion7',
  'chat.chatBotSuggestion8',
  'chat.chatBotSuggestion9',
  'chat.chatBotSuggestion10',
  'chat.chatBotSuggestion11',
  'chat.chatBotSuggestion12',
  'chat.chatBotSuggestion13',
  'chat.chatBotSuggestion14',
  'chat.chatBotSuggestion15',
  'chat.chatBotSuggestion16',
  'chat.chatBotSuggestion17',
  'chat.chatBotSuggestion18',
  'chat.chatBotSuggestion19',
  'chat.chatBotSuggestion20',
] as const;

const VISIBLE_SUGGESTIONS = 3;

function pickSuggestions(): (typeof SUGGESTION_KEYS)[number][] {
  const pool = [...SUGGESTION_KEYS];
  for (let index = pool.length - 1; index > 0; index -= 1) {
    const swap = Math.floor(Math.random() * (index + 1));
    [pool[index], pool[swap]] = [pool[swap]!, pool[index]!];
  }
  return pool.slice(0, VISIBLE_SUGGESTIONS);
}

const ERROR_KEYS = {
  auth: 'chat.chatBotErrorAuth',
  rateLimited: 'chat.chatBotErrorRateLimited',
  upstream: 'chat.chatBotErrorUpstream',
  network: 'chat.chatBotErrorNetwork',
  emptyPrompt: 'chat.chatBotErrorUpstream',
} as const satisfies Record<ChatBotErrorCode, string>;

function isoOf(createdAt: number): string {
  return new Date(createdAt).toISOString();
}

function BotAvatar({ name }: { name: string }) {
  return (
    <img
      src={chatBotAvatar}
      alt={name}
      className="h-8 w-8 shrink-0 rounded-full object-cover"
    />
  );
}

function TypingRow({ name }: { name: string }) {
  return (
    <div className="mt-1 flex items-end gap-1">
      <span className="shrink-0 self-start">
        <BotAvatar name={name} />
      </span>
      <div className="flex items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3 shadow-sm">
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40" />
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:150ms]" />
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:300ms]" />
      </div>
    </div>
  );
}

interface BotMessageRowProps {
  message: ChatBotMessage;
  prev?: ChatBotMessage;
  next?: ChatBotMessage;
  botName: string;
  meName: string;
  meColor: string;
  meAvatar?: string;
}

function BotMessageRow({
  message,
  prev,
  next,
  botName,
  meName,
  meColor,
  meAvatar,
}: BotMessageRowProps) {
  const isOut = message.role === 'user';
  const boundary = prev == null;
  const firstInGroup = boundary || prev.role !== message.role;
  const lastInGroup = next == null || next.role !== message.role;
  const time = formatClockHM(isoOf(message.createdAt));
  const showTime =
    lastInGroup || formatClockHM(isoOf(next.createdAt)) !== time;
  const failed = message.status === 'failed';

  const surface = failed
    ? 'bg-[#f8d7d7]'
    : isOut
      ? 'bg-[#dcedc8]'
      : 'bg-white shadow-sm';
  const groupCorners = isOut
    ? `${firstInGroup ? '' : 'rounded-tr-sm'} ${lastInGroup ? '' : 'rounded-br-sm'}`
    : `${firstInGroup ? '' : 'rounded-tl-sm'} ${lastInGroup ? '' : 'rounded-bl-sm'}`;

  return (
    <div className={`flex flex-col ${firstInGroup && !boundary ? 'mt-2' : ''}`}>
      <div className={`flex items-end gap-1 ${isOut ? 'flex-row-reverse' : ''}`}>
        {isOut ? (
          firstInGroup ? (
            <span className="shrink-0 self-start">
              <Avatar
                name={meName}
                color={meColor}
                src={meAvatar}
                size={32}
              />
            </span>
          ) : (
            <span className="w-8 shrink-0" />
          )
        ) : firstInGroup ? (
          <span className="shrink-0 self-start">
            <BotAvatar name={botName} />
          </span>
        ) : (
          <span className="w-8 shrink-0" />
        )}
        <div className={`flex max-w-[78%] flex-col ${isOut ? 'items-end' : ''}`}>
          <div
            className={`flex items-center gap-2 ${isOut ? 'flex-row-reverse' : ''}`}
          >
            <div
              className={`rounded-2xl px-3 py-2 text-sm text-black/87 ${groupCorners} ${surface}`}
            >
              {isOut ? (
                <span className="break-words whitespace-pre-wrap">
                  {message.content}
                </span>
              ) : (
                <BotMarkdown content={message.content} />
              )}
            </div>
            {showTime && (
              <span className="shrink-0 text-[10px] text-black/38">{time}</span>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

interface ChatBotViewProps {
  onClose: () => void;
}

export function ChatBotView({ onClose }: ChatBotViewProps) {
  const { t, i18n } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const userId = me?.id ?? null;
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
  const [clearOpen, setClearOpen] = useState(false);
  const composerRef = useRef<SmileyInputHandle>(null);
  const abortRef = useRef<AbortController | null>(null);

  const botName = t('chat.chatBot');
  const suggestions = useMemo(() => pickSuggestions(), []);
  const last = messages.at(-1) ?? null;
  const visible = messages.filter((message) => message.content !== '');
  const waiting = streaming && (last?.content ?? '') === '';

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
  }, [last?.content.length, waiting, scrollToBottomIfPinned]);

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

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader
        title={botName}
        subtitle={streaming ? t('chat.chatBotThinking') : undefined}
        onBack={onClose}
        left={<BotAvatar name={botName} />}
      >
        <button
          type="button"
          aria-label={t('chat.chatBotClear')}
          onClick={() => setClearOpen(true)}
          disabled={messages.length === 0}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15 disabled:opacity-40"
        >
          <img
            src={deleteIcon}
            alt=""
            className="h-5 w-5 object-contain brightness-0 invert"
          />
        </button>
      </ScreenHeader>

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        className="flex flex-1 flex-col gap-0.5 overflow-x-hidden overflow-y-auto bg-[#ECE5DD] px-2 py-3"
      >
        {visible.length === 0 && !waiting ? (
          <div className="flex flex-1 flex-col items-center justify-center px-8 text-center">
            <img
              src={chatBotAvatar}
              alt=""
              className="h-16 w-16 rounded-full object-cover shadow-sm"
            />
            <p className="mt-3 text-sm text-black/54">
              {t('chat.chatBotEmptyTitle')}
            </p>
          </div>
        ) : (
          <>
            {visible.map((message, index) => {
              const prev = visible[index - 1];
              const showDate = !isSameDay(
                isoOf(prev?.createdAt ?? 0),
                isoOf(message.createdAt)
              );
              return (
                <Fragment key={message.id}>
                  {showDate && <DateSeparator iso={isoOf(message.createdAt)} />}
                  <BotMessageRow
                    message={message}
                    prev={prev}
                    next={visible[index + 1]}
                    botName={botName}
                    meName={me?.username ?? ''}
                    meColor={colorForName(me?.username ?? '')}
                    meAvatar={me?.avatar}
                  />
                </Fragment>
              );
            })}
            {waiting && <TypingRow name={botName} />}
            {error != null && (
              <div className="mt-2 flex flex-col items-center gap-2">
                <span className="rounded-full bg-black/45 px-3 py-1 text-[11px] text-white">
                  {t(ERROR_KEYS[error])}
                </span>
                <button
                  type="button"
                  onClick={retry}
                  className="rounded-full bg-white px-4 py-1.5 text-xs font-bold text-ola-primary shadow-sm active:scale-95"
                >
                  {t('chat.chatBotRetry')}
                </button>
              </div>
            )}
          </>
        )}
      </div>

      {visible.length === 0 && !waiting && (
        <div className="flex shrink-0 gap-2 overflow-x-auto scrollbar-none border-t border-black/12 bg-white px-2 py-2">
          {suggestions.map((key) => (
            <button
              key={key}
              type="button"
              onClick={() => void run(t(key))}
              className="shrink-0 rounded-full border border-black/12 bg-[#f3f3f3] px-3 py-1.5 text-xs whitespace-nowrap text-black/70 active:scale-95"
            >
              {t(key)}
            </button>
          ))}
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
          onClick={streaming ? stop : send}
          disabled={!streaming && draft.trim() === ''}
          aria-label={streaming ? t('chat.chatBotStop') : t('chat.send')}
          className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-ola-primary transition-opacity disabled:opacity-40"
        >
          {streaming ? (
            <span className="h-3.5 w-3.5 rounded-[2px] bg-white" />
          ) : (
            <img
              src={sendIcon}
              alt=""
              className="h-5 w-5 object-contain brightness-0 invert"
            />
          )}
        </button>
      </div>

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

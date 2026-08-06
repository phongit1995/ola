import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { chatBotHistory } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatBotStore } from '@ola/shared/stores/chatBotStore';
import type { ChatBotMessage, ChatBotType } from '@ola/shared/types';
import type { ChatComposerHandle } from '@components/ChatComposer';
import { ChatBotStreamError, streamChatBot } from './chatBotStream';
import { pickSuggestions, renderableMessages } from './chatBotView';

export function useChatBotConversation(bot: ChatBotType) {
  const { i18n } = useTranslation();
  const userId = useAuthStore((s) => s.user?.id ?? null);
  const messages = useChatBotStore((s) => s.conversations[bot].messages);
  const activeTurnId = useChatBotStore(
    (s) => s.conversations[bot].activeTurnId
  );
  const error = useChatBotStore((s) => s.conversations[bot].error);
  const beginTurn = useChatBotStore((s) => s.beginTurn);
  const appendDelta = useChatBotStore((s) => s.appendDelta);
  const finishTurn = useChatBotStore((s) => s.finishTurn);
  const failTurn = useChatBotStore((s) => s.failTurn);
  const dropLastTurn = useChatBotStore((s) => s.dropLastTurn);
  const syncOwner = useChatBotStore((s) => s.syncOwner);
  const clear = useChatBotStore((s) => s.clear);

  const [draft, setDraft] = useState('');
  const [suggestions] = useState(() => pickSuggestions(bot));
  const composerRef = useRef<ChatComposerHandle>(null);
  const abortRef = useRef<AbortController | null>(null);

  const streaming = activeTurnId != null;
  const last = messages.at(-1) ?? null;
  const visible = useMemo(() => renderableMessages(messages), [messages]);
  const waiting = streaming && (last?.content ?? '') === '';

  const list = useStickyBottomList<ChatBotMessage>();
  const { requestScrollToBottom, scrollToBottomIfStuck } = list;

  useEffect(() => {
    if (userId == null) return;
    syncOwner(userId);
  }, [syncOwner, userId]);

  useEffect(() => {
    requestScrollToBottom();
  }, [messages.length, requestScrollToBottom]);

  useEffect(() => {
    scrollToBottomIfStuck();
  }, [last?.content.length, waiting, scrollToBottomIfStuck]);

  useEffect(
    () => () => {
      abortRef.current?.abort();
      abortRef.current = null;
      const pending =
        useChatBotStore.getState().conversations[bot].activeTurnId;
      if (pending != null) useChatBotStore.getState().finishTurn(bot, pending);
    },
    [bot]
  );

  const run = useCallback(
    async (prompt: string) => {
      const turnId = beginTurn(bot, prompt);
      const controller = new AbortController();
      abortRef.current = controller;
      const history = chatBotHistory(
        useChatBotStore.getState().conversations[bot].messages
      );

      try {
        const completed = await streamChatBot({
          bot,
          messages: history,
          language: i18n.language,
          signal: controller.signal,
          onDelta: (delta) => appendDelta(bot, turnId, delta),
        });
        if (completed) finishTurn(bot, turnId);
      } catch (streamError) {
        failTurn(
          bot,
          turnId,
          streamError instanceof ChatBotStreamError
            ? streamError.code
            : 'upstream'
        );
      } finally {
        if (abortRef.current === controller) abortRef.current = null;
      }
    },
    [appendDelta, beginTurn, bot, failTurn, finishTurn, i18n.language]
  );

  const ask = useCallback(
    (prompt: string) => {
      if (prompt.trim() === '' || streaming) return;
      void run(prompt.trim());
    },
    [run, streaming]
  );

  const send = useCallback(() => {
    const prompt = draft.trim();
    if (prompt === '' || streaming) return;
    setDraft('');
    void run(prompt);
  }, [draft, run, streaming]);

  const stop = useCallback(() => {
    if (activeTurnId == null) return;
    abortRef.current?.abort();
    abortRef.current = null;
    finishTurn(bot, activeTurnId);
  }, [activeTurnId, bot, finishTurn]);

  const retry = useCallback(() => {
    const prompt = dropLastTurn(bot);
    if (prompt == null) return;
    void run(prompt);
  }, [bot, dropLastTurn, run]);

  const clearHistory = useCallback(() => {
    abortRef.current?.abort();
    abortRef.current = null;
    clear(bot);
  }, [bot, clear]);

  return {
    messages,
    visible,
    suggestions,
    streaming,
    waiting,
    error,
    draft,
    setDraft,
    composerRef,
    list,
    ask,
    send,
    stop,
    retry,
    clearHistory,
  };
}

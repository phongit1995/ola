import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import i18n from 'i18next';
import {
  pickChatBotSuggestions,
  renderableChatBotMessages,
} from '../../lib/chatBotView';
import { chatBotHistory } from '../../services/chatBot.service';
import { streamChatBot } from '../../services/chatBotStream';
import {
  ChatBotStreamError,
  type ChatBotTransport,
} from '../../services/chatBotTransport';
import type { ChatBotType } from '../../types/client/chatBot.type';
import { useAuthStore } from '../auth/authStore';
import { useChatBotStore } from './chatBotStore';

export function useChatBotTurns(bot: ChatBotType, transport: ChatBotTransport) {
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

  const [suggestions] = useState(() => pickChatBotSuggestions(bot));
  const abortRef = useRef<AbortController | null>(null);

  const streaming = activeTurnId != null;
  const last = messages.at(-1) ?? null;
  const visible = useMemo(() => renderableChatBotMessages(messages), [messages]);
  const waiting = streaming && (last?.content ?? '') === '';

  useEffect(() => {
    if (userId == null) return;
    syncOwner(userId);
  }, [syncOwner, userId]);

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
          transport,
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
    [appendDelta, beginTurn, bot, failTurn, finishTurn, transport]
  );

  const ask = useCallback(
    (prompt: string) => {
      if (prompt.trim() === '' || streaming) return;
      void run(prompt.trim());
    },
    [run, streaming]
  );

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
    ask,
    stop,
    retry,
    clearHistory,
  };
}

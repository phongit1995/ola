import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { chatBotHistory } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatBotStore } from '@ola/shared/stores/chatBotStore';
import type { ChatBotMessage } from '@ola/shared/types';
import type { ChatComposerHandle } from '@components/ChatComposer';
import { ChatBotStreamError, streamChatBot } from './chatBotStream';
import { pickSuggestions, renderableMessages } from './chatBotView';

export function useChatBotConversation() {
  const { i18n } = useTranslation();
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

  const [draft, setDraft] = useState('');
  const [suggestions] = useState(pickSuggestions);
  const composerRef = useRef<ChatComposerHandle>(null);
  const abortRef = useRef<AbortController | null>(null);

  const streaming = activeTurnId != null;
  const last = messages.at(-1) ?? null;
  const visible = useMemo(() => renderableMessages(messages), [messages]);
  const waiting = streaming && (last?.content ?? '') === '';

  const list = useStickyBottomList<ChatBotMessage>();
  const { requestScrollToBottom } = list;

  useEffect(() => {
    if (userId == null) return;
    syncOwner(userId);
  }, [syncOwner, userId]);

  useEffect(() => {
    requestScrollToBottom();
  }, [last?.content.length, waiting, requestScrollToBottom]);

  useEffect(
    () => () => {
      abortRef.current?.abort();
      abortRef.current = null;
      const pending = useChatBotStore.getState().activeTurnId;
      if (pending != null) useChatBotStore.getState().finishTurn(pending);
    },
    []
  );

  const run = useCallback(
    async (prompt: string) => {
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
          streamError instanceof ChatBotStreamError
            ? streamError.code
            : 'upstream'
        );
      } finally {
        if (abortRef.current === controller) abortRef.current = null;
      }
    },
    [appendDelta, beginTurn, failTurn, finishTurn, i18n.language]
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
    finishTurn(activeTurnId);
  }, [activeTurnId, finishTurn]);

  const retry = useCallback(() => {
    const prompt = dropLastTurn();
    if (prompt == null) return;
    void run(prompt);
  }, [dropLastTurn, run]);

  const clearHistory = useCallback(() => {
    abortRef.current?.abort();
    abortRef.current = null;
    clear();
  }, [clear]);

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

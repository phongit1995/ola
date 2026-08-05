import { useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { SmileyInputHandle } from '@components';
import { useStickyScroll } from '@hooks';
import { chatBotHistory } from '@services';
import { useAuthStore } from '@/store/authStore';
import { useChatBotStore } from '@/store/chatBotStore';
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
  const composerRef = useRef<SmileyInputHandle>(null);
  const abortRef = useRef<AbortController | null>(null);

  const streaming = activeTurnId != null;
  const last = messages.at(-1) ?? null;
  const visible = useMemo(() => renderableMessages(messages), [messages]);
  const waiting = streaming && (last?.content ?? '') === '';
  const suggestions = useMemo(() => pickSuggestions(), []);

  const { scrollRef, handleScroll, scrollToBottomIfPinned } = useStickyScroll({
    count: messages.length,
    lastId: last?.id ?? null,
    hasMore: false,
    loadingMore: false,
    onLoadMore: () => undefined,
  });

  useEffect(() => {
    if (userId == null) return;
    syncOwner(userId);
  }, [syncOwner, userId]);

  useEffect(() => {
    scrollToBottomIfPinned();
  }, [last?.content.length, waiting, scrollToBottomIfPinned]);

  useEffect(
    () => () => {
      abortRef.current?.abort();
      abortRef.current = null;
      const pending = useChatBotStore.getState().activeTurnId;
      if (pending != null) useChatBotStore.getState().finishTurn(pending);
    },
    []
  );

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

  function ask(prompt: string) {
    if (prompt.trim() === '' || streaming) return;
    void run(prompt.trim());
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

  function clearHistory() {
    abortRef.current?.abort();
    abortRef.current = null;
    clear();
  }

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
    scrollRef,
    handleScroll,
    ask,
    send,
    stop,
    retry,
    clearHistory,
  };
}

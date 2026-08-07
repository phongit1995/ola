import { useEffect, useRef, useState } from 'react';
import type { SmileyInputHandle } from '@components';
import { useStickyScroll } from '@hooks';
import { fetchChatBotTransport } from '@ola/shared/services/chatBotFetchTransport';
import { useChatBotTurns } from '@ola/shared/stores/chat-bot/useChatBotTurns';
import type { ChatBotType } from '@app-types';

export function useChatBotConversation(bot: ChatBotType) {
  const turns = useChatBotTurns(bot, fetchChatBotTransport);
  const { ask, messages, streaming, waiting } = turns;
  const [draft, setDraft] = useState('');
  const composerRef = useRef<SmileyInputHandle>(null);

  const last = messages.at(-1) ?? null;
  const { scrollRef, handleScroll, scrollToBottomIfPinned } = useStickyScroll({
    count: messages.length,
    lastId: last?.id ?? null,
  });

  useEffect(() => {
    scrollToBottomIfPinned();
  }, [last?.content.length, waiting, scrollToBottomIfPinned]);

  function send() {
    const prompt = draft.trim();
    if (prompt === '' || streaming) return;
    setDraft('');
    composerRef.current?.reset();
    ask(prompt);
  }

  return {
    ...turns,
    draft,
    setDraft,
    composerRef,
    scrollRef,
    handleScroll,
    send,
  };
}

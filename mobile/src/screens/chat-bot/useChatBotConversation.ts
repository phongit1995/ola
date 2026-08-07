import { useCallback, useEffect, useRef, useState } from 'react';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { xhrChatBotTransport } from '@ola/shared/services/chatBotXhrTransport';
import { useChatBotTurns } from '@ola/shared/stores/chat-bot/useChatBotTurns';
import type { ChatBotMessage, ChatBotType } from '@ola/shared/types';
import type { ChatComposerHandle } from '@components/ChatComposer';

export function useChatBotConversation(bot: ChatBotType) {
  const turns = useChatBotTurns(bot, xhrChatBotTransport);
  const { ask, messages, streaming, waiting } = turns;
  const [draft, setDraft] = useState('');
  const composerRef = useRef<ChatComposerHandle>(null);

  const list = useStickyBottomList<ChatBotMessage>();
  const { requestScrollToBottom, scrollToBottomIfStuck } = list;
  const last = messages.at(-1) ?? null;

  useEffect(() => {
    requestScrollToBottom();
  }, [messages.length, requestScrollToBottom]);

  useEffect(() => {
    scrollToBottomIfStuck();
  }, [last?.content.length, waiting, scrollToBottomIfStuck]);

  const send = useCallback(() => {
    const prompt = draft.trim();
    if (prompt === '' || streaming) return;
    setDraft('');
    ask(prompt);
  }, [ask, draft, streaming]);

  return {
    ...turns,
    draft,
    setDraft,
    composerRef,
    list,
    send,
  };
}

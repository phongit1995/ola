import { useEffect, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../../assets';
import { useCaro } from '../../../store/useCaro';
import { useBoard } from '../useBoard';

export function BoardChat() {
  const chatLogRef = useRef<HTMLDivElement>(null);
  const { chatInput, setChatInput, resetChat } = useBoard(
    useShallow((state) => ({
      chatInput: state.chatInput,
      setChatInput: state.setChatInput,
      resetChat: state.resetChat,
    })),
  );
  const { messages, matchSeq, boardMode, roomWaiting, result, sendChat } = useCaro(
    useShallow((state) => ({
      messages: state.messages,
      matchSeq: state.matchSeq,
      boardMode: state.boardMode,
      roomWaiting: state.roomWaiting,
      result: state.result,
      sendChat: state.sendChat,
    })),
  );
  const pregame = boardMode === 'pregame';
  const playing = boardMode === 'playing';
  const roomFull = roomWaiting?.members.length === 2;
  const chatEnabled = result == null && (playing || (pregame && roomFull));

  useEffect(() => {
    resetChat();
  }, [matchSeq, resetChat]);

  useEffect(() => {
    const log = chatLogRef.current;
    if (log) log.scrollTop = log.scrollHeight;
  }, [messages.length]);

  const send = (): void => {
    sendChat(chatInput);
    setChatInput('');
  };

  return (
    <div id="chatbox" style={assetBg('chatFrame')}>
      <div id="chat-log" ref={chatLogRef}>
        {messages.map((message) => (
          <div key={message.id} className="chat-msg">
            {message.who && <span className="chat-who">{message.who}: </span>}
            {message.text}
          </div>
        ))}
      </div>
      <form
        id="chat-input-row"
        onSubmit={(event) => {
          event.preventDefault();
          send();
        }}
      >
        <input
          id="chat-input"
          type="text"
          autoComplete="off"
          maxLength={120}
          disabled={!chatEnabled}
          placeholder={pregame && !roomFull ? 'CHỜ ĐỦ HAI NGƯỜI...' : 'NHẬP TIN NHẮN...'}
          value={chatInput}
          onChange={(event) => setChatInput(event.target.value)}
        />
        <button type="submit" className="chat-send" aria-label="Gửi" disabled={!chatEnabled}>
          <img src={assetSrc('sendIcon')} alt="" />
        </button>
      </form>
    </div>
  );
}

import { useEffect, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../../assets';
import { useCaro } from '../../../store/useCaro';
import { useBoard } from '../useBoard';
import { ReactionPicker } from './ReactionPicker';

export function BoardChat() {
  const chatLogRef = useRef<HTMLDivElement>(null);
  const reactionAreaRef = useRef<HTMLDivElement>(null);
  const { chatInput, reactionOpen, setChatInput, setReactionOpen, resetChat } = useBoard(
    useShallow((state) => ({
      chatInput: state.chatInput,
      reactionOpen: state.reactionOpen,
      setChatInput: state.setChatInput,
      setReactionOpen: state.setReactionOpen,
      resetChat: state.resetChat,
    })),
  );
  const { messages, matchSeq, boardMode, roomWaiting, result, sendChat, sendReaction } = useCaro(
    useShallow((state) => ({
      messages: state.messages,
      matchSeq: state.matchSeq,
      boardMode: state.boardMode,
      roomWaiting: state.roomWaiting,
      result: state.result,
      sendChat: state.sendChat,
      sendReaction: state.sendReaction,
    })),
  );
  const pregame = boardMode === 'pregame';
  const playing = boardMode === 'playing';
  const roomFull = roomWaiting?.members.length === 2;
  const chatEnabled = result == null && (playing || (pregame && roomFull));
  const reactionEnabled = result == null && playing;

  useEffect(() => {
    resetChat();
  }, [matchSeq, resetChat]);

  useEffect(() => {
    const log = chatLogRef.current;
    if (log) log.scrollTop = log.scrollHeight;
  }, [messages.length]);

  useEffect(() => {
    if (!reactionOpen) return;
    const closeOnOutsidePress = (event: PointerEvent): void => {
      if (!reactionAreaRef.current?.contains(event.target as Node)) setReactionOpen(false);
    };
    document.addEventListener('pointerdown', closeOnOutsidePress);
    return () => document.removeEventListener('pointerdown', closeOnOutsidePress);
  }, [reactionOpen, setReactionOpen]);

  useEffect(() => {
    if (!reactionEnabled && reactionOpen) setReactionOpen(false);
  }, [reactionEnabled, reactionOpen, setReactionOpen]);

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
        {reactionEnabled && (
          <div className="caro-reaction-area" ref={reactionAreaRef}>
            <button
              type="button"
              className="caro-reaction-trigger"
              aria-label="Gửi cảm xúc"
              aria-haspopup="dialog"
              aria-expanded={reactionOpen}
              aria-controls="caro-reaction-picker"
              onClick={() => setReactionOpen(!reactionOpen)}
            >
              <img src={assetSrc('reactionIcon')} alt="" />
            </button>
            <ReactionPicker
              open={reactionOpen}
              onClose={() => setReactionOpen(false)}
              onPick={(type) => {
                sendReaction(type);
                setReactionOpen(false);
              }}
            />
          </div>
        )}
        <button type="submit" className="chat-send" aria-label="Gửi tin nhắn" disabled={!chatEnabled}>
          <img src={assetSrc('sendIcon')} alt="" />
        </button>
      </form>
    </div>
  );
}

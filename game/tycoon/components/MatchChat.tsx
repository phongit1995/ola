import { useEffect, useRef, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { GAME_REACTION_TYPE, type GameReactionType } from '../../src/sdk';
import likeUrl from '../../caro/assets/reactions/like.webp';
import loveUrl from '../../caro/assets/reactions/love.webp';
import hahaUrl from '../../caro/assets/reactions/haha.webp';
import wowUrl from '../../caro/assets/reactions/wow.webp';
import sadUrl from '../../caro/assets/reactions/sad.webp';
import angryUrl from '../../caro/assets/reactions/angry.webp';
import { chatAuthor } from '../helpers/chat';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { BottomSheet } from './BottomSheet';
import { ChatInput, ChatLog } from './ChatLog';

const REACTION_COOLDOWN_MS = 1500;
const BUBBLE_MS = 2200;

export const REACTIONS: ReadonlyArray<{ type: GameReactionType; label: string; src: string }> = [
  { type: GAME_REACTION_TYPE.Like, label: 'Thích', src: likeUrl },
  { type: GAME_REACTION_TYPE.Love, label: 'Yêu thích', src: loveUrl },
  { type: GAME_REACTION_TYPE.Haha, label: 'Haha', src: hahaUrl },
  { type: GAME_REACTION_TYPE.Wow, label: 'Wow', src: wowUrl },
  { type: GAME_REACTION_TYPE.Sad, label: 'Buồn', src: sadUrl },
  { type: GAME_REACTION_TYPE.Angry, label: 'Tức giận', src: angryUrl },
];

const REACTION_SRC = new Map(REACTIONS.map((item) => [item.type, item.src]));

export function ChatSheet() {
  const { matchChat, players, you, closeSheet, sendMatchChat, sendReaction } = useTycoon(
    useShallow((s) => ({ matchChat: s.matchChat, players: s.players, you: s.you, closeSheet: s.closeSheet, sendMatchChat: s.sendMatchChat, sendReaction: s.sendReaction })),
  );
  const [cooling, setCooling] = useState(false);
  const meId = players[you]?.id;

  useEffect(() => {
    if (!cooling) return;
    const timer = setTimeout(() => setCooling(false), REACTION_COOLDOWN_MS);
    return () => clearTimeout(timer);
  }, [cooling]);

  const react = (type: GameReactionType) => {
    if (cooling) return;
    sendReaction(type);
    setCooling(true);
    closeSheet();
  };

  return (
    <BottomSheet title="Trò chuyện trong ván" onClose={closeSheet} tall>
      <h2 className="ui-title ty-sheet-head">Trò chuyện</h2>
      <div className="ty-chat-reactions" role="group" aria-label="Thả cảm xúc">
        {REACTIONS.map((item) => (
          <button key={item.type} type="button" aria-label={item.label} title={item.label} disabled={cooling} onClick={() => react(item.type)}>
            <img src={item.src} alt="" draggable={false} />
          </button>
        ))}
      </div>
      <ChatLog
        messages={matchChat}
        className="ty-chat-log"
        empty={<p className="ty-sheet-desc">Chưa có tin nhắn nào.</p>}
        renderLine={(msg) => {
          const seat = players.findIndex((p) => p.id === msg.userId);
          return (
            <p className="ty-chat-line">
              <i className="ty-seat-badge" style={{ background: seat >= 0 ? seatColor(seat) : undefined }} aria-hidden="true" />
              <b style={{ color: seat >= 0 ? seatColor(seat) : undefined }}>{chatAuthor(msg, meId)}:</b> {msg.text}
            </p>
          );
        }}
      />
      <ChatInput className="ty-wait-input ty-chat-input" onSend={sendMatchChat} />
    </BottomSheet>
  );
}

interface Bubble {
  seq: number;
  src: string;
  left: number;
  top: number;
}

export function ReactionBubbles() {
  const reactionFx = useTycoon((s) => s.reactionFx);
  const [bubbles, setBubbles] = useState<Bubble[]>([]);
  const timers = useRef(new Set<ReturnType<typeof setTimeout>>());

  useEffect(() => {
    const pending = timers.current;
    return () => pending.forEach((timer) => clearTimeout(timer));
  }, []);

  useEffect(() => {
    if (!reactionFx) return;
    const src = REACTION_SRC.get(reactionFx.type);
    const pod = document.querySelector<HTMLElement>(`[data-pod="${reactionFx.seat}"]`);
    if (!src || !pod) return;
    const rect = pod.getBoundingClientRect();
    const bubble = { seq: reactionFx.seq, src, left: rect.left + rect.width / 2, top: rect.top };
    setBubbles((items) => [...items.slice(-5), bubble]);
    const timer = setTimeout(() => {
      timers.current.delete(timer);
      setBubbles((items) => items.filter((item) => item.seq !== bubble.seq));
    }, BUBBLE_MS);
    timers.current.add(timer);
  }, [reactionFx]);

  return (
    <div className="ty-react-layer" aria-hidden="true">
      {bubbles.map((bubble) => (
        <img key={bubble.seq} className="ty-react-bubble" src={bubble.src} alt="" draggable={false} style={{ left: bubble.left, top: bubble.top } as CSSProperties} />
      ))}
    </div>
  );
}

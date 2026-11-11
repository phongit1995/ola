import { useEffect, useRef, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { RoomStateData } from '../../src/sdk';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import { TyIcon } from '../components/TyIcon';
import { MoneyBadge, UiAvatar, UiButton, UiIconButton } from '../components/Ui';
import { MIN_PLAYERS } from '../logic/constants';
import { avatarIconUrl, seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';

const CHAT_MAX_LENGTH = 120;

function RoomSeats({ room, selfId, onKick }: { room: RoomStateData; selfId: string; onKick?: (userId: string) => void }) {
  return (
    <ul className="ty-wait-seats">
      {Array.from({ length: room.maxPlayers ?? 4 }, (_, seat) => {
        const member = room.members[seat];
        if (!member) {
          return (
            <li key={`empty-${seat}`} className="ty-wait-seat ty-wait-seat-empty">
              <span className="ty-wait-plus" aria-hidden="true">
                <TyIcon name="plus" size={18} />
              </span>
              <span>Ghế trống</span>
            </li>
          );
        }
        const self = member.id === selfId;
        return (
          <li key={member.id} className={`ty-wait-seat ${member.ready || member.owner ? 'ty-wait-seat-on' : ''}`} style={{ '--seat': seatColor(seat) } as CSSProperties}>
            {onKick && !member.owner ? <UiIconButton icon="user-minus" size="sm" label={`Mời @${member.name} ra khỏi bàn`} className="ty-wait-kick" onClick={() => onKick(member.id)} /> : null}
            <UiAvatar src={avatarIconUrl(member.vipType)} size={52} ring={seatColor(seat)} />
            <b className="ty-wait-name">
              @{member.name}
              {self ? <small> (bạn)</small> : null}
            </b>
            {member.owner ? (
              <span className="ty-wait-badge ty-wait-badge-owner">Chủ bàn</span>
            ) : member.ready ? (
              <span className="ty-wait-badge ty-wait-badge-ready">
                <TyIcon name="check" size={12} />
                Sẵn sàng
              </span>
            ) : (
              <span className="ty-wait-badge">Chưa sẵn sàng</span>
            )}
          </li>
        );
      })}
    </ul>
  );
}

function RoomChat({ room, selfId }: { room: RoomStateData; selfId: string }) {
  const { roomChat, sendRoomChat } = useTycoon(useShallow((s) => ({ roomChat: s.roomChat, sendRoomChat: s.sendRoomChat })));
  const [draft, setDraft] = useState('');
  const logRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    logRef.current?.scrollTo({ top: logRef.current.scrollHeight });
  }, [roomChat]);

  const send = () => {
    if (!draft.trim()) return;
    sendRoomChat(draft);
    setDraft('');
  };

  return (
    <section className="ui-panel ty-wait-chat" aria-label="Trò chuyện trong bàn">
      <div ref={logRef} className="ty-wait-log" aria-live="polite">
        {roomChat.length === 0 ? <p className="ty-wait-hint">Trò chuyện với người trong bàn…</p> : null}
        {roomChat.map((msg) => (
          <p key={`${msg.userId}-${msg.sentAt}`} className="ty-wait-line">
            <b className={msg.userId === room.ownerId ? 'ty-wait-owner' : undefined}>{msg.userId === selfId ? 'Bạn' : `@${msg.name}`}:</b> {msg.text}
          </p>
        ))}
      </div>
      <div className="ty-wait-input">
        <input
          value={draft}
          maxLength={CHAT_MAX_LENGTH}
          placeholder="Nhập tin nhắn…"
          aria-label="Tin nhắn"
          onChange={(event) => setDraft(event.target.value)}
          onKeyDown={(event) => {
            if (event.key === 'Enter') send();
          }}
        />
        <UiIconButton icon="send" tone="gold" size="sm" label="Gửi" disabled={!draft.trim()} onClick={send} />
      </div>
    </section>
  );
}

export function RoomScreen() {
  const { room, profile, leaveRoom, setReady, startRoom, kickMember } = useTycoon(
    useShallow((s) => ({ room: s.room, profile: s.profile, leaveRoom: s.leaveRoom, setReady: s.setReady, startRoom: s.startRoom, kickMember: s.kickMember })),
  );
  if (!room) return null;
  const selfId = room.youId || profile?.id || '';
  const isOwner = room.ownerId === selfId;
  const me = room.members.find((member) => member.id === selfId);
  const owner = room.members.find((member) => member.owner);
  const guests = room.members.filter((member) => !member.owner);
  const readyGuests = guests.filter((member) => member.ready).length;
  const canStart = room.members.length >= MIN_PLAYERS && readyGuests === guests.length;
  const maxPlayers = room.maxPlayers ?? 4;

  return (
    <div className="ty-wait" style={{ '--ty-lb-bg': `url(${bgUrl})` } as CSSProperties}>
      <header className="ty-wait-top">
        <UiIconButton icon="arrow-left" size="sm" label="Rời bàn" onClick={leaveRoom} />
        <span className="ty-wait-title">
          <b>Bàn của @{owner?.name ?? '?'}</b>
          <span className="ty-wait-meta">
            <span className="ui-chip">
              {room.members.length}/{maxPlayers} người
            </span>
            {room.bet > 0 ? <MoneyBadge amount={room.bet} className="ui-chip" /> : <span className="ui-chip">Giao lưu</span>}
            {room.locked ? (
              <span className="ui-chip" aria-label="Bàn có mật khẩu">
                <TyIcon name="lock" size={14} />
              </span>
            ) : null}
          </span>
        </span>
      </header>

      <RoomSeats room={room} selfId={selfId} onKick={isOwner ? kickMember : undefined} />

      <RoomChat room={room} selfId={selfId} />

      <footer className="ty-wait-actions">
        <UiButton onClick={leaveRoom}>Rời bàn</UiButton>
        {isOwner ? (
          <UiButton tone="gold" disabled={!canStart} onClick={startRoom}>
            {canStart ? 'Bắt đầu' : room.members.length < MIN_PLAYERS ? 'Chờ thêm người' : `Bắt đầu (${readyGuests}/${guests.length} sẵn sàng)`}
          </UiButton>
        ) : (
          <UiButton tone={me?.ready ? 'paper' : 'gold'} icon={me?.ready ? 'check' : undefined} onClick={() => setReady(!me?.ready)}>
            {me?.ready ? 'Bỏ sẵn sàng' : 'Sẵn sàng'}
          </UiButton>
        )}
      </footer>
    </div>
  );
}

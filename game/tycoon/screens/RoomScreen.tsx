import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { RoomStateData } from '../../src/sdk';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import { ChatInput, ChatLog } from '../components/ChatLog';
import { RoomIcon } from '../components/RoomIcon';
import { TyIcon } from '../components/TyIcon';
import { KenBadge, UiAvatar, UiButton, UiIconButton } from '../components/Ui';
import { MIN_PLAYERS } from '../logic/constants';
import { chatAuthor } from '../helpers/chat';
import { avatarIconUrl, seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';

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
            <UiAvatar src={avatarIconUrl(member.vipType)} size={60} ring={seatColor(seat)} />
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

  return (
    <section className="ui-panel ty-wait-chat" aria-label="Trò chuyện trong bàn">
      <h2 className="ty-wait-chat-head">
        <TyIcon name="chat" size={16} />
        Trò chuyện
      </h2>
      <ChatLog
        messages={roomChat}
        className="ty-wait-log"
        empty={<p className="ty-wait-hint">Chưa có tin nhắn. Chào mọi người trong bàn nhé!</p>}
        renderLine={(msg) => (
          <p className="ty-wait-line">
            <b className={msg.userId === room.ownerId ? 'ty-wait-owner' : undefined}>{chatAuthor(msg, selfId)}:</b> {msg.text}
          </p>
        )}
      />
      <ChatInput className="ty-wait-input" onSend={sendRoomChat} />
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
        <button type="button" className="ty-rooms-round" aria-label="Rời bàn" onClick={leaveRoom}>
          <RoomIcon name="chevron-left" />
        </button>
        <span className="ty-wait-title">
          <b>Bàn của @{owner?.name ?? '?'}</b>
          <span className="ty-wait-meta">
            <span className="ui-chip">
              {room.members.length}/{maxPlayers} người
            </span>
            {room.bet > 0 ? (
              <KenBadge amount={room.bet} className="ui-chip" />
            ) : (
              <span className="ui-chip">Giao lưu</span>
            )}
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

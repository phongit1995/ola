import { useEffect, useRef, useState } from 'react';
import backIcon from '../../assets/icons/ic-back.svg';
import checkIcon from '../../assets/icons/ic-check.svg';
import crownIcon from '../../assets/icons/ic-crown.svg';
import eyeIcon from '../../assets/icons/ic-eye.svg';
import lockIcon from '../../assets/icons/ic-lock.svg';
import plusIcon from '../../assets/icons/ic-plus.svg';
import sendIcon from '../../assets/icons/ic-send.svg';
import userMinusIcon from '../../assets/icons/ic-user-minus.svg';
import type { RoomStateData } from '../../../src/sdk';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import { PlayerName } from '../../components/PlayerName';
import { MicIcon, SeatVoice, SpeakerButton } from '../../components/VoiceControls';
import { ROOM_SEATS, canCloseSeat, formatKen, roomSeatSlots } from '../../helpers/room';
import { useThirteen } from '../../store/useThirteen';

function roomSummary(room: RoomStateData): string {
  const maxPlayers = room.maxPlayers ?? ROOM_SEATS;
  return `${room.members.length}/${maxPlayers} người · ${formatKen(room.bet)} Ken${room.locked ? ' · Có mật khẩu' : ''}`;
}

interface RoomSeatsProps {
  room: RoomStateData;
  selfId: string;
  onKick?: (userId: string) => void;
  onSeats?: (maxPlayers: number) => void;
}

function ClosedSeat({ onOpen }: { onOpen?: () => void }) {
  const body = (
    <>
      <div className="tl-seat-plus">
        <img src={lockIcon} alt="" />
      </div>
      <span>Ghế đóng</span>
      {onOpen && <small className="tl-seat-hint">Chạm để mở</small>}
    </>
  );
  return onOpen ? (
    <button type="button" className="tl-seat tl-seat-closed" onClick={onOpen} aria-label="Mở ghế">
      {body}
    </button>
  ) : (
    <div className="tl-seat tl-seat-closed">{body}</div>
  );
}

function RoomSeats({ room, selfId, onKick, onSeats }: RoomSeatsProps) {
  const maxPlayers = room.maxPlayers ?? ROOM_SEATS;
  const slots = roomSeatSlots(room.members.length, room.maxPlayers);
  const lastOpen = slots.map((slot) => slot.kind).lastIndexOf('open');
  const firstClosed = slots.findIndex((slot) => slot.kind === 'closed');
  const closeSeat = onSeats && canCloseSeat(room.members.length, maxPlayers) ? () => onSeats(maxPlayers - 1) : undefined;
  return (
    <div className="tl-seat-grid">
      {slots.map((slot, i) => {
        if (slot.kind === 'closed') {
          return <ClosedSeat key={`closed-${i}`} onOpen={onSeats && i === firstClosed ? () => onSeats(maxPlayers + 1) : undefined} />;
        }
        if (slot.kind === 'open') {
          return (
            <div key={`empty-${i}`} className="tl-seat tl-seat-empty">
              {closeSeat && i === lastOpen && (
                <button type="button" className="tl-kick-btn tl-seat-lock-btn" aria-label="Đóng ghế" onClick={closeSeat}>
                  <img src={lockIcon} alt="" />
                </button>
              )}
              <div className="tl-seat-plus">
                <img src={plusIcon} alt="" />
              </div>
              <span>Ghế trống</span>
            </div>
          );
        }
        const member = room.members[slot.index];
        return (
          <div key={member.id} className={'tl-seat' + (member.owner ? ' owner' : '')}>
            {member.owner && <img className="tl-crown" src={crownIcon} alt="Chủ bàn" />}
            {onKick && !member.owner && (
              <button type="button" className="tl-kick-btn" aria-label={`Mời ${member.name} rời bàn`} onClick={() => onKick(member.id)}>
                <img src={userMinusIcon} alt="" />
              </button>
            )}
            <span className="tl-voice-anchor">
              <PlayerAvatar name={member.name} vipType={member.vipType} size="lg" />
              <SeatVoice userId={member.id} name={member.name} self={member.id === selfId} />
            </span>
            <span className="tl-seat-name">
              <PlayerName name={member.name} self={member.id === selfId} />
            </span>
            {member.owner ? (
              <span className="tl-badge tl-badge-gold">Chủ bàn</span>
            ) : member.ready ? (
              <span className="tl-badge tl-badge-green">
                <img src={checkIcon} alt="" /> Đã sẵn sàng
              </span>
            ) : (
              <span className="tl-badge">Chưa sẵn sàng</span>
            )}
          </div>
        );
      })}
    </div>
  );
}

function VoiceTopbarSlot() {
  const voiceOn = useThirteen((s) => s.voice.status !== 'off');
  return voiceOn ? <SpeakerButton /> : <span className="tl-topbar-spacer" />;
}

function RoomChatLog({ room, selfId, empty }: { room: RoomStateData; selfId: string; empty: string }) {
  const roomChat = useThirteen((s) => s.roomChat);
  const logRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    logRef.current?.scrollTo({ top: logRef.current.scrollHeight });
  }, [roomChat]);

  return (
    <div ref={logRef} className="tl-room-chat-log">
      {roomChat.length === 0 && <span className="tl-chat-hint">{empty}</span>}
      {roomChat.map((msg) => (
        <div key={`${msg.userId}-${msg.sentAt}`} className="tl-chat-line">
          <b>
            <PlayerName name={msg.name} self={msg.userId === selfId} owner={msg.userId === room.ownerId} />
            {msg.spectator && <span className="tl-chat-viewer-tag">xem</span>}:
          </b>{' '}
          {msg.text}
        </div>
      ))}
    </div>
  );
}

function RoomChatInput({ placeholder }: { placeholder: string }) {
  const sendRoomChatText = useThirteen((s) => s.sendRoomChatText);
  const [draft, setDraft] = useState('');
  const send = (): void => {
    if (!draft.trim()) return;
    sendRoomChatText(draft);
    setDraft('');
  };
  return (
    <div className="tl-chat-input-row">
      <input
        className="tl-input"
        value={draft}
        maxLength={120}
        placeholder={placeholder}
        onChange={(e) => setDraft(e.target.value)}
        onKeyDown={(e) => e.key === 'Enter' && send()}
      />
      <button type="button" className="tl-btn tl-btn-gold tl-send-btn" disabled={!draft.trim()} onClick={send}>
        <span>Gửi</span>
        <img src={sendIcon} alt="" />
      </button>
    </div>
  );
}

function WatchedRoomScreen() {
  const room = useThirteen((s) => s.watchedRoom);
  const stopWatching = useThirteen((s) => s.stopWatching);
  const joinWatchedRoom = useThirteen((s) => s.joinWatchedRoom);

  if (!room) return null;
  const freeSeat = room.members.length < (room.maxPlayers ?? ROOM_SEATS);
  const waitingFor = room.members.filter((m) => !m.owner && !m.ready).length;

  return (
    <div className="tl-screen tl-room tl-room-watch">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={stopWatching} aria-label="Rời xem">
          <img src={backIcon} alt="" />
        </button>
        <div className="tl-room-title">
          <span className="tl-watch-title">
            <img src={eyeIcon} alt="" />
            Đang xem bàn chờ
          </span>
          <small>{roomSummary(room)}</small>
        </div>
        <VoiceTopbarSlot />
      </div>

      <RoomSeats room={room} selfId="" />

      <p className="tl-room-watch-status" role="status">
        {waitingFor > 0 ? `Đang chờ ${waitingFor} người sẵn sàng` : 'Chờ chủ bàn bắt đầu ván mới'}
        <span>Ván mới bắt đầu bạn sẽ được xem tiếp</span>
      </p>

      <div className="tl-room-chat">
        <RoomChatLog room={room} selfId="" empty="Chưa có ai trò chuyện..." />
        <RoomChatInput placeholder="Nhắn với bàn (bạn đang xem)..." />
      </div>

      <div className="tl-room-actions">
        <button type="button" className="tl-btn tl-btn-ghost" onClick={stopWatching}>
          Rời xem
        </button>
        {freeSeat ? (
          <button type="button" className="tl-btn tl-btn-gold" onClick={joinWatchedRoom}>
            Vào chơi
          </button>
        ) : (
          <button type="button" className="tl-btn tl-btn-disabled" disabled>
            Bàn đã đủ người
          </button>
        )}
      </div>
    </div>
  );
}

function MemberRoomScreen() {
  const room = useThirteen((s) => s.room);
  const user = useThirteen((s) => s.user);
  const leaveRoom = useThirteen((s) => s.leaveRoom);
  const setReady = useThirteen((s) => s.setReady);
  const startRoom = useThirteen((s) => s.startRoom);
  const kickMember = useThirteen((s) => s.kickMember);
  const setRoomSeats = useThirteen((s) => s.setRoomSeats);

  if (!room || !user) return null;
  const isOwner = room.ownerId === user.id;
  const me = room.members.find((m) => m.id === user.id);
  const readyGuests = room.members.filter((m) => !m.owner && m.ready).length;
  const guests = room.members.length - 1;
  const canStart = room.members.length >= 2 && readyGuests === guests;

  return (
    <div className="tl-screen tl-room">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={leaveRoom} aria-label="Rời bàn">
          <img src={backIcon} alt="" />
        </button>
        <div className="tl-room-title">
          <span className="tl-room-title-text">
            Bàn chờ
            {room.voice && <MicIcon className="tl-room-voice" />}
          </span>
          <small>{roomSummary(room)}</small>
        </div>
        <VoiceTopbarSlot />
      </div>

      <RoomSeats
        room={room}
        selfId={user.id}
        onKick={isOwner ? kickMember : undefined}
        onSeats={isOwner ? setRoomSeats : undefined}
      />

      <div className="tl-room-chat">
        <RoomChatLog room={room} selfId={user.id} empty="Trò chuyện với người trong bàn..." />
        <RoomChatInput placeholder="Nhập tin nhắn..." />
      </div>

      <div className="tl-room-actions">
        <button type="button" className="tl-btn tl-btn-ghost" onClick={leaveRoom}>
          Rời bàn
        </button>
        {isOwner ? (
          <button
            type="button"
            className={'tl-btn ' + (canStart ? 'tl-btn-gold' : 'tl-btn-disabled')}
            disabled={!canStart}
            onClick={startRoom}
          >
            {canStart ? 'Bắt đầu' : `Bắt đầu (${readyGuests}/${guests || 1} sẵn sàng)`}
          </button>
        ) : (
          <button
            type="button"
            className={'tl-btn ' + (me?.ready ? 'tl-btn-ghost' : 'tl-btn-gold')}
            onClick={() => setReady(!me?.ready)}
          >
            {me?.ready && <img className="tl-ready-check" src={checkIcon} alt="" />}
            {me?.ready ? 'Bỏ sẵn sàng' : 'Sẵn sàng'}
          </button>
        )}
      </div>
    </div>
  );
}

export function RoomScreen() {
  const watching = useThirteen((s) => s.watchingRoomId !== '');
  return watching ? <WatchedRoomScreen /> : <MemberRoomScreen />;
}

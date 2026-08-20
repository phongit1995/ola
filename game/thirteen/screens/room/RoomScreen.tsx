import { useState } from 'react';
import { useThirteen } from '../../store/useThirteen';

export function RoomScreen() {
  const room = useThirteen((s) => s.room);
  const user = useThirteen((s) => s.user);
  const roomChat = useThirteen((s) => s.roomChat);
  const leaveRoom = useThirteen((s) => s.leaveRoom);
  const setReady = useThirteen((s) => s.setReady);
  const startRoom = useThirteen((s) => s.startRoom);
  const kickMember = useThirteen((s) => s.kickMember);
  const sendRoomChatText = useThirteen((s) => s.sendRoomChatText);
  const [draft, setDraft] = useState('');

  if (!room || !user) return null;
  const maxPlayers = room.maxPlayers ?? 4;
  const isOwner = room.ownerId === user.id;
  const me = room.members.find((m) => m.id === user.id);
  const readyGuests = room.members.filter((m) => !m.owner && m.ready).length;
  const guests = room.members.length - 1;
  const canStart = room.members.length >= 2 && readyGuests === guests;

  const send = (): void => {
    sendRoomChatText(draft);
    setDraft('');
  };

  return (
    <div className="tl-screen tl-room">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={leaveRoom} aria-label="Rời bàn">
          ←
        </button>
        <div className="tl-room-title">
          <span>Bàn chờ</span>
          <small>
            {room.members.length}/{maxPlayers} người{room.locked ? ' · Có mật khẩu' : ''}
          </small>
        </div>
        <span className="tl-topbar-spacer" />
      </div>

      <div className="tl-seat-grid">
        {Array.from({ length: maxPlayers }, (_, i) => {
          const member = room.members[i];
          if (!member) {
            return (
              <div key={`empty-${i}`} className="tl-seat tl-seat-empty">
                <div className="tl-seat-plus">+</div>
                <span>Ghế trống</span>
              </div>
            );
          }
          return (
            <div key={member.id} className={'tl-seat' + (member.owner ? ' owner' : '')}>
              {member.owner && <span className="tl-crown">♛</span>}
              {isOwner && !member.owner && (
                <button
                  type="button"
                  className="tl-kick-btn"
                  aria-label={`Mời ${member.name} rời bàn`}
                  onClick={() => kickMember(member.id)}
                >
                  ×
                </button>
              )}
              <span className="tl-avatar tl-avatar-lg">{member.name.charAt(0).toUpperCase()}</span>
              <span className="tl-seat-name">{member.id === user.id ? 'Bạn' : member.name}</span>
              {member.owner ? (
                <span className="tl-badge tl-badge-gold">Chủ bàn</span>
              ) : member.ready ? (
                <span className="tl-badge tl-badge-green">Đã sẵn sàng</span>
              ) : (
                <span className="tl-badge">Chưa sẵn sàng</span>
              )}
            </div>
          );
        })}
      </div>

      <div className="tl-room-chat">
        <div className="tl-room-chat-log">
          {roomChat.length === 0 && <span className="tl-chat-hint">Trò chuyện với người trong bàn...</span>}
          {roomChat.map((msg) => (
            <div key={`${msg.userId}-${msg.sentAt}`} className="tl-chat-line">
              <b>{msg.userId === user.id ? 'Bạn' : msg.name}:</b> {msg.text}
            </div>
          ))}
        </div>
        <div className="tl-chat-input-row">
          <input
            className="tl-input"
            value={draft}
            maxLength={120}
            placeholder="Nhập tin nhắn..."
            onChange={(e) => setDraft(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && send()}
          />
          <button type="button" className="tl-btn tl-btn-gold" onClick={send}>
            Gửi
          </button>
        </div>
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
            {me?.ready ? 'Bỏ sẵn sàng' : 'Sẵn sàng'}
          </button>
        )}
      </div>
    </div>
  );
}

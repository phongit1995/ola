import { useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { RoomInfo } from '../../../../src/sdk';
import { assetBg } from '../../../assets';
import { ROOM_PASSWORD_MAX_LENGTH } from '../../../helpers/room';
import { handleDialogKeyDown, useDialogFocus } from '../../../helpers/dialog';
import { useRanked } from '../useRanked';

interface JoinRoomModalProps {
  room: RoomInfo | null;
  onClose: () => void;
  onSubmit: (roomId: string, password: string) => void;
}

export function JoinRoomModal({ room, onClose, onSubmit }: JoinRoomModalProps) {
  const inputRef = useRef<HTMLInputElement>(null);
  const cardRef = useRef<HTMLDivElement>(null);
  const { passInput, setPassInput } = useRanked(
    useShallow((state) => ({
      passInput: state.passInput,
      setPassInput: state.setPassInput,
    })),
  );

  const submit = (): void => {
    if (room) onSubmit(room.id, passInput.trim());
  };

  useDialogFocus(room != null, cardRef, inputRef);

  return (
    <div
      id="ranked-pass-modal"
      className={room ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="join-room-title"
      onClick={(event) => event.target === event.currentTarget && onClose()}
      onKeyDown={(event) => handleDialogKeyDown(event, cardRef, onClose)}
    >
      <div ref={cardRef} id="pass-card">
        <h3 id="join-room-title">Bàn có khóa</h3>
        <div className="create-input" style={assetBg('createInputFrame')}>
          <input
            id="pass-input"
            ref={inputRef}
            type="text"
            autoComplete="off"
            placeholder="Nhập mật khẩu"
            maxLength={ROOM_PASSWORD_MAX_LENGTH}
            value={passInput}
            onChange={(event) => setPassInput(event.target.value)}
            onKeyDown={(event) => event.key === 'Enter' && submit()}
          />
        </div>
        <div className="pass-actions">
          <button type="button" id="pass-ok" onClick={submit}>
            Vào bàn
          </button>
          <button type="button" id="pass-cancel" onClick={onClose}>
            Hủy
          </button>
        </div>
      </div>
    </div>
  );
}

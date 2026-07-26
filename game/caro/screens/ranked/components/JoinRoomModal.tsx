import { useShallow } from 'zustand/react/shallow';
import type { RoomInfo } from '../../../../src/sdk';
import { assetBg } from '../../../assets';
import { useRanked } from '../useRanked';

interface JoinRoomModalProps {
  room: RoomInfo | null;
  onClose: () => void;
  onSubmit: (roomId: string, password: string) => void;
}

export function JoinRoomModal({ room, onClose, onSubmit }: JoinRoomModalProps) {
  const { passInput, setPassInput } = useRanked(
    useShallow((state) => ({
      passInput: state.passInput,
      setPassInput: state.setPassInput,
    })),
  );

  const submit = (): void => {
    if (room) onSubmit(room.id, passInput);
  };

  return (
    <div
      id="ranked-pass-modal"
      className={room ? '' : 'hidden'}
      onClick={(event) => event.target === event.currentTarget && onClose()}
    >
      <div id="pass-card">
        <h3>Bàn có khóa</h3>
        <div className="create-input" style={assetBg('createInputFrame')}>
          <input
            id="pass-input"
            type="text"
            autoComplete="off"
            placeholder="Nhập mật khẩu"
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

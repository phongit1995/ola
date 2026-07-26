import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { useRanked } from '../useRanked';

interface CreateRoomModalProps {
  open: boolean;
  onClose: () => void;
  onSubmit: (bet: number, password?: string) => void;
}

export function CreateRoomModal({ open, onClose, onSubmit }: CreateRoomModalProps) {
  const { bet, createPassword, setBet, setCreatePassword } = useRanked(
    useShallow((state) => ({
      bet: state.bet,
      createPassword: state.createPassword,
      setBet: state.setBet,
      setCreatePassword: state.setCreatePassword,
    })),
  );

  const submit = (): void => {
    const amount = Number(bet.replace(/\D/g, '')) || 0;
    onSubmit(amount, createPassword.trim() || undefined);
  };

  return (
    <div
      id="ranked-create-modal"
      className={open ? '' : 'hidden'}
      onClick={(event) => event.target === event.currentTarget && onClose()}
    >
      <div id="create-card" style={assetBg('createPanel')}>
        <div className="create-title" style={assetBg('createTitleFrame')}>
          <span>Tạo bàn</span>
        </div>
        <button type="button" id="create-close" style={assetBg('createBtnClose')} aria-label="Đóng" onClick={onClose}>
          <img src={assetSrc('createIcX')} alt="" />
        </button>
        <div className="create-body">
          <div className="create-label" style={assetBg('createLabelFrame')}>
            <span>Số Ken</span>
          </div>
          <div className="create-input" style={assetBg('createInputFrame')}>
            <input
              id="create-bet"
              type="text"
              inputMode="numeric"
              value={bet}
              onChange={(event) => {
                const digits = event.target.value.replace(/\D/g, '');
                setBet(digits ? formatKen(Number(digits)) : '0');
              }}
            />
          </div>
          <div className="create-label" style={assetBg('createLabelFrame')}>
            <span>Mật khẩu</span>
          </div>
          <div className="create-input" style={assetBg('createInputFrame')}>
            <input
              id="create-password"
              type="text"
              autoComplete="off"
              placeholder="Để trống nếu không khóa"
              value={createPassword}
              onChange={(event) => setCreatePassword(event.target.value)}
            />
          </div>
        </div>
        <button type="button" id="create-ok" style={assetBg('createBtnOk')} onClick={submit}>
          <span>OK</span>
        </button>
      </div>
    </div>
  );
}

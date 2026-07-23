import { useRef, useState } from 'react';
import type { RoomInfo } from '../src/sdk';
import { assetBg, assetSrc } from './assets';
import { useCaroStore } from './store';

const PAGE_SIZE = 9;
const HEAD_BOTTOM = 10.5;
const ROW_HEIGHT = 8.85;

const MOCK_ROOMS: RoomInfo[] = [
  { id: 'm1', owner: 'toilabot', bet: 1000, locked: false, players: 1 },
  { id: 'm2', owner: 'pain', bet: 5000, locked: true, players: 1 },
  { id: 'm3', owner: 'vua_caro', bet: 20000, locked: false, players: 2, full: true },
  { id: 'm4', owner: 'meomeo', bet: 0, locked: false, players: 1 },
  { id: 'm5', owner: 'songlong', bet: 12345, locked: true, players: 2, full: true },
  { id: 'm6', owner: 'caro_pro', bet: 500, locked: false, players: 1 },
  { id: 'm7', owner: 'hoa_mua_he', bet: 2000, locked: true, players: 1 },
  { id: 'm8', owner: 'bot_hunter', bet: 99999, locked: false, players: 1 },
  { id: 'm9', owner: 'kien_con', bet: 100, locked: false, players: 1 },
  { id: 'm10', owner: 'thach_dau', bet: 7777, locked: false, players: 1 },
  { id: 'm11', owner: 'tay_choi_moi', bet: 0, locked: false, players: 1 },
  { id: 'm12', owner: 'co_thu_lang', bet: 3000, locked: true, players: 1 },
];

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function Ranked() {
  const visible = useCaroStore((s) => s.rankedVisible);
  const onExit = useCaroStore((s) => s.toLobby);
  const [page, setPage] = useState(0);
  const [createOpen, setCreateOpen] = useState(false);
  const [passRoom, setPassRoom] = useState<RoomInfo | null>(null);
  const [waiting, setWaiting] = useState<{ show: boolean; bet: number }>({ show: false, bet: 0 });
  const [bet, setBet] = useState('0');
  const [createPassword, setCreatePassword] = useState('');
  const [passInput, setPassInput] = useState('');
  const [toast, setToast] = useState<string | null>(null);
  const toastTimer = useRef<number | undefined>(undefined);

  const rooms = MOCK_ROOMS;
  const pageCount = Math.max(1, Math.ceil(rooms.length / PAGE_SIZE));
  const visibleRooms = rooms.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);

  const showToast = (message: string): void => {
    setToast(message);
    window.clearTimeout(toastTimer.current);
    toastTimer.current = window.setTimeout(() => setToast(null), 2200);
  };

  const attemptJoin = (room: RoomInfo): void => {
    if (room.locked) {
      setPassRoom(room);
      setPassInput('');
      return;
    }
    showToast(`(mock) Vào bàn của ${room.owner}`);
  };

  const submitPass = (): void => {
    if (!passRoom) return;
    showToast(`(mock) Vào bàn của ${passRoom.owner} — mật khẩu "${passInput}"`);
    setPassRoom(null);
  };

  const onCreateOk = (): void => {
    const amount = Number(bet.replace(/\D/g, '')) || 0;
    setCreateOpen(false);
    setWaiting({ show: true, bet: amount });
    showToast(createPassword.trim() ? '(mock) Đã tạo bàn có khóa' : '(mock) Đã tạo bàn');
  };

  return (
    <div id="ranked" className={visible ? '' : 'hidden'}>
      <div id="ranked-inner" style={assetBg('rankedBg')}>
        <div className="ranked-title" style={assetBg('rankedTitleFrame')}>
          <span>Chơi xếp hạng</span>
          <img src={assetSrc('rankedCup')} alt="" />
        </div>
        <div className="ranked-table-wrap">
          <div className="ranked-table" style={assetBg('rankedTable')}>
            <div className="ranked-head">
              <span>Chủ bàn</span>
              <span>Ken cược</span>
              <span>Tham gia</span>
            </div>
            <div id="ranked-rows">
              {visibleRooms.map((room, i) => (
                <div
                  key={room.id}
                  className={'ranked-row' + (room.full ? ' full' : '')}
                  style={{ top: `${HEAD_BOTTOM + i * ROW_HEIGHT}%`, height: `${ROW_HEIGHT}%` }}
                  onClick={room.full ? undefined : () => attemptJoin(room)}
                >
                  <span className="rr-owner">@{room.owner}</span>
                  <span className="rr-bet">{formatKen(room.bet)}</span>
                  <span className="rr-join">
                    {room.locked && <img src={assetSrc('rankedLock')} alt="" className="rr-lock" />}
                    <span
                      className="rr-badge"
                      style={{ backgroundImage: `url('${assetSrc(room.full ? 'rankedSlotFull' : 'rankedSlotOpen')}')` }}
                    >
                      {room.players}/2
                    </span>
                  </span>
                </div>
              ))}
            </div>
            <div id="ranked-empty" className={rooms.length > 0 ? 'hidden' : ''}>
              Chưa có bàn nào,
              <br />
              tạo bàn mới nhé!
            </div>
          </div>
        </div>
        <div className="ranked-pager">
          <button type="button" id="ranked-prev" style={assetBg('rankedPageBtn')} disabled={page === 0} onClick={() => setPage((p) => Math.max(0, p - 1))}>
            &lt;
          </button>
          <span id="ranked-page" style={assetBg('rankedPageBtn')}>
            {page + 1}
          </span>
          <button type="button" id="ranked-next" style={assetBg('rankedPageBtn')} disabled={page >= pageCount - 1} onClick={() => setPage((p) => Math.min(pageCount - 1, p + 1))}>
            &gt;
          </button>
        </div>
        <div className="ranked-menu">
          <button type="button" id="ranked-create" style={assetBg('rankedMenuBtn')} onClick={() => { setBet('0'); setCreatePassword(''); setCreateOpen(true); }}>
            Tạo bàn
          </button>
          <button type="button" id="ranked-refresh" style={assetBg('rankedMenuBtn')} onClick={() => showToast('Đã làm mới danh sách')}>
            Làm mới
          </button>
          <button type="button" id="ranked-exit" style={assetBg('rankedMenuBtn')} onClick={onExit}>
            Thoát
          </button>
        </div>
        <div id="ranked-waiting" className={waiting.show ? '' : 'hidden'}>
          <span id="ranked-waiting-text">
            {waiting.bet > 0 ? `Đang đợi đối thủ vào bàn (cược ${formatKen(waiting.bet)} Ken)...` : 'Đang đợi đối thủ vào bàn...'}
          </span>
          <button type="button" id="ranked-waiting-cancel" onClick={() => { setWaiting({ show: false, bet: 0 }); showToast('(mock) Đã hủy bàn'); }}>
            Hủy bàn
          </button>
        </div>
        <div id="ranked-toast" className={toast ? 'show' : 'hidden'}>
          {toast}
        </div>
      </div>

      <div id="ranked-create-modal" className={createOpen ? '' : 'hidden'} onClick={(e) => e.target === e.currentTarget && setCreateOpen(false)}>
        <div id="create-card" style={assetBg('createPanel')}>
          <div className="create-title" style={assetBg('createTitleFrame')}>
            <span>Tạo bàn</span>
          </div>
          <button type="button" id="create-close" style={assetBg('createBtnClose')} aria-label="Đóng" onClick={() => setCreateOpen(false)}>
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
                onChange={(e) => {
                  const digits = e.target.value.replace(/\D/g, '');
                  setBet(digits ? formatKen(Number(digits)) : '0');
                }}
              />
            </div>
            <div className="create-label" style={assetBg('createLabelFrame')}>
              <span>Mật khẩu</span>
            </div>
            <div className="create-input" style={assetBg('createInputFrame')}>
              <input id="create-password" type="text" autoComplete="off" placeholder="Để trống nếu không khóa" value={createPassword} onChange={(e) => setCreatePassword(e.target.value)} />
            </div>
          </div>
          <button type="button" id="create-ok" style={assetBg('createBtnOk')} onClick={onCreateOk}>
            <span>OK</span>
          </button>
        </div>
      </div>

      <div id="ranked-pass-modal" className={passRoom ? '' : 'hidden'} onClick={(e) => e.target === e.currentTarget && setPassRoom(null)}>
        <div id="pass-card">
          <h3>Bàn có khóa</h3>
          <div className="create-input" style={assetBg('createInputFrame')}>
            <input
              id="pass-input"
              type="text"
              autoComplete="off"
              placeholder="Nhập mật khẩu"
              value={passInput}
              onChange={(e) => setPassInput(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && submitPass()}
            />
          </div>
          <div className="pass-actions">
            <button type="button" id="pass-ok" onClick={submitPass}>
              Vào bàn
            </button>
            <button type="button" id="pass-cancel" onClick={() => setPassRoom(null)}>
              Hủy
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

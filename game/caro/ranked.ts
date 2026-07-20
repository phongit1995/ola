import type { RoomInfo } from '../src/sdk';
import { RANKED_ASSETS } from './assets';

export interface RankedDeps {
  onJoin(room: RoomInfo, password?: string): void;
  onCreate(bet: number, password: string): void;
  onCancelRoom(): void;
  onRefresh(): void;
  onExit(): void;
}

const PAGE_SIZE = 9;
const HEAD_BOTTOM = 10.5;
const ROW_HEIGHT = 8.85;

const el = {
  box: document.getElementById('ranked')!,
  rows: document.getElementById('ranked-rows')!,
  empty: document.getElementById('ranked-empty')!,
  prev: document.getElementById('ranked-prev') as HTMLButtonElement,
  next: document.getElementById('ranked-next') as HTMLButtonElement,
  page: document.getElementById('ranked-page')!,
  create: document.getElementById('ranked-create')!,
  refresh: document.getElementById('ranked-refresh')!,
  exit: document.getElementById('ranked-exit')!,
  waiting: document.getElementById('ranked-waiting')!,
  waitingText: document.getElementById('ranked-waiting-text')!,
  waitingCancel: document.getElementById('ranked-waiting-cancel')!,
  toast: document.getElementById('ranked-toast')!,
  createModal: document.getElementById('ranked-create-modal')!,
  createClose: document.getElementById('create-close')!,
  createOk: document.getElementById('create-ok')!,
  createBet: document.getElementById('create-bet') as HTMLInputElement,
  createPassword: document.getElementById('create-password') as HTMLInputElement,
  passModal: document.getElementById('ranked-pass-modal')!,
  passInput: document.getElementById('pass-input') as HTMLInputElement,
  passOk: document.getElementById('pass-ok')!,
  passCancel: document.getElementById('pass-cancel')!,
};

let deps: RankedDeps;
let rooms: RoomInfo[] = [];
let page = 0;
let passRoom: RoomInfo | null = null;
let toastTimer = 0;

function pageCount(): number {
  return Math.max(1, Math.ceil(rooms.length / PAGE_SIZE));
}

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

function renderRows(): void {
  const start = page * PAGE_SIZE;
  const visible = rooms.slice(start, start + PAGE_SIZE);
  el.rows.innerHTML = '';
  el.empty.classList.toggle('hidden', rooms.length > 0);

  visible.forEach((room, i) => {
    const row = document.createElement('div');
    row.className = 'ranked-row' + (room.full ? ' full' : '');
    row.style.top = `${HEAD_BOTTOM + i * ROW_HEIGHT}%`;
    row.style.height = `${ROW_HEIGHT}%`;

    const owner = document.createElement('span');
    owner.className = 'rr-owner';
    owner.textContent = room.owner;

    const bet = document.createElement('span');
    bet.className = 'rr-bet';
    bet.textContent = formatKen(room.bet);

    const join = document.createElement('span');
    join.className = 'rr-join';
    if (room.locked) {
      const lock = document.createElement('img');
      lock.src = RANKED_ASSETS.rankedLock;
      lock.alt = '';
      lock.className = 'rr-lock';
      join.appendChild(lock);
    }
    const badge = document.createElement('span');
    badge.className = 'rr-badge';
    badge.style.backgroundImage = `url('${room.full ? RANKED_ASSETS.rankedSlotFull : RANKED_ASSETS.rankedSlotOpen}')`;
    badge.textContent = `${room.players}/2`;
    join.appendChild(badge);

    row.append(owner, bet, join);
    if (!room.full) {
      row.addEventListener('click', () => attemptJoin(room));
    }
    el.rows.appendChild(row);
  });

  el.page.textContent = String(page + 1);
  el.prev.disabled = page === 0;
  el.next.disabled = page >= pageCount() - 1;
}

function attemptJoin(room: RoomInfo): void {
  if (room.locked) {
    passRoom = room;
    el.passInput.value = '';
    el.passModal.classList.remove('hidden');
    el.passInput.focus();
    return;
  }
  deps.onJoin(room);
}

function closePassModal(): void {
  el.passModal.classList.add('hidden');
  passRoom = null;
}

function openCreateModal(): void {
  el.createBet.value = '';
  el.createPassword.value = '';
  el.createModal.classList.remove('hidden');
  el.createBet.focus();
}

export function rankedCloseModals(): void {
  el.createModal.classList.add('hidden');
  closePassModal();
}

export function rankedToast(message: string): void {
  el.toast.textContent = message;
  el.toast.classList.remove('hidden');
  el.toast.classList.remove('show');
  void el.toast.offsetWidth;
  el.toast.classList.add('show');
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => el.toast.classList.remove('show'), 2200);
}

export function rankedSetRooms(list: RoomInfo[]): void {
  rooms = list;
  if (page >= pageCount()) page = pageCount() - 1;
  renderRows();
}

export function rankedShowWaiting(show: boolean, bet?: number): void {
  el.waiting.classList.toggle('hidden', !show);
  if (show) {
    el.waitingText.textContent =
      bet && bet > 0
        ? `Đang đợi đối thủ vào bàn (cược ${formatKen(bet)} Ken)...`
        : 'Đang đợi đối thủ vào bàn...';
  }
}

export function rankedSetVisible(visible: boolean): void {
  el.box.classList.toggle('hidden', !visible);
  if (!visible) {
    rankedCloseModals();
    rankedShowWaiting(false);
  }
}

export function buildRanked(d: RankedDeps): void {
  deps = d;

  el.prev.addEventListener('click', () => {
    if (page > 0) {
      page--;
      renderRows();
    }
  });
  el.next.addEventListener('click', () => {
    if (page < pageCount() - 1) {
      page++;
      renderRows();
    }
  });

  el.create.addEventListener('click', openCreateModal);
  el.refresh.addEventListener('click', () => deps.onRefresh());
  el.exit.addEventListener('click', () => deps.onExit());

  el.createClose.addEventListener('click', () => el.createModal.classList.add('hidden'));
  el.createModal.addEventListener('click', (event) => {
    if (event.target === el.createModal) el.createModal.classList.add('hidden');
  });
  el.createOk.addEventListener('click', () => {
    const bet = Math.max(0, Math.floor(Number(el.createBet.value) || 0));
    el.createModal.classList.add('hidden');
    deps.onCreate(bet, el.createPassword.value.trim());
  });

  el.passCancel.addEventListener('click', closePassModal);
  el.passModal.addEventListener('click', (event) => {
    if (event.target === el.passModal) closePassModal();
  });
  const submitPass = (): void => {
    if (!passRoom) return;
    const room = passRoom;
    const password = el.passInput.value;
    closePassModal();
    deps.onJoin(room, password);
  };
  el.passOk.addEventListener('click', submitPass);
  el.passInput.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') submitPass();
  });

  el.waitingCancel.addEventListener('click', () => {
    rankedShowWaiting(false);
    deps.onCancelRoom();
  });
}

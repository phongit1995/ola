import type { UserInfoData } from '../src/sdk';
import { applyAssets, vipIconUrl, VIP_DEFAULT_ICON } from './assets';
import type { BotLevel } from './bot';

export interface LobbyDeps {
  onPlayBot(level: BotLevel): void;
  onPlayRanked(): void;
  onRetry(): void;
  onExit(): void;
}

const el = {
  box: document.getElementById('lobby')!,
  content: document.getElementById('lobby-content')!,
  nameText: document.getElementById('lobby-name-text')!,
  vipIcon: document.getElementById('lobby-vip') as HTMLImageElement,
  kenText: document.getElementById('lobby-ken-text')!,
  plusBtn: document.getElementById('lobby-plus')!,
  status: document.getElementById('lobby-status')!,
  statusText: document.getElementById('lobby-status-text')!,
  retryBtn: document.getElementById('lobby-retry')!,
  botBtn: document.getElementById('lobby-bot')!,
  rankedBtn: document.getElementById('lobby-ranked')!,
  historyBtn: document.getElementById('lobby-history')!,
  leaderboardBtn: document.getElementById('lobby-leaderboard')!,
  exitBtn: document.getElementById('lobby-exit')!,
  toast: document.getElementById('lobby-toast')!,
  pick: document.getElementById('lobby-pick')!,
  pickClose: document.getElementById('lobby-pick-close')!,
  pickLevels: [...document.querySelectorAll<HTMLButtonElement>('#lobby-pick-levels button')],
};

let kenShown = 0;
let kenTarget = 0;
let kenRaf = 0;
let toastTimer = 0;
let contentShown = false;

function replayShowAnimation(): void {
  el.box.classList.remove('show');
  void el.box.offsetWidth;
  el.box.classList.add('show');
}

function formatKen(value: number): string {
  return Math.round(value).toLocaleString('vi-VN');
}

function animateKen(target: number): void {
  cancelAnimationFrame(kenRaf);
  kenTarget = target;
  const from = kenShown;
  const start = performance.now();
  const duration = from === target ? 0 : 700;
  const step = (now: number): void => {
    const t = duration === 0 ? 1 : Math.min(1, (now - start) / duration);
    const eased = 1 - (1 - t) * (1 - t);
    kenShown = from + (kenTarget - from) * eased;
    el.kenText.textContent = formatKen(kenShown);
    if (t < 1) kenRaf = requestAnimationFrame(step);
  };
  kenRaf = requestAnimationFrame(step);
}

export function lobbyToast(message: string): void {
  el.toast.textContent = message;
  el.toast.classList.remove('hidden');
  el.toast.classList.remove('show');
  void el.toast.offsetWidth;
  el.toast.classList.add('show');
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => {
    el.toast.classList.remove('show');
  }, 2200);
}

function openPickPopup(): void {
  el.pick.classList.remove('hidden');
}

function closePickPopup(): void {
  el.pick.classList.add('hidden');
}

export function lobbySetProgress(loaded: number, total: number): void {
  const pct = total === 0 ? 100 : Math.round((loaded / total) * 100);
  el.box.dataset.loading = `Đang tải... ${pct}%`;
}

export function lobbySetLoaded(): void {
  el.box.classList.remove('loading');
}

export function buildLobby(deps: LobbyDeps): void {
  applyAssets(document);

  el.plusBtn.addEventListener('click', () => lobbyToast('Nạp Ken trong app Ola nhé!'));
  el.historyBtn.addEventListener('click', () => lobbyToast('Tính năng đang phát triển'));
  el.leaderboardBtn.addEventListener('click', () => lobbyToast('Tính năng đang phát triển'));
  el.exitBtn.addEventListener('click', () => deps.onExit());
  el.retryBtn.addEventListener('click', () => deps.onRetry());
  el.botBtn.addEventListener('click', openPickPopup);
  el.rankedBtn.addEventListener('click', () => deps.onPlayRanked());
  el.pickClose.addEventListener('click', closePickPopup);
  el.pick.addEventListener('click', (event) => {
    if (event.target === el.pick) closePickPopup();
  });
  el.pickLevels.forEach((btn) => {
    btn.addEventListener('click', () => {
      closePickPopup();
      deps.onPlayBot(btn.dataset.level as BotLevel);
    });
  });
}

export function lobbySetConnecting(): void {
  el.box.classList.add('connecting');
  contentShown = false;
  el.status.classList.remove('hidden');
  el.statusText.textContent = 'Đang kết nối máy chủ...';
  el.retryBtn.classList.add('hidden');
}

export function lobbySetError(): void {
  el.box.classList.add('connecting');
  contentShown = false;
  el.status.classList.remove('hidden');
  el.statusText.textContent = 'Không kết nối được máy chủ';
  el.retryBtn.classList.remove('hidden');
}

export function lobbySetReady(info: UserInfoData): void {
  el.box.classList.remove('connecting');
  el.status.classList.add('hidden');
  if (!contentShown) {
    contentShown = true;
    replayShowAnimation();
  }
  el.nameText.textContent = info.guest ? 'Khách' : `@${info.username}`;
  el.vipIcon.src = vipIconUrl(info.vipType) ?? VIP_DEFAULT_ICON;
  el.vipIcon.classList.remove('hidden');
  animateKen(info.ken ?? 0);
}

export function lobbySetVisible(visible: boolean): void {
  el.box.classList.toggle('hidden', !visible);
  if (!visible) closePickPopup();
}

export function lobbyEnterAnimated(): void {
  lobbySetVisible(true);
  el.box.classList.remove('enter');
  void el.box.offsetWidth;
  el.box.classList.add('enter');
  replayShowAnimation();
}

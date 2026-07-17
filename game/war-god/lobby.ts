import { Assets, Container, Graphics, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import type { UserInfoData } from '../src/sdk';
import { A, tex } from './assets';
import { HEADING, addTick, makeText, removeTick } from './kit';
import type { BotLevel } from './battle';

const DESIGN_W = 520;
const CARD_W = 360;
const CARD_H = 464;
const VIP_ICON_H = 26;

function parseVipTypeId(vipType: string | null | undefined): number | null {
  if (vipType == null || vipType === '') return null;
  const id = Number(vipType);
  if (!Number.isInteger(id) || id < 1 || id > 132) return null;
  return id;
}

function vipIconUrl(id: number): string {
  return `/vip-icons/vip_${String(id).padStart(3, '0')}.png`;
}

export const LEVEL_LABELS: Record<BotLevel, string> = {
  easy: 'DỄ',
  normal: 'THƯỜNG',
  hard: 'KHÓ',
};

interface LobbyDeps {
  onPlay(level: BotLevel): void;
  onRetry(): void;
}

let deps: LobbyDeps;
let box: Container;
let dim: Graphics;
let card: Container;
let statusText: Text;
let retryBtn: Container;
let infoBox: Container;
let vipIcon: Sprite;
let nameText: Text;
let kenText: Text;
let levelBox: Container;
let spinnerStep: ((ticker: Ticker) => void) | null = null;

function stopSpinner(): void {
  if (spinnerStep) {
    removeTick(spinnerStep);
    spinnerStep = null;
  }
}

function makeBtn(label: string, w: number, h: number, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[A.menu.btnBlue]);
  bg.width = w;
  bg.height = h;
  b.addChild(bg);
  const t = makeText(label, 15, 0xffffff, '700', HEADING);
  t.x = w / 2;
  t.y = h / 2;
  b.addChild(t);
  b.eventMode = 'static';
  b.cursor = 'pointer';
  b.on('pointertap', onTap);
  b.on('pointerdown', () => b.scale.set(0.96));
  b.on('pointerup', () => b.scale.set(1));
  b.on('pointerupoutside', () => b.scale.set(1));
  return b;
}

export function buildLobby(lobbyDeps: LobbyDeps): Container {
  deps = lobbyDeps;
  box = new Container();

  dim = new Graphics();
  dim.eventMode = 'static';
  box.addChild(dim);

  card = new Container();
  const cardBg = new Graphics()
    .roundRect(0, 0, CARD_W, CARD_H, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  card.addChild(cardBg);

  const logo = makeText('⚔️', 40, 0xffffff);
  logo.x = CARD_W / 2;
  logo.y = 52;
  card.addChild(logo);

  const title = makeText('WAR GOD', 30, 0xf6c445, '700', HEADING);
  title.x = CARD_W / 2;
  title.y = 104;
  card.addChild(title);

  statusText = makeText('', 13, 0xb9b39e, '700');
  statusText.style.wordWrap = true;
  statusText.style.wordWrapWidth = CARD_W - 50;
  statusText.style.align = 'center';
  statusText.x = CARD_W / 2;
  statusText.y = 220;
  card.addChild(statusText);

  retryBtn = makeBtn('THỬ LẠI', 190, 52, () => deps.onRetry());
  retryBtn.x = (CARD_W - 190) / 2;
  retryBtn.y = 270;
  retryBtn.visible = false;
  card.addChild(retryBtn);

  infoBox = new Container();
  const panel = new Graphics()
    .roundRect(0, 0, CARD_W - 48, 80, 12)
    .fill({ color: 0x000000, alpha: 0.35 })
    .stroke({ width: 1, color: 0xffffff, alpha: 0.15 });
  infoBox.addChild(panel);

  vipIcon = new Sprite(Texture.EMPTY);
  vipIcon.anchor.set(0.5);
  vipIcon.y = 26;
  vipIcon.visible = false;
  infoBox.addChild(vipIcon);

  nameText = makeText('', 15, 0xffffff, '800');
  nameText.y = 26;
  infoBox.addChild(nameText);

  kenText = makeText('', 13, 0xffe9a8, '800');
  kenText.x = (CARD_W - 48) / 2;
  kenText.y = 58;
  infoBox.addChild(kenText);

  infoBox.x = 24;
  infoBox.y = 138;
  infoBox.visible = false;
  card.addChild(infoBox);

  levelBox = new Container();
  const pickLabel = makeText('CHỌN ĐỘ KHÓ ĐẤU MÁY', 14, 0xffe9a8, '700', HEADING);
  pickLabel.x = CARD_W / 2;
  pickLabel.y = 0;
  levelBox.addChild(pickLabel);

  (Object.keys(LEVEL_LABELS) as BotLevel[]).forEach((level, idx) => {
    const btn = makeBtn(LEVEL_LABELS[level], 220, 50, () => deps.onPlay(level));
    btn.x = (CARD_W - 220) / 2;
    btn.y = 22 + idx * 60;
    levelBox.addChild(btn);
  });

  levelBox.y = 246;
  levelBox.visible = false;
  card.addChild(levelBox);

  box.addChild(card);
  return box;
}

export function layoutLobby(designH: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  card.x = (DESIGN_W - CARD_W) / 2;
  card.y = Math.max(40, Math.round((designH - CARD_H) / 2));
}

export function lobbySetConnecting(): void {
  stopSpinner();
  box.visible = true;
  infoBox.visible = false;
  levelBox.visible = false;
  retryBtn.visible = false;
  statusText.visible = true;
  let t = 0;
  spinnerStep = (ticker: Ticker) => {
    t += ticker.deltaMS;
    const dots = '.'.repeat(1 + (Math.floor(t / 400) % 3));
    statusText.text = `Đang kết nối máy chủ${dots}`;
  };
  addTick(spinnerStep);
  statusText.text = 'Đang kết nối máy chủ.';
}

export function lobbySetError(): void {
  stopSpinner();
  box.visible = true;
  infoBox.visible = false;
  levelBox.visible = false;
  statusText.visible = true;
  statusText.text = 'Không thể kết nối máy chủ.\nKiểm tra mạng rồi thử lại nhé!';
  retryBtn.visible = true;
}

function layoutNameRow(): void {
  const iconW = vipIcon.visible ? vipIcon.width : 0;
  const gap = vipIcon.visible ? 8 : 0;
  const total = iconW + gap + nameText.width;
  const left = ((CARD_W - 48) - total) / 2;
  vipIcon.x = left + iconW / 2;
  nameText.x = left + iconW + gap + nameText.width / 2;
}

export function lobbySetReady(info: UserInfoData): void {
  stopSpinner();
  box.visible = true;
  statusText.visible = false;
  retryBtn.visible = false;

  nameText.text = `@${info.username}`;
  vipIcon.visible = false;
  layoutNameRow();

  const vipId = parseVipTypeId(info.vipType);
  if (vipId) {
    void Assets.load<Texture>(vipIconUrl(vipId))
      .then((texture) => {
        vipIcon.texture = texture;
        vipIcon.scale.set(VIP_ICON_H / texture.height);
        vipIcon.visible = true;
        layoutNameRow();
      })
      .catch(() => {});
  }

  kenText.text = `🪙 ${info.ken.toLocaleString('vi-VN')} Ken`;

  infoBox.visible = true;
  levelBox.visible = true;
}

export function lobbySetVisible(visible: boolean): void {
  box.visible = visible;
  if (!visible) stopSpinner();
}

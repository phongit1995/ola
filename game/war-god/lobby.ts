import { Assets, Container, Graphics, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import type { UserInfoData } from '../src/sdk';
import { A, tex } from './assets';
import { HEADING, addTick, makeText, removeTick } from './kit';
import type { BotLevel } from './battle';

const DESIGN_W = 520;
const VIP_ICON_H = 24;
const NAME_W = 400;
const KEN_W = 330;
const WOOD_W = 310;
const WOOD_H = 86;
const PILL_W = 160;
const PILL_H = 61;
const SOUND_KEY = 'wg-sound-on';

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
let bgSprite: Sprite;
let bgMask: Graphics;
let logo: Sprite;
let avatarFrame: Sprite;
let nameFrame: Sprite;
let nameText: Text;
let vipIcon: Sprite;
let kenFrame: Sprite;
let coin: Sprite;
let kenText: Text;
let plusBtn: Container;
let plusBg: Sprite;
let plusIc: Sprite;
let btnBot: Container;
let btnPvp: Container;
let menuRow: Container;
let soundIcon: Sprite;
let soundOn = true;
let statusPanel: Container;
let statusText: Text;
let retryBtn: Container;
let toastText: Text;
let toastTimer: number | undefined;
let pickBox: Container;
let pickDim: Graphics;
let pickCard: Container;
let guideBox: Container;
let guideDim: Graphics;
let guideCard: Container;
let spinnerStep: ((ticker: Ticker) => void) | null = null;
let lastDesignH = 980;
let lastInsetTop = 0;
let lastInsetBottom = 0;

function stopSpinner(): void {
  if (spinnerStep) {
    removeTick(spinnerStep);
    spinnerStep = null;
  }
}

function pressable(target: Container, onTap: () => void): void {
  target.eventMode = 'static';
  target.cursor = 'pointer';
  target.on('pointertap', onTap);
  target.on('pointerdown', () => target.scale.set(0.95));
  target.on('pointerup', () => target.scale.set(1));
  target.on('pointerupoutside', () => target.scale.set(1));
}

function iconSprite(url: string, height: number): Sprite {
  const s = new Sprite(tex[url]);
  s.anchor.set(0.5);
  s.scale.set(height / s.texture.height);
  return s;
}

function makeWoodBtn(label: string, w: number, h: number, iconUrl: string | null, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[A.lobby.btnWood]);
  bg.anchor.set(0.5);
  bg.width = w;
  bg.height = h;
  b.addChild(bg);
  let labelX = 0;
  if (iconUrl) {
    const ring = iconSprite(A.lobby.ring, h * 0.72);
    ring.x = -w / 2 + h * 0.7;
    b.addChild(ring);
    const icon = iconSprite(iconUrl, h * 0.46);
    icon.x = ring.x;
    b.addChild(icon);
    labelX = h * 0.4;
  }
  const t = makeText(label, Math.round(h * 0.31), 0xffd84d, '700', HEADING);
  t.x = labelX;
  b.addChild(t);
  pressable(b, onTap);
  return b;
}

function makePill(label: string, iconUrl: string, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[A.lobby.menuPill]);
  bg.anchor.set(0.5);
  bg.width = PILL_W;
  bg.height = PILL_H;
  b.addChild(bg);
  const ring = iconSprite(A.lobby.ring, 44);
  ring.x = -PILL_W / 2 + 34;
  b.addChild(ring);
  const icon = iconSprite(iconUrl, 26);
  icon.x = ring.x;
  b.addChild(icon);
  const t = makeText(label, 13, 0xffe9a8, '700', HEADING);
  t.x = 20;
  b.addChild(t);
  pressable(b, onTap);
  return b;
}

function showToast(message: string): void {
  toastText.text = message;
  toastText.visible = true;
  if (toastTimer) window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => {
    toastText.visible = false;
  }, 2200);
}

function buildPickBox(): Container {
  const wrap = new Container();
  pickDim = new Graphics();
  pickDim.eventMode = 'static';
  pickDim.on('pointertap', () => {
    wrap.visible = false;
  });
  wrap.addChild(pickDim);

  pickCard = new Container();
  const title = makeText('CHỌN ĐỘ KHÓ', 24, 0xffd84d, '700', HEADING);
  title.y = -140;
  pickCard.addChild(title);
  (Object.keys(LEVEL_LABELS) as BotLevel[]).forEach((level, idx) => {
    const btn = makeWoodBtn(LEVEL_LABELS[level], 300, 84, null, () => {
      wrap.visible = false;
      deps.onPlay(level);
    });
    btn.y = -60 + idx * 100;
    pickCard.addChild(btn);
  });
  wrap.addChild(pickCard);
  wrap.visible = false;
  return wrap;
}

const GUIDE_LINES = [
  'Ghép 3 ô cùng loại để kích hoạt hiệu ứng:',
  '⚔️ Kiếm 5 · 🪨 Đá 3 sát thương (giáp chặn được)',
  '🔥 Lửa 4 sát thương phép, xuyên giáp',
  '❤️ Tim hồi 4 máu · 💧 Nước +7 nội lực',
  '🛡️ Khiên +4 giáp (tối đa 30)',
  '',
  'Ghép 4 ô trở lên được đánh thêm lượt.',
  'Đủ 50 nội lực tung tuyệt chiêu gây 25 sát thương.',
  'Mỗi lượt có 45 giây — hạ gục đối thủ để thắng!',
].join('\n');

function buildGuideBox(): Container {
  const wrap = new Container();
  guideDim = new Graphics();
  guideDim.eventMode = 'static';
  guideDim.on('pointertap', () => {
    wrap.visible = false;
  });
  wrap.addChild(guideDim);

  guideCard = new Container();
  const cardW = 440;
  const cardH = 400;
  const bg = new Graphics()
    .roundRect(-cardW / 2, -cardH / 2, cardW, cardH, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  guideCard.addChild(bg);

  const title = makeText('HƯỚNG DẪN', 24, 0xffd84d, '700', HEADING);
  title.y = -cardH / 2 + 44;
  guideCard.addChild(title);

  const body = makeText(GUIDE_LINES, 15, 0xffffff, '700');
  body.style.wordWrap = true;
  body.style.wordWrapWidth = cardW - 56;
  body.style.align = 'left';
  body.style.lineHeight = 24;
  body.y = 4;
  guideCard.addChild(body);

  const ok = makeWoodBtn('ĐÃ HIỂU', 200, 62, null, () => {
    wrap.visible = false;
  });
  ok.y = cardH / 2 - 52;
  guideCard.addChild(ok);

  wrap.addChild(guideCard);
  wrap.visible = false;
  return wrap;
}

export function buildLobby(lobbyDeps: LobbyDeps): Container {
  deps = lobbyDeps;
  soundOn = localStorage.getItem(SOUND_KEY) !== '0';
  box = new Container();

  const bgBox = new Container();
  bgSprite = new Sprite(tex[A.lobby.bg]);
  bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  box.addChild(bgBox);

  logo = new Sprite(tex[A.lobby.logo]);
  logo.anchor.set(0.5);
  logo.width = 380;
  logo.scale.y = logo.scale.x;
  box.addChild(logo);

  nameFrame = new Sprite(tex[A.lobby.nameFrame]);
  nameFrame.anchor.set(0.5);
  nameFrame.width = NAME_W;
  nameFrame.scale.y = nameFrame.scale.x;
  nameFrame.x = DESIGN_W / 2;
  box.addChild(nameFrame);

  vipIcon = new Sprite(Texture.EMPTY);
  vipIcon.anchor.set(0.5);
  vipIcon.visible = false;
  box.addChild(vipIcon);

  nameText = makeText('', 23, 0xffe9a8, '800');
  box.addChild(nameText);

  avatarFrame = new Sprite(tex[A.lobby.avatarFrame]);
  avatarFrame.anchor.set(0.5);
  avatarFrame.width = 235;
  avatarFrame.scale.y = avatarFrame.scale.x;
  avatarFrame.x = DESIGN_W / 2;
  box.addChild(avatarFrame);

  kenFrame = new Sprite(tex[A.lobby.kenFrame]);
  kenFrame.anchor.set(0.5);
  kenFrame.width = KEN_W;
  kenFrame.scale.y = kenFrame.scale.x;
  kenFrame.x = DESIGN_W / 2;
  box.addChild(kenFrame);

  coin = iconSprite(A.lobby.coin, 72);
  box.addChild(coin);

  kenText = makeText('', 27, 0xffd84d, '800');
  box.addChild(kenText);

  plusBtn = new Container();
  plusBg = new Sprite(tex[A.lobby.btnPlus]);
  plusBg.anchor.set(0.5);
  plusBtn.addChild(plusBg);
  plusIc = iconSprite(A.lobby.icPlus, 30);
  plusBtn.addChild(plusIc);
  pressable(plusBtn, () => showToast('Nạp Ken trong app Ola nhé!'));
  box.addChild(plusBtn);

  btnBot = makeWoodBtn('ĐẤU VỚI MÁY', WOOD_W, WOOD_H, A.lobby.icBot, () => {
    pickBox.visible = true;
  });
  btnBot.x = DESIGN_W / 2;
  box.addChild(btnBot);

  btnPvp = makeWoodBtn('ĐẤU 1V1', WOOD_W, WOOD_H, A.lobby.icPvp, () => {
    showToast('Đấu 1v1 đang phát triển, sắp ra mắt!');
  });
  btnPvp.x = DESIGN_W / 2;
  box.addChild(btnPvp);

  menuRow = new Container();
  const history = makePill('LỊCH SỬ', A.lobby.icHistory, () =>
    showToast('Lịch sử đấu đang phát triển!'),
  );
  history.x = -PILL_W - 10;
  menuRow.addChild(history);

  const sound = makePill('ÂM THANH', soundOn ? A.lobby.icSoundOn : A.lobby.icSoundOff, () => {
    soundOn = !soundOn;
    localStorage.setItem(SOUND_KEY, soundOn ? '1' : '0');
    soundIcon.texture = tex[soundOn ? A.lobby.icSoundOn : A.lobby.icSoundOff];
    soundIcon.scale.set(26 / soundIcon.texture.height);
  });
  soundIcon = sound.children[2] as Sprite;
  menuRow.addChild(sound);

  const guide = makePill('HƯỚNG DẪN', A.lobby.icGuide, () => {
    guideBox.visible = true;
  });
  guide.x = PILL_W + 10;
  menuRow.addChild(guide);
  menuRow.x = DESIGN_W / 2;
  box.addChild(menuRow);

  statusPanel = new Container();
  const statusBg = new Graphics()
    .roundRect(-190, -30, 380, 60, 14)
    .fill({ color: 0x101c2c, alpha: 0.82 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: 0.7 });
  statusPanel.addChild(statusBg);
  statusText = makeText('', 15, 0xffe9a8, '700');
  statusText.style.wordWrap = true;
  statusText.style.wordWrapWidth = 350;
  statusText.style.align = 'center';
  statusPanel.addChild(statusText);
  statusPanel.x = DESIGN_W / 2;
  statusPanel.visible = false;
  box.addChild(statusPanel);

  retryBtn = makeWoodBtn('THỬ LẠI', 220, 66, null, () => deps.onRetry());
  retryBtn.x = DESIGN_W / 2;
  retryBtn.visible = false;
  box.addChild(retryBtn);

  toastText = makeText('', 15, 0xffffff, '800');
  toastText.x = DESIGN_W / 2;
  toastText.visible = false;
  box.addChild(toastText);

  pickBox = buildPickBox();
  box.addChild(pickBox);
  guideBox = buildGuideBox();
  box.addChild(guideBox);

  return box;
}

export function layoutLobby(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  lastDesignH = designH;
  lastInsetTop = insetTop;
  lastInsetBottom = insetBottom;

  const bgTex = bgSprite.texture;
  const cover = Math.max(DESIGN_W / bgTex.width, designH / bgTex.height);
  bgSprite.scale.set(cover);
  bgSprite.x = (DESIGN_W - bgTex.width * cover) / 2;
  bgSprite.y = 0;
  bgMask.clear().rect(0, 0, DESIGN_W, designH).fill(0xffffff);

  logo.x = DESIGN_W / 2;
  logo.y = insetTop + 100;
  nameFrame.y = insetTop + 338;
  avatarFrame.y = nameFrame.y - 106;
  layoutNameRow();
  kenFrame.y = insetTop + 438;
  const kenH = kenFrame.height;
  coin.x = DESIGN_W / 2 - KEN_W / 2 + 40;
  coin.y = kenFrame.y;
  kenText.x = DESIGN_W / 2 + 4;
  kenText.y = kenFrame.y;
  plusBg.width = kenH;
  plusBg.height = kenH;
  plusIc.scale.set((kenH * 0.48) / plusIc.texture.height);
  plusBtn.x = DESIGN_W / 2 + KEN_W / 2 - kenH / 2;
  plusBtn.y = kenFrame.y;

  const menuY = designH - insetBottom - 44;
  menuRow.y = menuY;
  toastText.y = menuY - 64;
  btnPvp.y = menuY - 104;
  btnBot.y = btnPvp.y - 104;

  const gapTop = insetTop + 438 + kenH / 2;
  const gapBottom = btnBot.y - WOOD_H / 2;
  statusPanel.y = (gapTop + gapBottom) / 2;
  retryBtn.y = statusPanel.y + 78;

  pickDim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  pickCard.x = DESIGN_W / 2;
  pickCard.y = designH / 2;
  guideDim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  guideCard.x = DESIGN_W / 2;
  guideCard.y = designH / 2;
}

function layoutNameRow(): void {
  const iconW = vipIcon.visible ? vipIcon.width : 0;
  const gap = vipIcon.visible ? 8 : 0;
  nameText.scale.set(1);
  const maxW = NAME_W - 110 - iconW - gap;
  if (nameText.width > maxW) nameText.scale.set(maxW / nameText.width);
  const textW = nameText.width;
  const total = iconW + gap + textW;
  const left = (DESIGN_W - total) / 2;
  vipIcon.x = left + iconW / 2;
  vipIcon.y = nameFrame.y;
  nameText.x = left + iconW + gap + textW / 2;
  nameText.y = nameFrame.y;
}

export function lobbySetConnecting(): void {
  stopSpinner();
  box.visible = true;
  retryBtn.visible = false;
  statusPanel.visible = true;
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
  statusPanel.visible = true;
  statusText.text = 'Không thể kết nối máy chủ.\nBạn vẫn có thể đấu với máy!';
  retryBtn.visible = true;
}

export function lobbySetReady(info: UserInfoData): void {
  stopSpinner();
  box.visible = true;
  statusPanel.visible = false;
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

  kenText.text = info.ken.toLocaleString('vi-VN');
  layoutLobby(lastDesignH, lastInsetTop, lastInsetBottom);
}

export function lobbySetVisible(visible: boolean): void {
  box.visible = visible;
  if (!visible) {
    stopSpinner();
    pickBox.visible = false;
    guideBox.visible = false;
    toastText.visible = false;
    if (toastTimer) window.clearTimeout(toastTimer);
  }
}

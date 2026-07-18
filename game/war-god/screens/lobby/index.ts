import { Assets, Container, Graphics, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import type { UserInfoData } from '../../../src/sdk';
import { A, tex } from '../../assets';
import { addTick, iconSprite, makeText, popIn, pressable, removeTick } from '../../kit';
import type { BotLevel } from '../../logic/battle';
import { PILL_W, makePill, makeWoodBtn } from './ui';
import { buildPickPopup, hidePickPopup, layoutPickPopup, openPickPopup } from './pick-popup';
import { buildGuidePopup, hideGuidePopup, layoutGuidePopup, openGuidePopup } from './guide-popup';
import {
  buildConfirmPopup,
  hideConfirmPopup,
  layoutConfirmPopup,
  openConfirmPopup,
} from './confirm-popup';

const DESIGN_W = 520;
const VIP_FIT_W = 150;
const VIP_FIT_H = 132;
const NAME_W = 400;
const KEN_W = 330;
const WOOD_W = 310;
const WOOD_H = 86;
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

interface LobbyDeps {
  onPlay(level: BotLevel): void;
  onRetry(): void;
  onExit(): void;
}

let deps: LobbyDeps;
let box: Container;
let content: Container;
let contentShown = false;
let bgSprite: Sprite;
let bgMask: Graphics;
let logo: Sprite;
let exitBtn: Container;
let avatarFrame: Sprite;
let nameFrame: Sprite;
let nameText: Text;
let vipIcon: Sprite;
let kenFrame: Sprite;
let coin: Sprite;
let coinBaseScale = 1;
let kenText: Text;
let kenValue = 0;
let kenAnimStep: ((ticker: Ticker) => void) | null = null;
let plusBtn: Container;
let plusBg: Sprite;
let plusIc: Sprite;
let btnBot: Container;
let btnPvp: Container;
let btnBotWrap: Container;
let btnPvpWrap: Container;
let menuRow: Container;
let soundIcon: Sprite;
let soundOn = true;
let statusPanel: Container;
let statusText: Text;
let retryBtn: Container;
let toastText: Text;
let toastTimer: number | undefined;
let pickBox: Container;
let guideBox: Container;
let confirmBox: Container;
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

function stopKenAnim(): void {
  if (kenAnimStep) {
    removeTick(kenAnimStep);
    kenAnimStep = null;
  }
  kenText.scale.set(1);
  coin.scale.set(coinBaseScale);
}

function animateKen(target: number): void {
  stopKenAnim();
  kenValue = target;
  if (target <= 0) {
    kenText.text = '0';
    return;
  }
  const dur = 1100;
  let t = 0;
  kenAnimStep = (ticker: Ticker) => {
    t += ticker.deltaMS;
    const k = Math.min(1, t / dur);
    const e = 1 - Math.pow(1 - k, 3);
    kenText.text = Math.round(target * e).toLocaleString('vi-VN');
    kenText.scale.set(1 + 0.1 * Math.sin(k * Math.PI));
    coin.scale.set(coinBaseScale * (1 + 0.16 * Math.abs(Math.sin(t / 130)) * (1 - k)));
    if (k >= 1) {
      stopKenAnim();
      kenText.text = target.toLocaleString('vi-VN');
    }
  };
  addTick(kenAnimStep);
}

function showToast(message: string): void {
  toastText.text = message;
  toastText.visible = true;
  if (toastTimer) window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => {
    toastText.visible = false;
  }, 2200);
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

  exitBtn = new Container();
  exitBtn.addChild(iconSprite(A.lobby.btnExit, 56));
  pressable(exitBtn, () => {
    openConfirmPopup('Bạn có chắc muốn\nthoát game?', () => deps.onExit());
  });
  box.addChild(exitBtn);

  content = new Container();
  content.visible = false;
  contentShown = false;
  box.addChild(content);

  nameFrame = new Sprite(tex[A.lobby.nameFrame]);
  nameFrame.anchor.set(0.5);
  nameFrame.width = NAME_W;
  nameFrame.scale.y = nameFrame.scale.x;
  nameFrame.x = DESIGN_W / 2;
  content.addChild(nameFrame);

  nameText = makeText('', 23, 0xffe9a8, '800');
  content.addChild(nameText);

  avatarFrame = new Sprite(tex[A.lobby.avatarFrame]);
  avatarFrame.anchor.set(0.5);
  avatarFrame.width = 235;
  avatarFrame.scale.y = avatarFrame.scale.x;
  avatarFrame.x = DESIGN_W / 2;
  content.addChild(avatarFrame);

  vipIcon = new Sprite(Texture.EMPTY);
  vipIcon.anchor.set(0.5);
  vipIcon.visible = false;
  content.addChild(vipIcon);

  kenFrame = new Sprite(tex[A.lobby.kenFrame]);
  kenFrame.anchor.set(0.5);
  kenFrame.width = KEN_W;
  kenFrame.scale.y = kenFrame.scale.x;
  kenFrame.x = DESIGN_W / 2;
  content.addChild(kenFrame);

  coin = iconSprite(A.lobby.coin, 72);
  coinBaseScale = coin.scale.x;
  content.addChild(coin);

  kenText = makeText('', 27, 0xffd84d, '800');
  content.addChild(kenText);

  plusBtn = new Container();
  plusBg = new Sprite(tex[A.lobby.btnPlus]);
  plusBg.anchor.set(0.5);
  plusBtn.addChild(plusBg);
  plusIc = iconSprite(A.lobby.icPlus, 30);
  plusBtn.addChild(plusIc);
  pressable(plusBtn, () => showToast('Nạp Ken trong app Ola nhé!'));
  content.addChild(plusBtn);

  btnBot = makeWoodBtn('ĐẤU VỚI MÁY', WOOD_W, WOOD_H, A.lobby.icBot, openPickPopup);
  btnBotWrap = new Container();
  btnBotWrap.x = DESIGN_W / 2;
  btnBotWrap.addChild(btnBot);
  content.addChild(btnBotWrap);

  btnPvp = makeWoodBtn('ĐẤU 1V1', WOOD_W, WOOD_H, A.lobby.icPvp, () => {
    showToast('Đấu 1v1 đang phát triển, sắp ra mắt!');
  });
  btnPvpWrap = new Container();
  btnPvpWrap.x = DESIGN_W / 2;
  btnPvpWrap.addChild(btnPvp);
  content.addChild(btnPvpWrap);

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

  const guide = makePill('HƯỚNG DẪN', A.lobby.icGuide, openGuidePopup);
  guide.x = PILL_W + 10;
  menuRow.addChild(guide);
  menuRow.x = DESIGN_W / 2;
  content.addChild(menuRow);

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

  pickBox = buildPickPopup((level) => deps.onPlay(level));
  box.addChild(pickBox);
  guideBox = buildGuidePopup();
  box.addChild(guideBox);
  confirmBox = buildConfirmPopup();
  box.addChild(confirmBox);

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
  exitBtn.x = DESIGN_W - 42;
  exitBtn.y = insetTop + 42;
  nameFrame.y = insetTop + 338;
  avatarFrame.y = nameFrame.y - 106;
  vipIcon.x = DESIGN_W / 2;
  vipIcon.y = avatarFrame.y - 8;
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

  const kenBottom = kenFrame.y + kenH / 2;
  const menuTop = menuY - 41;
  let btnScale = 1;
  let pvpY = menuY - 104;
  let botY = pvpY - 104;
  if (botY - WOOD_H / 2 < kenBottom + 12) {
    const availTop = kenBottom + 10;
    const availBot = menuTop - 10;
    const span = Math.max(80, availBot - availTop);
    const need = WOOD_H * 2 + 14;
    btnScale = Math.min(1, span / need);
    const blockTop = (availTop + availBot) / 2 - (need * btnScale) / 2;
    botY = blockTop + (WOOD_H * btnScale) / 2;
    pvpY = botY + (WOOD_H + 14) * btnScale;
  }
  btnBotWrap.scale.set(btnScale);
  btnPvpWrap.scale.set(btnScale);
  btnBotWrap.y = botY;
  btnPvpWrap.y = pvpY;

  const gapBottom = botY - (WOOD_H * btnScale) / 2;
  statusPanel.y = btnScale < 1 ? (kenBottom + menuTop) / 2 : (kenBottom + gapBottom) / 2;
  retryBtn.y = statusPanel.y + 78;

  layoutPickPopup(designH, insetTop, insetBottom);
  layoutGuidePopup(designH);
  layoutConfirmPopup(designH);
}

function layoutNameRow(): void {
  nameText.scale.set(1);
  const maxW = NAME_W - 110;
  if (nameText.width > maxW) nameText.scale.set(maxW / nameText.width);
  nameText.x = DESIGN_W / 2;
  nameText.y = nameFrame.y;
}

function revealContent(): void {
  content.visible = true;
  if (contentShown) return;
  contentShown = true;
  popIn(avatarFrame, 0);
  popIn(nameFrame, 90);
  popIn(nameText, 90);
  popIn(kenFrame, 180);
  popIn(coin, 210);
  popIn(kenText, 210);
  popIn(plusBtn, 210);
  popIn(btnBot, 320);
  popIn(btnPvp, 440);
  popIn(menuRow, 560);
}

export function lobbySetConnecting(): void {
  stopSpinner();
  box.visible = true;
  content.visible = false;
  contentShown = false;
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
  revealContent();
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
        vipIcon.scale.set(Math.min(VIP_FIT_W / texture.width, VIP_FIT_H / texture.height));
        vipIcon.visible = true;
        popIn(vipIcon, 120);
      })
      .catch(() => {});
  }

  layoutLobby(lastDesignH, lastInsetTop, lastInsetBottom);
  revealContent();
  kenValue = info.ken;
  kenText.text = '';
  window.setTimeout(() => {
    if (box.visible && content.visible) animateKen(info.ken);
  }, 380);
}

export function lobbySetVisible(visible: boolean): void {
  box.visible = visible;
  if (!visible) {
    stopSpinner();
    stopKenAnim();
    kenText.text = kenValue > 0 ? kenValue.toLocaleString('vi-VN') : kenText.text;
    hidePickPopup();
    hideGuidePopup();
    hideConfirmPopup();
    toastText.visible = false;
    if (toastTimer) window.clearTimeout(toastTimer);
  }
}

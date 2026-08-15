import { Assets, Container, Graphics, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import { A, tex } from '../../../assets';
import { HEADING, addTick, makeText, removeTick } from '../../../kit';
import { MAX_FURY, MAX_HP, MAX_MP, type Fighter } from '../../../logic/battle';
import { avatarIconUrl, botAvatarIconUrl } from '../../../vip';
import type { BotLevel } from '../../../logic/battle';

const CARD_W = 190;
const ARMOR_BADGE_W = 56;
const ARMOR_BADGE_H = 26;
const AVATAR_FIT = 22;

export interface BarUI {
  fill: Graphics;
  label: Text;
  width: number;
  color: number;
  shown?: number;
  anim?: ((ticker: Ticker) => void) | null;
}

export interface FighterUI {
  card: Container;
  border: Sprite;
  ring: Sprite;
  avatar: Sprite;
  avatarUrl: string;
  avatarGen: number;
  name: Text;
  hp: BarUI;
  mp: BarUI;
  fury: BarUI;
  armor: Container;
  armorBg: Graphics;
  armorText: Text;
  ultFrame: Sprite;
  ultFlame: Sprite;
  ultLabel: Text;
  ultOn: Texture;
  ultOff: Texture;
  ultBtn: Container;
  ultFlameScale: number;
  ultPulse: ((ticker: Ticker) => void) | null;
}

function makeBar(
  icon: Texture,
  color: number,
  width: number,
  mirror: boolean,
): { view: Container; bar: BarUI } {
  const view = new Container();
  const iconSprite = new Sprite(icon);
  iconSprite.anchor.set(0.5);
  iconSprite.scale.set(17 / Math.max(iconSprite.texture.width, iconSprite.texture.height));
  const track = new Graphics().roundRect(0, 0, width, 14, 7).fill({ color: 0x000000, alpha: 0.55 });
  track.stroke({ width: 1, color: 0xffffff, alpha: 0.2 });
  const fill = new Graphics();
  const label = makeText('', 9.5, 0xffffff, '800');
  label.y = 7;
  const barX = mirror ? 0 : 22;
  iconSprite.x = mirror ? width + 11 : 9;
  iconSprite.y = 7;
  track.x = barX;
  fill.x = barX;
  label.x = barX + width / 2;
  view.addChild(track, fill);
  view.addChild(iconSprite, label);
  return { view, bar: { fill, label, width, color } };
}

function drawBar(bar: BarUI, value: number, max: number): void {
  const fraction = Math.max(0, Math.min(1, value / max));
  const width = bar.width * fraction;
  bar.fill.clear();
  if (width > 1) {
    bar.fill.roundRect(0, 0, width, 14, Math.min(7, width / 2)).fill(bar.color);
  }
  bar.label.text = `${Math.round(value)}/${max}`;
}

function updateBar(bar: BarUI, current: number, max: number): void {
  if (bar.anim) {
    removeTick(bar.anim);
    bar.anim = null;
  }
  const from = bar.shown ?? current;
  if (from === current) {
    bar.shown = current;
    drawBar(bar, current, max);
    return;
  }
  let elapsed = 0;
  bar.anim = (ticker: Ticker): void => {
    if (bar.fill.destroyed) {
      if (bar.anim) removeTick(bar.anim);
      bar.anim = null;
      return;
    }
    elapsed += ticker.deltaMS;
    const progress = Math.min(1, elapsed / 380);
    const eased = 1 - (1 - progress) * (1 - progress);
    bar.shown = from + (current - from) * eased;
    drawBar(bar, bar.shown, max);
    if (progress >= 1 && bar.anim) {
      bar.shown = current;
      removeTick(bar.anim);
      bar.anim = null;
    }
  };
  addTick(bar.anim);
}

export function makeFighterCard(side: 'me' | 'foe', onUlt?: () => void): FighterUI {
  const mirror = side === 'me';
  const width = CARD_W;
  const height = 152;
  const card = new Container();
  card.addChild(
    new Graphics().roundRect(0, 0, width, height, 14).fill({ color: 0x101c2c, alpha: 0.88 }),
  );
  const border = new Sprite(tex[A.hud.cardBorderIdle]);
  border.width = width;
  border.height = height;
  card.addChild(border);
  const ring = new Sprite(tex[A.hud.ringIdle]);
  ring.width = 36;
  ring.height = 36;
  ring.x = mirror ? width - 48 : 12;
  ring.y = 8;
  card.addChild(ring);
  const avatar = new Sprite(Texture.EMPTY);
  avatar.anchor.set(0.5);
  avatar.visible = false;
  avatar.position.set(ring.x + 18, ring.y + 18);
  card.addChild(avatar);
  const name = makeText(mirror ? '@bạn' : '@máy', 13, 0xffffff, '800');
  name.anchor.set(mirror ? 1 : 0, 0.5);
  name.x = mirror ? width - 56 : 56;
  name.y = 26;
  card.addChild(name);
  const rank = new Sprite(tex[A.hud.rankFrame]);
  rank.width = 26;
  rank.height = 30;
  rank.x = mirror ? 12 : width - 38;
  rank.y = 11;
  card.addChild(rank);
  const rankNum = makeText(mirror ? '1' : '2', 13, 0xf6c445, '700', HEADING);
  rankNum.x = rank.x + 13;
  rankNum.y = rank.y + 15;
  card.addChild(rankNum);

  const hpRow = makeBar(tex[A.hud.icHp], 0xe6392e, 140, mirror);
  const mpRow = makeBar(tex[A.hud.icMp], 0x2f7fe0, 140, mirror);
  const furyRow = makeBar(tex[A.items.peach], 0xff5aa0, 140, mirror);
  for (const [row, y] of [[hpRow, 48], [furyRow, 68], [mpRow, 88]] as const) {
    row.view.position.set(12, y);
    card.addChild(row.view);
  }

  const ultOn = tex[mirror ? A.hud.ultRightOn : A.hud.ultLeftOn];
  const ultOff = tex[mirror ? A.hud.ultRightOff : A.hud.ultLeftOff];
  const ultWidth = 106;
  const ultY = 104;
  const ultBtn = new Container();
  const ultFrame = new Sprite(ultOff);
  ultFrame.width = ultWidth;
  ultFrame.scale.y = ultFrame.scale.x;
  ultBtn.addChild(ultFrame);
  const ultFlame = new Sprite(tex[A.hud.flameOff]);
  ultFlame.anchor.set(0.5);
  const ultFlameScale = 21 / Math.max(ultFlame.texture.width, ultFlame.texture.height);
  ultFlame.scale.set(ultFlameScale);
  const orbX = ultFrame.height / 2;
  ultFlame.position.set(mirror ? ultWidth - orbX : orbX, ultFrame.height / 2);
  ultBtn.addChild(ultFlame);
  const ultLabel = makeText('TUYỆT CHIÊU', 9.5, 0xcfc9b8, '700', HEADING);
  ultLabel.x = mirror
    ? (ultWidth - ultFrame.height) / 2
    : ultFrame.height + (ultWidth - ultFrame.height) / 2;
  ultLabel.y = ultFrame.height / 2;
  ultBtn.addChild(ultLabel);
  ultBtn.position.set(mirror ? width - 12 - ultWidth : 12, ultY);
  card.addChild(ultBtn);

  const armor = new Container();
  const armorBg = new Graphics();
  const armorIcon = new Sprite(tex[A.items.shield]);
  armorIcon.anchor.set(0.5);
  armorIcon.scale.set(20 / Math.max(armorIcon.texture.width, armorIcon.texture.height));
  armorIcon.position.set(17, ARMOR_BADGE_H / 2);
  const armorText = makeText('0', 13, 0x9fd0ff, '800');
  armorText.position.set(38, ARMOR_BADGE_H / 2);
  armor.addChild(armorBg, armorIcon, armorText);
  armor.x = mirror ? ultBtn.x - 6 - ARMOR_BADGE_W : ultBtn.x + ultWidth + 6;
  armor.y = Math.round(ultY + ultFrame.height / 2 - ARMOR_BADGE_H / 2);
  card.addChild(armor);
  if (onUlt) {
    ultBtn.eventMode = 'static';
    ultBtn.cursor = 'pointer';
    ultBtn.on('pointertap', onUlt);
  }
  return {
    card,
    border,
    ring,
    avatar,
    avatarUrl: '',
    avatarGen: 0,
    name,
    hp: hpRow.bar,
    mp: mpRow.bar,
    fury: furyRow.bar,
    armor,
    armorBg,
    armorText,
    ultFrame,
    ultFlame,
    ultLabel,
    ultOn,
    ultOff,
    ultBtn,
    ultFlameScale,
    ultPulse: null,
  };
}

// Icon VIP tải lười theo url nên phải chốt bằng gen: đổi đối thủ liên tục thì
// ảnh về sau mới được gắn, tránh cảnh ảnh của người cũ đè lên người mới.
function loadAvatar(ui: FighterUI, url: string): void {
  if (url === ui.avatarUrl) return;
  ui.avatarUrl = url;
  const gen = ++ui.avatarGen;
  ui.avatar.visible = false;
  void Assets.load<Texture>(url)
    .then((texture) => {
      if (ui.avatar.destroyed || gen !== ui.avatarGen) return;
      ui.avatar.texture = texture;
      ui.avatar.scale.set(Math.min(AVATAR_FIT / texture.width, AVATAR_FIT / texture.height));
      ui.avatar.visible = true;
    })
    .catch(() => {
      if (gen === ui.avatarGen) ui.avatarUrl = '';
    });
}

export function setFighterAvatar(ui: FighterUI, vipType?: string | null): void {
  loadAvatar(ui, avatarIconUrl(vipType));
}

export function setFighterBotAvatar(ui: FighterUI, level: BotLevel): void {
  loadAvatar(ui, botAvatarIconUrl(level));
}

export function updateFighter(ui: FighterUI, fighter: Fighter, active: boolean, ready: boolean): void {
  updateBar(ui.hp, fighter.hp, MAX_HP);
  updateBar(ui.mp, fighter.mp, MAX_MP);
  updateBar(ui.fury, fighter.fury, MAX_FURY);
  const hasArmor = fighter.armor > 0;
  ui.armorBg
    .clear()
    .roundRect(0, 0, ARMOR_BADGE_W, ARMOR_BADGE_H, 9)
    .fill({ color: hasArmor ? 0x164d82 : 0x0b1827, alpha: hasArmor ? 0.96 : 0.82 })
    .stroke({ width: 1.5, color: hasArmor ? 0x8fdcff : 0x526270, alpha: 0.95 });
  ui.armor.alpha = hasArmor ? 1 : 0.7;
  ui.armorText.text = `${fighter.armor}`;
  ui.armorText.style.fill = hasArmor ? 0xc4efff : 0x8795a2;
  ui.border.texture = active ? tex[A.hud.cardBorderActive] : tex[A.hud.cardBorderIdle];
  ui.ring.texture = active ? tex[A.hud.ringActive] : tex[A.hud.ringIdle];
  ui.card.alpha = active ? 1 : 0.92;
  ui.ultFrame.texture = ready ? ui.ultOn : ui.ultOff;
  ui.ultFlame.texture = ready ? tex[A.hud.flameOn] : tex[A.hud.flameOff];
  ui.ultLabel.text = ready ? 'SẴN SÀNG!' : 'TUYỆT CHIÊU';
  ui.ultLabel.style.fill = ready ? 0xffe9a8 : 0xcfc9b8;
  if (ready && !ui.ultPulse) {
    let elapsed = 0;
    ui.ultPulse = (ticker: Ticker): void => {
      if (ui.card.destroyed) {
        if (ui.ultPulse) removeTick(ui.ultPulse);
        ui.ultPulse = null;
        return;
      }
      elapsed += ticker.deltaMS;
      const wave = (Math.sin(elapsed / 170) + 1) / 2;
      ui.ultFlame.scale.set(ui.ultFlameScale * (1 + wave * 0.14));
      ui.ultFrame.alpha = 0.88 + wave * 0.12;
      ui.ultLabel.alpha = 0.82 + wave * 0.18;
    };
    addTick(ui.ultPulse);
  } else if (!ready && ui.ultPulse) {
    removeTick(ui.ultPulse);
    ui.ultPulse = null;
    ui.ultFlame.scale.set(ui.ultFlameScale);
    ui.ultFrame.alpha = 1;
    ui.ultLabel.alpha = 1;
  }
}

export function disposeFighterUI(ui: FighterUI): void {
  for (const bar of [ui.hp, ui.mp, ui.fury]) {
    if (bar.anim) removeTick(bar.anim);
    bar.anim = null;
  }
  if (ui.ultPulse) removeTick(ui.ultPulse);
  ui.ultPulse = null;
}

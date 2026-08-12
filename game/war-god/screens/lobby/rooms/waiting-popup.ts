import { Container, Graphics } from 'pixi.js';
import type { RoomMember, RoomStateData } from '../../../../src/sdk';
import { HEADING, makeText, popIn, tween } from '../../../kit';
import { DESIGN_W } from '../../../layout';
import { makeWoodBtn } from '../ui';
import { betLabel, shortRoomCode } from './util';

const CARD_W = 470;
const CARD_H = 480;
const SEAT_W = 200;
const SEAT_H = 180;
const SEAT_Y = -30;
const SEAT_DX = 112;

interface WaitingRoomCallbacks {
  onToggleReady(): void;
  onStart(): void;
  onKick(userId: string): void;
  onLeave(): void;
}

let cb: WaitingRoomCallbacks;
let box: Container;
let dim: Graphics;
let card: Container;
let dyn: Container;

function makeSeat(x: number, crown: boolean, member: RoomMember | null): Container {
  const seat = new Container();
  const bg = new Graphics()
    .roundRect(-SEAT_W / 2, -SEAT_H / 2, SEAT_W, SEAT_H, 14)
    .fill({ color: 0x16263a, alpha: 0.92 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: member ? 0.75 : 0.3 });
  seat.addChild(bg);
  const role = makeText(crown ? '👑 CHỦ BÀN' : 'KHÁCH', 14, 0xffd84d, '800', HEADING);
  role.y = -SEAT_H / 2 + 26;
  seat.addChild(role);
  const name = makeText(member ? `@${member.name}` : 'Trống', 17, member ? 0xffffff : 0x8fa3b8, '800');
  if (name.width > SEAT_W - 28) name.scale.set((SEAT_W - 28) / name.width);
  name.y = -4;
  seat.addChild(name);
  let status = '';
  let color = 0x9fb2c8;
  if (!member) {
    status = 'Đang chờ...';
  } else if (!crown) {
    status = member.ready ? 'SẴN SÀNG' : 'CHƯA SẴN SÀNG';
    color = member.ready ? 0x7fe07f : 0xc7cdd6;
  }
  if (status) {
    const st = makeText(status, 13, color, '800');
    st.y = SEAT_H / 2 - 30;
    seat.addChild(st);
  }
  seat.x = x;
  seat.y = SEAT_Y;
  return seat;
}

export function renderWaitingRoom(
  state: RoomStateData | null,
  info: { roomId: string; bet: number } | null,
): void {
  if (!dyn) return;
  dyn.removeChildren().forEach((c) => c.destroy({ children: true }));
  const roomId = state?.roomId ?? info?.roomId ?? '';
  const bet = state?.bet ?? info?.bet ?? 0;
  const locked = state?.locked ?? false;
  const infoText = makeText(
    `Bàn #${shortRoomCode(roomId)}${locked ? ' 🔒' : ''} · Cược: ${betLabel(bet)}`,
    16,
    0xffe9a8,
    '700',
  );
  infoText.y = -CARD_H / 2 + 82;
  dyn.addChild(infoText);
  const owner = state?.members.find((m) => m.owner) ?? null;
  const guest = state?.members.find((m) => !m.owner) ?? null;
  dyn.addChild(makeSeat(-SEAT_DX, true, owner));
  dyn.addChild(makeSeat(SEAT_DX, false, guest));
  const btnY = CARD_H / 2 - 56;
  if (!state) {
    const loading = makeText('Đang tải...', 15, 0xc7cdd6, '700');
    loading.y = btnY;
    dyn.addChild(loading);
    return;
  }
  const meOwner = state.youId === state.ownerId;
  if (meOwner) {
    if (guest) {
      const kick = makeWoodBtn('MỜI RA', 128, 44, null, () => cb.onKick(guest.id));
      kick.x = SEAT_DX;
      kick.y = SEAT_Y + SEAT_H / 2 + 32;
      dyn.addChild(kick);
    }
    const start = makeWoodBtn('BẮT ĐẦU', 205, 62, null, () => cb.onStart());
    if (guest?.ready !== true) {
      start.alpha = 0.5;
      start.eventMode = 'none';
    }
    start.x = -112;
    start.y = btnY;
    dyn.addChild(start);
  } else {
    const me = state.members.find((m) => m.id === state.youId) ?? null;
    const ready = me?.ready === true;
    const readyBtn = makeWoodBtn(ready ? 'HỦY SẴN SÀNG' : 'SẴN SÀNG', 205, 62, null, () =>
      cb.onToggleReady(),
    );
    readyBtn.x = -112;
    readyBtn.y = btnY;
    dyn.addChild(readyBtn);
  }
  const leave = makeWoodBtn('RỜI BÀN', 165, 56, null, () => cb.onLeave());
  leave.x = 122;
  leave.y = btnY;
  dyn.addChild(leave);
}

export function openWaitingPopup(): void {
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
}

export function hideWaitingPopup(): void {
  if (box) box.visible = false;
}

export function isWaitingPopupOpen(): boolean {
  return box?.visible === true;
}

export function buildWaitingPopup(callbacks: WaitingRoomCallbacks): Container {
  cb = callbacks;
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  box.addChild(dim);

  card = new Container();
  const bg = new Graphics()
    .roundRect(-CARD_W / 2, -CARD_H / 2, CARD_W, CARD_H, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  card.addChild(bg);

  const title = makeText('PHÒNG CHỜ', 24, 0xffd84d, '700', HEADING);
  title.y = -CARD_H / 2 + 42;
  card.addChild(title);

  dyn = new Container();
  card.addChild(dyn);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutWaitingPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availH = designH - insetTop - insetBottom - 24;
  card.scale.set(Math.min(1, (DESIGN_W * 0.94) / CARD_W, availH / CARD_H));
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
}

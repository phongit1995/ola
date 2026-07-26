import { Container, Graphics, Rectangle, Text } from 'pixi.js';
import type { RoomInfo } from '../../../../src/sdk';
import { HEADING, makeText, popIn, tween } from '../../../kit';
import { makeWoodBtn } from '../ui';
import { betLabel } from './util';

const DESIGN_W = 520;
const CARD_W = 470;
const ROW_W = CARD_W - 44;
const ROW_H = 64;
const ROW_GAP = 10;

interface RoomListCallbacks {
  onCreate(): void;
  onRefresh(): void;
  onJoin(room: RoomInfo): void;
}

let cb: RoomListCallbacks;
let box: Container;
let dim: Graphics;
let card: Container;
let cardBg: Graphics;
let title: Text;
let viewport: Container;
let rowLayer: Container;
let listMask: Graphics;
let emptyText: Text;
let btnCreate: Container;
let btnRefresh: Container;
let btnClose: Container;
let cardH = 620;
let listTop = -220;
let listViewH = 340;
let contentH = 0;
let scrollOff = 0;
let dragMoved = 0;

function applyScroll(): void {
  const maxOff = Math.max(0, contentH - listViewH);
  scrollOff = Math.max(0, Math.min(maxOff, scrollOff));
  rowLayer.y = listTop - scrollOff;
}

function makeRow(room: RoomInfo): Container {
  const row = new Container();
  const full = room.full === true || room.players >= 2;
  const bg = new Graphics()
    .roundRect(-ROW_W / 2, 0, ROW_W, ROW_H, 12)
    .fill({ color: 0x1a2a40, alpha: 0.92 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: 0.35 });
  row.addChild(bg);
  const name = makeText(`@${room.owner}`, 16, 0xffffff, '800');
  name.anchor.set(0, 0.5);
  name.x = -ROW_W / 2 + 16;
  name.y = 20;
  if (name.width > ROW_W - 160) name.scale.set((ROW_W - 160) / name.width);
  row.addChild(name);
  const bet = makeText(betLabel(room.bet), 14, room.bet > 0 ? 0xffd84d : 0x9fe6a0, '700');
  bet.anchor.set(0, 0.5);
  bet.x = name.x;
  bet.y = 45;
  row.addChild(bet);
  const seats = makeText(`${room.players}/2`, 16, full ? 0xff9d9d : 0x9fe6a0, '800', HEADING);
  seats.anchor.set(1, 0.5);
  seats.x = ROW_W / 2 - 16;
  seats.y = ROW_H / 2;
  row.addChild(seats);
  if (room.locked) {
    const lock = makeText('🔒', 16, 0xffffff, '700');
    lock.anchor.set(1, 0.5);
    lock.x = seats.x - seats.width - 14;
    lock.y = ROW_H / 2;
    row.addChild(lock);
  }
  if (full) {
    row.alpha = 0.45;
  } else {
    row.eventMode = 'static';
    row.cursor = 'pointer';
    row.on('pointertap', () => {
      if (dragMoved < 8) cb.onJoin(room);
    });
  }
  return row;
}

export function renderRoomList(rooms: RoomInfo[]): void {
  if (!rowLayer) return;
  rowLayer.removeChildren().forEach((c) => c.destroy({ children: true }));
  let y = 0;
  for (const room of rooms) {
    const row = makeRow(room);
    row.y = y;
    rowLayer.addChild(row);
    y += ROW_H + ROW_GAP;
  }
  contentH = y > 0 ? y - ROW_GAP : 0;
  emptyText.visible = rooms.length === 0;
  applyScroll();
}

export function openRoomListPopup(): void {
  scrollOff = 0;
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  applyScroll();
}

export function hideRoomListPopup(): void {
  if (box) box.visible = false;
}

export function isRoomListPopupOpen(): boolean {
  return box?.visible === true;
}

export function buildRoomListPopup(callbacks: RoomListCallbacks): Container {
  cb = callbacks;
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', hideRoomListPopup);
  box.addChild(dim);

  card = new Container();
  cardBg = new Graphics();
  cardBg.eventMode = 'static';
  card.addChild(cardBg);

  title = makeText('PHÒNG ĐẤU', 24, 0xffd84d, '700', HEADING);
  card.addChild(title);

  viewport = new Container();
  viewport.eventMode = 'static';
  let dragY: number | null = null;
  viewport.on('pointerdown', (e) => {
    dragY = e.global.y;
    dragMoved = 0;
  });
  viewport.on('pointermove', (e) => {
    if (dragY == null) return;
    const scale = card.worldTransform.a || 1;
    const dy = e.global.y - dragY;
    dragMoved += Math.abs(dy / scale);
    scrollOff -= dy / scale;
    dragY = e.global.y;
    applyScroll();
  });
  const endDrag = (): void => {
    dragY = null;
  };
  viewport.on('pointerup', endDrag);
  viewport.on('pointerupoutside', endDrag);
  viewport.on('wheel', (e) => {
    scrollOff += e.deltaY / 3;
    applyScroll();
  });
  card.addChild(viewport);

  rowLayer = new Container();
  viewport.addChild(rowLayer);

  listMask = new Graphics();
  card.addChild(listMask);
  viewport.mask = listMask;

  emptyText = makeText('Chưa có bàn nào — tạo bàn mới nhé!', 15, 0xc7d3e0, '700');
  emptyText.style.wordWrap = true;
  emptyText.style.wordWrapWidth = ROW_W - 20;
  emptyText.style.align = 'center';
  emptyText.visible = false;
  card.addChild(emptyText);

  btnCreate = makeWoodBtn('TẠO BÀN', 145, 54, null, () => cb.onCreate());
  btnRefresh = makeWoodBtn('LÀM MỚI', 145, 54, null, () => cb.onRefresh());
  btnClose = makeWoodBtn('ĐÓNG', 115, 50, null, hideRoomListPopup);
  card.addChild(btnCreate, btnRefresh, btnClose);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutRoomListPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availH = designH - insetTop - insetBottom - 40;
  cardH = Math.max(420, Math.min(660, availH));
  cardBg
    .clear()
    .roundRect(-CARD_W / 2, -cardH / 2, CARD_W, cardH, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  title.y = -cardH / 2 + 42;
  listTop = -cardH / 2 + 78;
  listViewH = cardH / 2 - 96 - listTop;
  listMask.clear().rect(-ROW_W / 2 - 8, listTop, ROW_W + 16, listViewH).fill(0xffffff);
  viewport.hitArea = new Rectangle(-ROW_W / 2 - 8, listTop, ROW_W + 16, listViewH);
  emptyText.position.set(0, listTop + listViewH / 2);
  const btnY = cardH / 2 - 50;
  btnCreate.position.set(-142, btnY);
  btnRefresh.position.set(15, btnY);
  btnClose.position.set(157, btnY);
  card.scale.set(Math.max(0.4, Math.min(1, availH / cardH)));
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  applyScroll();
}

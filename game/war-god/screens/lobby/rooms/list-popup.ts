import { Assets, Container, Graphics, Rectangle, Sprite, Text, Texture } from 'pixi.js';
import type { RoomInfo, UserInfoData } from '../../../../src/sdk';
import { A, tex } from '../../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../../kit';
import { DESIGN_W } from '../../../layout';
import { avatarIconUrl } from '../../../vip';

const CONTENT_H = 1000;
const CARD_W = 486;
const PAGE_SIZE = 10;
// column centers (fraction of list width, relative to list center) from baked table dividers
const COL1_F = -0.298;
const COL2_F = 0.059;
const COL3_F = 0.357;
const CELL1_LEFT_F = -0.494;
const CELL2_LEFT_F = -0.102;
// horizontal band centers (fraction of list height): [0]=header, [1..10]=rows
const BAND_F = [0.04, 0.1215, 0.212, 0.3025, 0.3945, 0.4865, 0.5775, 0.6685, 0.76, 0.853, 0.9475];

interface RoomListCallbacks {
  onCreate(): void;
  onRefresh(): void;
  onJoin(room: RoomInfo): void;
  onTopUp(): void;
}

let cb: RoomListCallbacks;
let box: Container;
let bg: Sprite;
let card: Container;
let tableGroup: Container;
let table: Sprite;
let tableList: Sprite;
let banner: Sprite;
let bannerLabel: Text;
let headerLayer: Container;
let rowLayer: Container;
let emptyText: Text;
let pager: Container;
let prevBtn: Container;
let nextBtn: Container;
let pageLabel: Text;
let btnCreate: Container;
let btnRefresh: Container;
let btnClose: Container;
// top bar
let nameLabel: Text;
let avatarIcon: Sprite;
let kenLabel: Text;
let userAvatarLoadGen = 0;
let userAvatarRequestedUrl = '';

let tableH = 0;
let rowH = 0;
let listW = 0;
let listTopY = 0;
let listH = 0;
let rowCenters: number[] = [];
let col1 = 0;
let col2 = 0;
let col3 = 0;
let cell1Left = 0;
let cell2Left = 0;
let rooms: RoomInfo[] = [];
let page = 0;

function pageCount(): number {
  return Math.max(1, Math.ceil(rooms.length / PAGE_SIZE));
}

const AVATAR_COLORS = [0x4a86c7, 0xc75a4a, 0x4aa06a, 0xa96bc7, 0xc79a3a, 0x3aa9a0];

function fitText(t: Text, maxWidth: number): void {
  t.scale.set(1);
  if (t.width > maxWidth) t.scale.set(maxWidth / t.width);
}

function makeAvatar(room: RoomInfo, size: number): Container {
  const av = new Container();
  const color = AVATAR_COLORS[(room.owner.charCodeAt(0) || 0) % AVATAR_COLORS.length];
  av.addChild(new Graphics().circle(0, 0, size / 2).fill(color));
  const letter = makeText((room.owner[0] ?? '?').toUpperCase(), size * 0.5, 0xffffff, '800', HEADING);
  const icon = new Sprite(Texture.EMPTY);
  icon.anchor.set(0.5);
  icon.visible = false;
  const mask = new Graphics().circle(0, 0, size / 2).fill(0xffffff);
  icon.mask = mask;
  const border = new Graphics().circle(0, 0, size / 2).stroke({ width: 2.5, color: 0xf6c445, alpha: 0.9 });
  av.addChild(letter, icon, mask, border);
  void Assets.load<Texture>(avatarIconUrl(room.ownerVipType))
    .then((texture) => {
      if (av.destroyed) return;
      letter.visible = false;
      icon.texture = texture;
      icon.scale.set(Math.min((size * 1.02) / texture.width, (size * 1.02) / texture.height));
      icon.visible = true;
    })
    .catch(() => {});
  return av;
}

// Chữ nhỏ trên nền giấy sáng: dropShadow mặc định của makeText tạo quầng mờ
// quanh nét, tắt đi cho sắc.
function crispText(
  label: string,
  size: number,
  color: number,
  weight: '700' | '800' = '800',
): Text {
  const text = makeText(label, size, color, weight, HEADING);
  text.style.dropShadow = false;
  return text;
}

function makeRow(room: RoomInfo): Container {
  const row = new Container();
  const full = room.full === true || room.players >= 2;

  const avatar = makeAvatar(room, rowH * 0.82);
  avatar.x = cell1Left + rowH * 0.6;
  row.addChild(avatar);

  const name = crispText(`@${room.owner}`, 15, 0x3a2410);
  name.anchor.set(0, 0.5);
  name.x = avatar.x + rowH * 0.58;
  fitText(name, col2 - name.x - rowH * 0.5);
  row.addChild(name);

  const coin = new Sprite(tex[A.lobby.coin]);
  coin.anchor.set(0.5);
  coin.width = rowH * 0.52;
  coin.scale.y = coin.scale.x;
  coin.x = cell2Left + rowH * 0.4;
  row.addChild(coin);
  const bet = crispText(room.bet.toLocaleString('vi-VN'), 15, 0x3a2410);
  bet.anchor.set(0, 0.5);
  bet.x = coin.x + rowH * 0.42;
  fitText(bet, col3 - bet.x - listW * 0.14);
  row.addChild(bet);

  const badge = new Sprite(tex[full ? A.lobby.slotFull : A.lobby.slotOpen]);
  badge.anchor.set(0.5);
  badge.width = listW * 0.22;
  badge.scale.y = badge.scale.x;
  badge.x = col3;
  row.addChild(badge);
  const seats = crispText(`${room.players}/2`, 15, 0xffffff);
  seats.style.stroke = { color: 0x5b1c08, width: 2, join: 'round' };
  seats.x = col3;
  row.addChild(seats);
  if (room.locked) {
    const lock = new Sprite(tex[A.lobby.lock]);
    lock.anchor.set(0.5);
    lock.width = rowH * 0.56;
    lock.scale.y = lock.scale.x;
    lock.x = col3 - badge.width / 2 - rowH * 0.42;
    row.addChild(lock);
  }

  if (full) {
    row.alpha = 0.72;
  } else {
    row.eventMode = 'static';
    row.cursor = 'pointer';
    row.hitArea = new Rectangle(cell1Left, -rowH / 2, listW * 0.99, rowH);
    row.on('pointertap', () => cb.onJoin(room));
  }
  return row;
}

function renderPage(): void {
  if (!rowLayer) return;
  rowLayer.removeChildren().forEach((c) => c.destroy({ children: true }));
  const start = page * PAGE_SIZE;
  rooms.slice(start, start + PAGE_SIZE).forEach((room, i) => {
    const row = makeRow(room);
    row.y = rowCenters[i];
    rowLayer.addChild(row);
  });
  emptyText.visible = rooms.length === 0;
  pageLabel.text = `TRANG ${page + 1}`;
  fitText(pageLabel, CARD_W * 0.16);
  const count = pageCount();
  setPagerEnabled(prevBtn, page > 0);
  setPagerEnabled(nextBtn, page < count - 1);
  pager.visible = rooms.length > 0;
}

function setPagerEnabled(btn: Container, on: boolean): void {
  btn.eventMode = on ? 'static' : 'none';
  btn.cursor = on ? 'pointer' : 'default';
  btn.alpha = on ? 1 : 0.4;
}

export function renderRoomList(list: RoomInfo[]): void {
  rooms = list;
  if (page >= pageCount()) page = pageCount() - 1;
  renderPage();
}

export function setRoomListUser(info: UserInfoData | null): void {
  if (!nameLabel) return;
  if (!info) {
    userAvatarLoadGen++;
    userAvatarRequestedUrl = '';
    nameLabel.text = '';
    kenLabel.text = '0';
    avatarIcon.visible = false;
    return;
  }
  nameLabel.text = info.username;
  fitText(nameLabel, CARD_W * 0.42);
  kenLabel.text = info.ken.toLocaleString('vi-VN');
  fitText(kenLabel, CARD_W * 0.24);
  const requestedUrl = avatarIconUrl(info.vipType);
  if (requestedUrl === userAvatarRequestedUrl) return;
  userAvatarRequestedUrl = requestedUrl;
  const gen = ++userAvatarLoadGen;
  avatarIcon.visible = false;
  void Assets.load<Texture>(requestedUrl)
    .then((texture) => {
      if (avatarIcon.destroyed || gen !== userAvatarLoadGen) return;
      avatarIcon.texture = texture;
      avatarIcon.scale.set(Math.min(96 / texture.width, 96 / texture.height));
      avatarIcon.visible = true;
    })
    .catch(() => {
      if (gen === userAvatarLoadGen) userAvatarRequestedUrl = '';
    });
}

export function openRoomListPopup(): void {
  page = 0;
  box.visible = true;
  bg.alpha = 0;
  void tween(bg, { alpha: 1 }, 200);
  popIn(card, 0, 380);
}

export function hideRoomListPopup(): void {
  if (box) box.visible = false;
}

export function isRoomListPopupOpen(): boolean {
  return box?.visible === true;
}

function makeBlueButton(label: string, w: number, onTap: () => void): Container {
  const btn = new Container();
  const bgSprite = new Sprite(tex[A.lobby.btnBlue]);
  bgSprite.anchor.set(0.5);
  bgSprite.width = w;
  bgSprite.scale.y = bgSprite.scale.x;
  btn.addChild(bgSprite);
  const text = makeText(label, 18, 0xffffff, '800', HEADING);
  text.style.stroke = { color: 0x123a63, width: 3, join: 'round' };
  text.y = -bgSprite.height * 0.04;
  fitText(text, w * 0.74);
  btn.addChild(text);
  btn.hitArea = new Rectangle(-w * 0.5, -bgSprite.height * 0.42, w, bgSprite.height * 0.84);
  pressable(btn, onTap);
  return btn;
}

function makePagerButton(label: string, onTap: () => void): Container {
  const btn = new Container();
  const bgSprite = new Sprite(tex[A.lobby.pageArrow]);
  bgSprite.anchor.set(0.5);
  bgSprite.width = CARD_W * 0.18;
  bgSprite.scale.y = bgSprite.scale.x;
  btn.addChild(bgSprite);
  const text = makeText(label, 20, 0xffe9a8, '800', HEADING);
  text.style.stroke = { color: 0x4a2c0a, width: 3, join: 'round' };
  text.y = -1;
  btn.addChild(text);
  btn.hitArea = new Rectangle(-bgSprite.width * 0.6, -bgSprite.height * 0.6, bgSprite.width * 1.2, bgSprite.height * 1.2);
  pressable(btn, onTap);
  return btn;
}

function buildTopBar(): void {
  // left: avatar + name plate
  const nameFrame = new Sprite(tex[A.lobby.nameFrame]);
  nameFrame.anchor.set(0.5);
  nameFrame.width = 250;
  nameFrame.scale.y = nameFrame.scale.x;
  nameFrame.position.set(-118, -CONTENT_H / 2 + 118);
  card.addChild(nameFrame);
  nameLabel = crispText('', 20, 0xffe27a);
  nameLabel.style.stroke = { color: 0x5b1c08, width: 2, join: 'round' };
  nameLabel.position.set(nameFrame.x, nameFrame.y + 2);
  card.addChild(nameLabel);

  const avatarFrame = new Sprite(tex[A.lobby.avatarFrame]);
  avatarFrame.anchor.set(0.5);
  avatarFrame.width = 132;
  avatarFrame.scale.y = avatarFrame.scale.x;
  avatarFrame.position.set(nameFrame.x, nameFrame.y - 62);
  avatarIcon = new Sprite(Texture.EMPTY);
  avatarIcon.anchor.set(0.5);
  avatarIcon.position.set(avatarFrame.x, avatarFrame.y - 6);
  avatarIcon.visible = false;
  card.addChild(avatarIcon, avatarFrame);

  // right: ken box + plus
  const kenFrame = new Sprite(tex[A.lobby.kenFrame]);
  kenFrame.anchor.set(0.5);
  kenFrame.width = 188;
  kenFrame.scale.y = kenFrame.scale.x;
  kenFrame.position.set(120, -CONTENT_H / 2 + 118);
  card.addChild(kenFrame);
  kenLabel = crispText('0', 22, 0xffffff);
  kenLabel.anchor.set(0.5, 0.5);
  kenLabel.style.stroke = { color: 0x123a63, width: 3, join: 'round' };
  kenLabel.position.set(kenFrame.x + 22, kenFrame.y);
  card.addChild(kenLabel);
  const kenCoin = new Sprite(tex[A.lobby.coin]);
  kenCoin.anchor.set(0.5);
  kenCoin.width = 62;
  kenCoin.scale.y = kenCoin.scale.x;
  kenCoin.position.set(kenFrame.x - kenFrame.width / 2 + 4, kenFrame.y);
  card.addChild(kenCoin);
  const plus = new Container();
  const plusBg = new Sprite(tex[A.lobby.btnPlus]);
  plusBg.anchor.set(0.5);
  plusBg.width = 58;
  plusBg.scale.y = plusBg.scale.x;
  plus.addChild(plusBg);
  const plusIc = new Sprite(tex[A.lobby.icPlus]);
  plusIc.anchor.set(0.5);
  plusIc.width = 26;
  plusIc.scale.y = plusIc.scale.x;
  plus.addChild(plusIc);
  plus.position.set(kenFrame.x + kenFrame.width / 2 + 8, kenFrame.y);
  plus.hitArea = new Rectangle(-34, -34, 68, 68);
  pressable(plus, () => cb.onTopUp());
  card.addChild(plus);
}

export function buildRoomListPopup(callbacks: RoomListCallbacks): Container {
  cb = callbacks;
  box = new Container();
  bg = new Sprite(tex[A.lobby.parchment]);
  bg.eventMode = 'static';
  box.addChild(bg);

  card = new Container();

  buildTopBar();

  tableGroup = new Container();
  card.addChild(tableGroup);

  table = new Sprite(tex[A.lobby.tableFrame]);
  table.anchor.set(0.5);
  table.width = CARD_W;
  table.scale.y = table.scale.x;
  table.eventMode = 'static';
  tableH = table.height;
  tableGroup.addChild(table);

  tableList = new Sprite(tex[A.lobby.tableList]);
  tableList.anchor.set(0.5);
  tableGroup.addChild(tableList);

  headerLayer = new Container();
  for (const label of ['CHỦ BÀN', 'KEN CƯỢC', 'THAM GIA']) {
    const t = crispText(label, 15, 0xffe15a);
    t.style.stroke = { color: 0x5a2a08, width: 3, join: 'round' };
    headerLayer.addChild(t);
  }
  tableGroup.addChild(headerLayer);

  rowLayer = new Container();
  tableGroup.addChild(rowLayer);

  emptyText = makeText('Chưa có bàn nào — tạo bàn mới nhé!', 15, 0xffe9c4, '700', HEADING);
  emptyText.style.wordWrap = true;
  emptyText.style.wordWrapWidth = CARD_W * 0.7;
  emptyText.style.align = 'center';
  emptyText.visible = false;
  tableGroup.addChild(emptyText);

  pager = new Container();
  prevBtn = makePagerButton('<', () => {
    if (page > 0) {
      page--;
      renderPage();
    }
  });
  nextBtn = makePagerButton('>', () => {
    if (page < pageCount() - 1) {
      page++;
      renderPage();
    }
  });
  const pageFrame = new Sprite(tex[A.lobby.pageCurrent]);
  pageFrame.anchor.set(0.5);
  pageFrame.width = CARD_W * 0.28;
  pageFrame.scale.y = pageFrame.scale.x;
  pageLabel = crispText('TRANG 1', 17, 0xffffff);
  pageLabel.style.stroke = { color: 0x123a63, width: 3, join: 'round' };
  prevBtn.x = -CARD_W * 0.26;
  nextBtn.x = CARD_W * 0.26;
  pager.addChild(pageFrame, pageLabel, prevBtn, nextBtn);
  tableGroup.addChild(pager);

  banner = new Sprite(tex[A.lobby.pvpTitle]);
  banner.anchor.set(0.5);
  banner.width = CARD_W * 0.62;
  banner.scale.y = banner.scale.x;
  tableGroup.addChild(banner);
  bannerLabel = makeText('ĐẤU 1V1', 24, 0xffe9a8, '800', HEADING);
  bannerLabel.style.stroke = { color: 0x6a1410, width: 3, join: 'round' };
  tableGroup.addChild(bannerLabel);

  const btnW = CARD_W * 0.32;
  btnCreate = makeBlueButton('TẠO BÀN', btnW, () => cb.onCreate());
  btnRefresh = makeBlueButton('LÀM MỚI', btnW, () => cb.onRefresh());
  btnClose = makeBlueButton('THOÁT', btnW, hideRoomListPopup);
  card.addChild(btnCreate, btnRefresh, btnClose);

  box.addChild(card);
  box.visible = false;
  layoutStatic();
  return box;
}

function layoutStatic(): void {
  const top = -tableH / 2;

  banner.y = top + tableH * 0.012;
  bannerLabel.y = banner.y - 1;
  fitText(bannerLabel, banner.width * 0.6);

  // striped list image sits inside the frame's wood interior, below the banner
  listW = CARD_W * 0.9;
  listH = tableH * 0.78;
  listTopY = top + tableH * 0.105;
  tableList.width = listW;
  tableList.height = listH;
  tableList.position.set(0, listTopY + listH / 2);

  col1 = COL1_F * listW;
  col2 = COL2_F * listW;
  col3 = COL3_F * listW;
  cell1Left = CELL1_LEFT_F * listW;
  cell2Left = CELL2_LEFT_F * listW;
  rowH = (BAND_F[2] - BAND_F[1]) * listH;
  rowCenters = BAND_F.slice(1).map((f) => listTopY + f * listH);

  const headerY = listTopY + BAND_F[0] * listH;
  const headerX = [col1, col2, col3];
  (headerLayer.children as Text[]).forEach((t, i) => t.position.set(headerX[i], headerY));

  emptyText.position.set(0, listTopY + listH * 0.5);
  pager.y = listTopY + listH + (tableH / 2 - (listTopY + listH)) * 0.5;

  // place the whole table block, then the buttons under it
  tableGroup.y = -CONTENT_H / 2 + 250 + tableH / 2;
  const btnGap = CARD_W * 0.02;
  const btnW = CARD_W * 0.32;
  const btnRowW = btnW * 3 + btnGap * 2;
  const btnY = tableGroup.y + tableH / 2 + 52;
  btnCreate.position.set(-btnRowW / 2 + btnW / 2, btnY);
  btnRefresh.position.set(0, btnY);
  btnClose.position.set(btnRowW / 2 - btnW / 2, btnY);
}

export function layoutRoomListPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  const bgTex = bg.texture;
  const cover = Math.max(DESIGN_W / bgTex.width, designH / bgTex.height);
  bg.scale.set(cover);
  bg.x = (DESIGN_W - bgTex.width * cover) / 2;
  bg.y = (designH - bgTex.height * cover) / 2;

  const availH = designH - insetTop - insetBottom;
  const fit = Math.min(1, DESIGN_W / CARD_W, availH / CONTENT_H);
  card.scale.set(fit);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  renderPage();
}

import { Container, Graphics, Rectangle, Sprite, type Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText, pressable } from '../../kit';
import { DESIGN_W } from '../../layout';
import {
  ARMOR_SHIELD,
  DMG_SWORD,
  FIRE_SWORD_DMG,
  FURY_DAMAGE_MULTIPLIER,
  FURY_PEACH,
  GREATER_HEART_HEAL,
  HEAL_HEART,
  LIGHTNING_GOD_DAMAGE,
  MAX_ARMOR,
  MAX_EXTRA_TURNS,
  MAX_FURY,
  MAX_HP,
  MP_WATER,
  TURN_SECONDS,
  ULT_COST,
} from '../../logic/constants.gen';
import { createCardModal, type CardModal } from './card-modal';
import { makeWoodBtn } from './ui';

type GuidePage = 'items' | 'rules';

interface GuideItem {
  asset: string;
  title: string;
  detail: string;
  accent: number;
}

type GuideRule = GuideItem;

const PANEL_W = 448;
const VISUAL_EXTRA_H = 40;
const TAB_W = 178;
const TAB_H = 38;
const ITEM_CARD_W = 194;
const ITEM_CARD_H = 68;
const RULE_CARD_W = 398;
const RULE_CARD_H = 56;

const ITEMS: GuideItem[] = [
  {
    asset: A.items.sword,
    title: 'KIẾM',
    detail: `${DMG_SWORD} ST · GIÁP CHẶN`,
    accent: 0xffcf62,
  },
  {
    asset: A.items.water,
    title: 'NƯỚC',
    detail: `+${MP_WATER} NỘI LỰC`,
    accent: 0x62cfff,
  },
  {
    asset: A.items.peach,
    title: 'ĐÀO',
    detail: `+${FURY_PEACH} NỘ`,
    accent: 0xffa45c,
  },
  {
    asset: A.items.heart,
    title: 'TIM',
    detail: `+${HEAL_HEART} MÁU`,
    accent: 0xff6b7d,
  },
  {
    asset: A.items.shield,
    title: 'KHIÊN',
    detail: `+${ARMOR_SHIELD} GIÁP · TỐI ĐA ${MAX_ARMOR}`,
    accent: 0x86c5ff,
  },
  {
    asset: A.items.lightning,
    title: 'LÔI',
    detail: 'GHÉP / TRÚNG NỔ → GIẬT 1 Ô',
    accent: 0xffe567,
  },
  {
    asset: A.items.fireSword,
    title: 'KIẾM LỬA · HIẾM',
    detail: `${FIRE_SWORD_DMG} SÁT THƯƠNG · NỔ 3×3`,
    accent: 0xff8051,
  },
  {
    asset: A.items.greaterHeart,
    title: 'TIM LỚN · HIẾM',
    detail: `+${GREATER_HEART_HEAL} MÁU`,
    accent: 0xff8dbb,
  },
  {
    asset: A.items.flyingDart,
    title: 'PHI TIÊU · ĐẶC BIỆT',
    detail: 'GHÉP 5 NƯỚC ĐỂ TẠO · THAY 1 Ô TRONG COMBO 3+ → QUÉT HÀNG / CỘT',
    accent: 0x43dcff,
  },
];

const RULES: GuideRule[] = [
  {
    asset: A.items.sword,
    title: 'COMBO 4+ · SẬP',
    detail: `Cụm 4+: +1 lượt, dự trữ tối đa ${MAX_EXTRA_TURNS} · Sập tăng hiệu ứng +10%/tầng, tối đa +30%`,
    accent: 0xffcf62,
  },
  {
    asset: A.items.peach,
    title: `NỘ ĐẦY ${MAX_FURY}`,
    detail: `Đòn Kiếm kế tiếp ×${FURY_DAMAGE_MULTIPLIER} sát thương suốt chuỗi sập · dùng xong Nộ về 0`,
    accent: 0xffa45c,
  },
  {
    asset: A.items.shield,
    title: 'GIÁP HỘ THỂ',
    detail: '1 giáp chặn 1 sát thương · hết giáp mới trừ máu',
    accent: 0x86c5ff,
  },
  {
    asset: A.items.lightning,
    title: 'LÔI THẦN GIÁNG THẾ',
    detail: `Tuyệt chiêu ${ULT_COST} nội lực · ${LIGHTNING_GOD_DAMAGE} ST + 4 tia phá 2×2 · ô bị phá cộng hiệu ứng, Lôi bắn tia phụ`,
    accent: 0xb388ff,
  },
  {
    asset: A.hud.flameOn,
    title: 'VẠN KIẾM QUY TÔNG',
    detail: `Tuyệt chiêu ${ULT_COST} nội lực · ${
      ULT_COST / 2
    } sát thương chắc chắn, đòn dứt điểm ổn định`,
    accent: 0xff8051,
  },
  {
    asset: A.items.heart,
    title: 'MỤC TIÊU · HẾT GIỜ',
    detail: `Hạ đối thủ từ ${MAX_HP} máu về 0 · Mỗi lượt ${TURN_SECONDS}s, hết giờ mất lượt — 3 lần liên tiếp bị xử thua`,
    accent: 0xff6b7d,
  },
];

let modal: CardModal;
let content: Container;
let panelH = 0;
let itemsPage: Container;
let rulesPage: Container;
let itemsTabBg: Graphics;
let rulesTabBg: Graphics;
let itemsTabText: Text;
let rulesTabText: Text;
let currentPage: GuidePage = 'items';

function fitLabel(label: Text, maxWidth: number): void {
  if (label.width > maxWidth) label.scale.set(maxWidth / label.width);
}

function makeItemIcon(asset: string, maxSize: number): Sprite {
  const icon = new Sprite(tex[asset]);
  icon.anchor.set(0.5);
  const scale = Math.min(maxSize / icon.texture.width, maxSize / icon.texture.height);
  icon.scale.set(scale);
  return icon;
}

function makeItemCard(item: GuideItem): Container {
  const card = new Container();
  const bg = new Graphics()
    .roundRect(-ITEM_CARD_W / 2, -ITEM_CARD_H / 2, ITEM_CARD_W, ITEM_CARD_H, 12)
    .fill({ color: 0x111f31, alpha: 0.94 })
    .stroke({ width: 1.5, color: item.accent, alpha: 0.9 });
  card.addChild(bg);

  const iconHalo = new Graphics()
    .circle(-68, 0, 25)
    .fill({ color: 0x071320, alpha: 0.92 })
    .stroke({ width: 1, color: item.accent, alpha: 0.72 });
  card.addChild(iconHalo);
  const icon = makeItemIcon(item.asset, 44);
  icon.x = -68;
  card.addChild(icon);

  const title = makeText(item.title, 13, item.accent, '800', HEADING);
  title.anchor.set(0, 0.5);
  title.position.set(-36, -11);
  fitLabel(title, 124);
  card.addChild(title);

  const detail = makeText(item.detail, 11, 0xfff2d5, '700', HEADING);
  detail.anchor.set(0, 0.5);
  detail.position.set(-36, 12);
  detail.style.wordWrap = true;
  detail.style.wordWrapWidth = 126;
  detail.style.lineHeight = 12;
  fitLabel(detail, 126);
  card.addChild(detail);
  return card;
}

function makeRuleCard(rule: GuideRule): Container {
  const card = new Container();
  const bg = new Graphics()
    .roundRect(-RULE_CARD_W / 2, -RULE_CARD_H / 2, RULE_CARD_W, RULE_CARD_H, 12)
    .fill({ color: 0x111f31, alpha: 0.94 })
    .stroke({ width: 1.5, color: rule.accent, alpha: 0.85 });
  card.addChild(bg);

  const iconHalo = new Graphics()
    .circle(-169, 0, 21)
    .fill({ color: 0x071320, alpha: 0.92 })
    .stroke({ width: 1, color: rule.accent, alpha: 0.72 });
  card.addChild(iconHalo);
  const icon = makeItemIcon(rule.asset, 36);
  icon.x = -169;
  card.addChild(icon);

  const title = makeText(rule.title, 13, rule.accent, '800', HEADING);
  title.anchor.set(0, 0.5);
  title.position.set(-139, -10);
  card.addChild(title);

  const detail = makeText(rule.detail, 11, 0xfff2d5, '700', HEADING);
  detail.anchor.set(0, 0.5);
  detail.position.set(-139, 11);
  detail.style.wordWrap = true;
  detail.style.wordWrapWidth = 315;
  detail.style.lineHeight = 12;
  fitLabel(detail, 315);
  card.addChild(detail);
  return card;
}

function drawTab(bg: Graphics, label: Text, active: boolean): void {
  bg.clear()
    .roundRect(-TAB_W / 2, -TAB_H / 2, TAB_W, TAB_H, 12)
    .fill({ color: active ? 0x912a1d : 0x29180f, alpha: active ? 0.98 : 0.88 })
    .stroke({
      width: active ? 2 : 1.5,
      color: active ? 0xffdf68 : 0xb8782e,
      alpha: 0.96,
    });
  label.style.fill = active ? 0xffef9a : 0xd9b77d;
  label.alpha = active ? 1 : 0.8;
}

function setPage(page: GuidePage): void {
  currentPage = page;
  itemsPage.visible = page === 'items';
  rulesPage.visible = page === 'rules';
  drawTab(itemsTabBg, itemsTabText, page === 'items');
  drawTab(rulesTabBg, rulesTabText, page === 'rules');
}

function makeTab(label: string, page: GuidePage): Container {
  const tab = new Container();
  const bg = new Graphics();
  const text = makeText(label, 14, 0xffef9a, '800', HEADING);
  text.style.stroke = { color: 0x401006, width: 2.5, join: 'round' };
  tab.addChild(bg, text);
  tab.hitArea = new Rectangle(-TAB_W / 2, -TAB_H / 2, TAB_W, TAB_H);
  pressable(tab, () => setPage(page));
  if (page === 'items') {
    itemsTabBg = bg;
    itemsTabText = text;
  } else {
    rulesTabBg = bg;
    rulesTabText = text;
  }
  return tab;
}

function closeGuidePopup(): void {
  modal.close();
}

export function openGuidePopup(): void {
  setPage('items');
  modal.open();
}

export function hideGuidePopup(): void {
  modal.hide();
}

export function buildGuidePopup(): Container {
  modal = createCardModal(closeGuidePopup, 0.8);
  content = new Container();
  modal.card.addChild(content);

  const panel = new Sprite(tex[A.lobby.createPanel]);
  panel.anchor.set(0.5);
  panel.width = PANEL_W;
  panel.scale.y = panel.scale.x;
  panel.eventMode = 'static';
  content.addChild(panel);
  panelH = panel.height;
  const halfH = panelH / 2;

  const title = new Container();
  const titleFrame = new Sprite(tex[A.lobby.createTitle]);
  titleFrame.anchor.set(0.5);
  titleFrame.width = PANEL_W * 0.68;
  titleFrame.scale.y = titleFrame.scale.x;
  title.addChild(titleFrame);
  const titleText = makeText('HƯỚNG DẪN', 25, 0xffe15a, '800', HEADING);
  titleText.style.stroke = { color: 0x4a1206, width: 4, join: 'round' };
  titleText.y = -titleFrame.height * 0.04;
  title.addChild(titleText);
  title.y = -halfH + 30;
  content.addChild(title);

  const close = new Container();
  const closeBase = new Sprite(tex[A.lobby.btnX]);
  closeBase.anchor.set(0.5);
  closeBase.width = PANEL_W * 0.13;
  closeBase.scale.y = closeBase.scale.x;
  const closeIcon = new Sprite(tex[A.lobby.icX]);
  closeIcon.anchor.set(0.5);
  closeIcon.width = PANEL_W * 0.066;
  closeIcon.scale.y = closeIcon.scale.x;
  close.addChild(closeBase, closeIcon);
  close.position.set(PANEL_W / 2 - 31, -halfH + 34);
  close.hitArea = new Rectangle(-36, -36, 72, 72);
  pressable(close, closeGuidePopup);
  content.addChild(close);

  const itemsTab = makeTab('VẬT PHẨM', 'items');
  itemsTab.position.set(-95, -175);
  const rulesTab = makeTab('LUẬT CHIẾN', 'rules');
  rulesTab.position.set(95, -175);
  content.addChild(itemsTab, rulesTab);

  itemsPage = new Container();
  ITEMS.forEach((item, index) => {
    const card = makeItemCard(item);
    card.position.set(index % 2 === 0 ? -101 : 101, -115 + Math.floor(index / 2) * 70);
    itemsPage.addChild(card);
  });
  const explosionHint = makeText('Ô TRONG VÙNG NỔ VẪN CỘNG HIỆU ỨNG', 11, 0xffdda0, '800', HEADING);
  explosionHint.y = 211;
  explosionHint.style.stroke = { color: 0x51210d, width: 2.5, join: 'round' };
  itemsPage.addChild(explosionHint);
  content.addChild(itemsPage);

  rulesPage = new Container();
  RULES.forEach((rule, index) => {
    const card = makeRuleCard(rule);
    card.y = -126 + index * 57;
    rulesPage.addChild(card);
  });
  content.addChild(rulesPage);

  const ok = makeWoodBtn('ĐÃ HIỂU', 178, 56, null, closeGuidePopup);
  ok.y = halfH - 30;
  content.addChild(ok);

  setPage(currentPage);
  return modal.box;
}

export function layoutGuidePopup(designH: number, insetTop = 0, insetBottom = 0): void {
  modal.layout(designH);
  const availableH = designH - insetTop - insetBottom - 24;
  const availableW = DESIGN_W * 0.96;
  const visualH = panelH + VISUAL_EXTRA_H;
  const fitScale = Math.min(1, availableW / PANEL_W, availableH / visualH);
  content.scale.set(fitScale);
  modal.card.y = insetTop + (designH - insetTop - insetBottom) / 2;
}

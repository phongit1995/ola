import { Container, Graphics } from 'pixi.js';
import { HEADING, makeText } from '../../kit';
import {
  ARMOR_DECAY,
  ARMOR_SHIELD,
  DMG_SWORD,
  FIRE_SWORD_DMG,
  FURY_PEACH,
  GREATER_HEART_HEAL,
  HEAL_HEART,
  MAX_ARMOR,
  MAX_FURY,
  MAX_HP,
  MP_WATER,
  REFLECT_DAMAGE,
  REFLECT_THRESHOLD,
  ULT_COST,
} from '../../logic/constants.gen';
import { createCardModal, type CardModal } from './card-modal';
import { makeWoodBtn } from './ui';

const GUIDE_LINES = [
  'Ghép 3 ô cùng loại để kích hoạt:',
  `⚔️ Kiếm ${DMG_SWORD} dmg (giáp chặn được)`,
  `💧 Nước +${MP_WATER} nội lực · 🍑 Đào +${FURY_PEACH} Nộ`,
  `❤️ Tim +${HEAL_HEART} máu · 🛡️ Khiên +${ARMOR_SHIELD} giáp (tối đa ${MAX_ARMOR})`,
  '⚡ Lôi: mỗi ô được ghép / bị Kiếm Lửa nổ trúng → giật 1 ô',
  '',
  `🔥⚔️ Kiếm Lửa (hiếm): ${FIRE_SWORD_DMG} dmg xuyên giáp + nổ 3×3`,
  `❤️➕ Tim Lớn (hiếm): hồi ${GREATER_HEART_HEAL} máu`,
  'Ô bị nổ vẫn tính hiệu ứng.',
  '',
  `Nộ đầy ${MAX_FURY} → đòn Kiếm kế ×2, xuyên giáp.`,
  `Khiên: giảm ${ARMOR_DECAY}/lượt, ≥${REFLECT_THRESHOLD} giáp phản ${REFLECT_DAMAGE} dmg.`,
  'Mỗi cụm ghép liền 4+ ô (kể cả hình T/L): +1 lượt · được cộng dồn.',
  `Tuyệt chiêu: cần ${ULT_COST} nội lực, dmg = nội lực ÷ 2.`,
  `Hạ gục đối thủ (${MAX_HP} máu) để thắng!`,
].join('\n');

let modal: CardModal;

export function openGuidePopup(): void {
  modal.open();
}

export function hideGuidePopup(): void {
  modal.hide();
}

export function buildGuidePopup(): Container {
  modal = createCardModal(hideGuidePopup);
  const { card } = modal;
  const cardW = 440;
  const cardH = 500;
  const bg = new Graphics()
    .roundRect(-cardW / 2, -cardH / 2, cardW, cardH, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  card.addChild(bg);

  const title = makeText('HƯỚNG DẪN', 24, 0xffd84d, '700', HEADING);
  title.y = -cardH / 2 + 44;
  card.addChild(title);

  const body = makeText(GUIDE_LINES, 13, 0xffffff, '700');
  body.anchor.set(0.5, 0);
  body.style.wordWrap = true;
  body.style.wordWrapWidth = cardW - 56;
  body.style.align = 'left';
  body.style.lineHeight = 19;
  body.y = -cardH / 2 + 62;
  card.addChild(body);

  const ok = makeWoodBtn('ĐÃ HIỂU', 200, 62, null, hideGuidePopup);
  ok.y = cardH / 2 - 52;
  card.addChild(ok);

  return modal.box;
}

export function layoutGuidePopup(designH: number): void {
  modal.layout(designH);
}

import { Container, Graphics } from 'pixi.js';
import { HEADING, makeText, popIn, tween } from '../../kit';
import { makeWoodBtn } from './ui';

const DESIGN_W = 520;

const GUIDE_LINES = [
  'Ghép 3 ô cùng loại để kích hoạt:',
  '⚔️ Kiếm 7 dmg (giáp chặn được)',
  '💧 Nước +7 nội lực · 🍑 Đào +10 Nộ',
  '❤️ Tim +5 máu · 🛡️ Khiên +5 giáp (tối đa 30)',
  '⚡ Lôi: ghép 3 → nổ chữ thập 5 ô',
  '',
  '🔥⚔️ Kiếm Lửa (hiếm): 12 dmg xuyên giáp + nổ 3×3',
  '❤️➕ Tim Lớn (hiếm): hồi 10 máu',
  'Ô bị nổ vẫn tính hiệu ứng.',
  '',
  'Nộ đầy 100 → đòn Kiếm kế ×2, xuyên giáp.',
  'Khiên: giảm 2/lượt, ≥20 giáp phản 2 dmg.',
  'Mỗi đường ghép 4+ ô: +1 lượt · được cộng dồn.',
  'Tuyệt chiêu: cần 50 nội lực, dmg = nội lực ÷ 2.',
  'Hạ gục đối thủ (200 máu) để thắng!',
].join('\n');

let box: Container;
let dim: Graphics;
let card: Container;

export function openGuidePopup(): void {
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
}

export function hideGuidePopup(): void {
  box.visible = false;
}

export function buildGuidePopup(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', hideGuidePopup);
  box.addChild(dim);

  card = new Container();
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

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutGuidePopup(designH: number): void {
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  card.x = DESIGN_W / 2;
  card.y = designH / 2;
}

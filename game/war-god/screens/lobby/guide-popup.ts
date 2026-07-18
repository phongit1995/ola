import { Container, Graphics } from 'pixi.js';
import { HEADING, makeText, popIn, tween } from '../../kit';
import { makeWoodBtn } from './ui';

const DESIGN_W = 520;

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
  const cardH = 400;
  const bg = new Graphics()
    .roundRect(-cardW / 2, -cardH / 2, cardW, cardH, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  card.addChild(bg);

  const title = makeText('HƯỚNG DẪN', 24, 0xffd84d, '700', HEADING);
  title.y = -cardH / 2 + 44;
  card.addChild(title);

  const body = makeText(GUIDE_LINES, 15, 0xffffff, '700');
  body.style.wordWrap = true;
  body.style.wordWrapWidth = cardW - 56;
  body.style.align = 'left';
  body.style.lineHeight = 24;
  body.y = 4;
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

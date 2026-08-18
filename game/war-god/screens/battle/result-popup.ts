import { Container, Graphics, Rectangle, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../kit';
import { DESIGN_W } from '../../layout';

const PANEL_W = 375;
const RESULT_REVEAL = {
  dim: 260,
  card: 500,
  titleFrameDelay: 70,
  titleDelay: 120,
  outcomeDelay: 190,
  brushDelay: 300,
  verdictDelay: 350,
  detailDelay: 430,
  kenDelay: 510,
  replayDelay: 620,
  closeDelay: 690,
} as const;

export type ResultOutcome = 'win' | 'lose' | 'draw';

export interface ResultPopupData {
  outcome: ResultOutcome;
  detail: string;
  kenText?: string;
}

export interface ResultPopup {
  view: Container;
  show(data: ResultPopupData): void;
  hide(): void;
  layout(designH: number, insetTop: number, insetBottom: number): void;
}

function fitText(text: Text, maxWidth: number): void {
  text.scale.set(1);
  if (text.width > maxWidth) text.scale.set(maxWidth / text.width);
}

export function buildResultPopup(onClose: () => void, onReplay: () => void): ResultPopup {
  const view = new Container();
  const dim = new Graphics();
  const card = new Container();
  let cancelReveal: Array<() => void> = [];

  function stopReveal(): void {
    cancelReveal.forEach((cancel) => cancel());
    cancelReveal = [];
  }

  function reveal(target: Container, delay: number, duration: number): void {
    cancelReveal.push(popIn(target, delay, duration));
  }

  function hidePopup(): void {
    stopReveal();
    view.visible = false;
    card.alpha = 1;
  }

  dim.eventMode = 'static';
  view.addChild(dim, card);

  const panel = new Sprite(tex[A.result.panel]);
  panel.anchor.set(0.5);
  panel.width = PANEL_W;
  panel.scale.y = panel.scale.x;
  panel.eventMode = 'static';
  card.addChild(panel);
  const panelH = panel.height;
  const halfH = panelH / 2;

  const titleFrame = new Sprite(tex[A.result.titleFrame]);
  titleFrame.anchor.set(0.5);
  titleFrame.width = PANEL_W * 0.72;
  titleFrame.scale.y = titleFrame.scale.x;
  titleFrame.y = -halfH;
  card.addChild(titleFrame);

  const title = makeText('KẾT QUẢ', 38, 0xffdf62, '800', HEADING);
  title.style.letterSpacing = 1;
  title.y = titleFrame.y - 2;
  fitText(title, titleFrame.width * 0.67);
  card.addChild(title);

  const brush = new Sprite(tex[A.result.brushWin]);
  brush.anchor.set(0.5);
  brush.width = PANEL_W * 0.73;
  brush.scale.y = brush.scale.x;
  brush.y = panelH * 0.075;
  card.addChild(brush);

  const outcomeIcon = new Sprite(tex[A.result.cupWin]);
  outcomeIcon.anchor.set(0.5);
  outcomeIcon.width = PANEL_W * 0.36;
  outcomeIcon.scale.y = outcomeIcon.scale.x;
  outcomeIcon.y = -panelH * 0.145;
  card.addChild(outcomeIcon);

  const verdict = makeText('THẮNG', 50, 0xffffff, '800', HEADING);
  verdict.style.fontStyle = 'italic';
  verdict.style.letterSpacing = 1;
  verdict.style.stroke = { color: 0x5b1c08, width: 2, join: 'round' };
  verdict.rotation = -0.035;
  verdict.y = brush.y - 2;
  card.addChild(verdict);

  const detail = makeText('', 11, 0xfff0c5, '700', HEADING);
  detail.style.wordWrap = true;
  detail.style.wordWrapWidth = PANEL_W * 0.56;
  detail.style.align = 'center';
  detail.y = brush.y + panelH * 0.072;
  card.addChild(detail);

  const kenBox = new Container();
  const kenFrame = new Sprite(tex[A.result.kenFrame]);
  kenFrame.anchor.set(0.5);
  kenFrame.width = PANEL_W * 0.87;
  kenFrame.scale.y = kenFrame.scale.x;
  kenBox.addChild(kenFrame);

  const kenIcon = new Sprite(tex[A.result.ken]);
  kenIcon.anchor.set(0.5);
  kenIcon.height = kenFrame.height * 0.72;
  kenIcon.scale.x = kenIcon.scale.y;
  kenBox.addChild(kenIcon);

  const kenText = makeText('', 21, 0xffdf62, '800', HEADING);
  kenText.style.stroke = { color: 0x6f2607, width: 2, join: 'round' };
  kenText.style.letterSpacing = 0.4;
  kenBox.addChild(kenText);
  kenBox.y = panelH * 0.32;
  card.addChild(kenBox);

  const BTN_W = PANEL_W * 0.36;
  const BTN_GAP = PANEL_W * 0.045;

  function makeButton(label: string, background: string, onTap: () => void): Container {
    const btn = new Container();
    const bg = new Sprite(tex[background]);
    bg.anchor.set(0.5);
    bg.width = BTN_W;
    bg.scale.y = bg.scale.x;
    btn.addChild(bg);
    const text = makeText(label, 18, 0xffdf62, '700', HEADING);
    text.y = -1;
    fitText(text, BTN_W * 0.74);
    btn.addChild(text);
    btn.hitArea = new Rectangle(-BTN_W * 0.55, -bg.height * 0.8, BTN_W * 1.1, bg.height * 1.6);
    btn.y = halfH;
    pressable(btn, () => {
      hidePopup();
      onTap();
    });
    return btn;
  }

  const replayButton = makeButton('CHƠI LẠI', A.result.btnReplay, onReplay);
  const closeButton = makeButton('ĐÓNG', A.result.btnClose, onClose);
  replayButton.x = -(BTN_W + BTN_GAP) / 2;
  closeButton.x = (BTN_W + BTN_GAP) / 2;
  card.addChild(replayButton, closeButton);

  function arrangeKen(): void {
    const gap = 9;
    fitText(kenText, kenFrame.width * 0.66);
    const contentW = kenIcon.width + gap + kenText.width;
    kenIcon.x = -contentW / 2 + kenIcon.width / 2;
    kenText.x = -contentW / 2 + kenIcon.width + gap + kenText.width / 2;
  }

  view.visible = false;
  return {
    view,
    show(data): void {
      stopReveal();
      const lose = data.outcome === 'lose';
      outcomeIcon.texture = tex[lose ? A.result.shieldLose : A.result.cupWin];
      outcomeIcon.width = PANEL_W * (lose ? 0.48 : 0.46);
      outcomeIcon.scale.y = outcomeIcon.scale.x;
      outcomeIcon.tint = data.outcome === 'draw' ? 0xd8d1bd : 0xffffff;
      brush.texture = tex[lose ? A.result.brushLose : A.result.brushWin];
      brush.width = PANEL_W * (lose ? 0.78 : 0.73);
      brush.scale.y = brush.scale.x;
      verdict.text = data.outcome === 'draw' ? 'HÒA' : lose ? 'THUA' : 'THẮNG';
      fitText(verdict, brush.width * 0.57);
      detail.text = data.detail;

      // Không có thanh KEN (vd chơi với Máy) thì hạ khối cúp/vệt sơn/chữ xuống
      // canh giữa vùng trống để popup không bị hụt phần dưới.
      const dropY = data.kenText == null ? panelH * 0.1 : 0;
      outcomeIcon.y = -panelH * 0.145 + dropY;
      brush.y = panelH * 0.075 + dropY;
      verdict.y = brush.y - 2;
      detail.y = brush.y + panelH * 0.072;

      kenBox.visible = data.kenText != null;
      if (data.kenText != null) {
        kenText.text = data.kenText;
        arrangeKen();
      }
      view.visible = true;
      dim.alpha = 0;
      void tween(dim, { alpha: 1 }, RESULT_REVEAL.dim);

      // Reveal theo từng lớp để người chơi kịp nhận biết kết quả trước khi thao tác tiếp.
      reveal(card, 0, RESULT_REVEAL.card);
      reveal(titleFrame, RESULT_REVEAL.titleFrameDelay, 430);
      reveal(title, RESULT_REVEAL.titleDelay, 400);
      reveal(outcomeIcon, RESULT_REVEAL.outcomeDelay, 520);
      reveal(brush, RESULT_REVEAL.brushDelay, 420);
      reveal(verdict, RESULT_REVEAL.verdictDelay, 460);
      reveal(detail, RESULT_REVEAL.detailDelay, 380);
      if (kenBox.visible) reveal(kenBox, RESULT_REVEAL.kenDelay, 420);
      reveal(replayButton, RESULT_REVEAL.replayDelay, 360);
      reveal(closeButton, RESULT_REVEAL.closeDelay, 360);
    },
    hide(): void {
      hidePopup();
    },
    layout(designH, insetTop, insetBottom): void {
      dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
      const availW = DESIGN_W * 0.94;
      const availH = designH - insetTop - insetBottom - 24;
      const fitScale = Math.min(1, availW / PANEL_W, availH / panelH);
      card.scale.set(fitScale);
      card.x = DESIGN_W / 2;
      card.y = insetTop + (designH - insetTop - insetBottom) / 2;
    },
  };
}

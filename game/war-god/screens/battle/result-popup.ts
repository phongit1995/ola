import { Container, Graphics, Rectangle, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../kit';
import { DESIGN_W } from '../../layout';
import {
  formatBotStarRating,
  starFillAt,
  type BotStarRating,
  type StarFill,
} from '../../logic/bot-rating';

const PANEL_W = 375;
const STAR_CENTER_SIZE = 90;
const STAR_SIDE_SIZE = 74;
const STAR_SIDE_X = 86;
const STAR_CENTER_Y = -10;
const STAR_SIDE_Y = 6;
const STAR_ROW_TOP = STAR_CENTER_Y - STAR_CENTER_SIZE / 2;
const STAR_ROW_BOTTOM = STAR_SIDE_Y + STAR_SIDE_SIZE / 2;
const STAR_TITLE_GAP = 10;
const STAR_ICON_GAP = 16;
const RESULT_REVEAL = {
  dim: 260,
  card: 500,
  titleFrameDelay: 70,
  titleDelay: 120,
  starCenterDelay: 170,
  starLeftDelay: 260,
  starRightDelay: 350,
  outcomeDelay: 190,
  brushDelay: 300,
  verdictDelay: 350,
  detailDelay: 430,
  kenDelay: 510,
  replayDelay: 620,
  closeDelay: 690,
} as const;

export type ResultOutcome = 'win' | 'lose' | 'draw';
export type ResultStarRating = BotStarRating;

export interface ResultPopupData {
  outcome: ResultOutcome;
  detail: string;
  kenText?: string;
  starRating?: ResultStarRating;
}

export interface ResultPopup {
  view: Container;
  show(data: ResultPopupData): void;
  hide(): void;
  layout(designH: number, insetTop: number, insetBottom: number): void;
}

interface ResultStar {
  view: Container;
  setFill(fill: StarFill): void;
}

interface PopupLayout {
  designH: number;
  insetTop: number;
  insetBottom: number;
}

function fitText(text: Text, maxWidth: number): void {
  text.scale.set(1);
  if (text.width > maxWidth) text.scale.set(maxWidth / text.width);
}

function makeResultStar(displaySize: number): ResultStar {
  const view = new Container();
  const radius = displaySize * 0.447;
  const innerRadius = radius * 0.48;
  const inactiveOutline = new Graphics()
    .star(0, 0, 5, radius, innerRadius, -Math.PI / 2)
    .stroke({
      width: displaySize * 0.08,
      color: 0x3b2418,
      alpha: 0.62,
      join: 'round',
    })
    .star(0, 0, 5, radius, innerRadius, -Math.PI / 2)
    .stroke({
      width: displaySize * 0.052,
      color: 0xa66a3f,
      alpha: 0.96,
      join: 'round',
    });
  const goldSprite = new Sprite(tex[A.result.starGold]);
  const fillMask = new Graphics();
  goldSprite.anchor.set(0.5);
  goldSprite.width = displaySize;
  goldSprite.scale.y = goldSprite.scale.x;
  goldSprite.mask = fillMask;
  view.addChild(inactiveOutline, goldSprite, fillMask);

  function setFill(fill: StarFill): void {
    inactiveOutline.visible = fill < 1;
    goldSprite.visible = fill > 0;
    fillMask.clear();
    if (fill > 0) {
      fillMask
        .rect(-displaySize / 2, -displaySize / 2, displaySize * fill, displaySize)
        .fill(0xffffff);
    }
  }

  setFill(0);
  return { view, setFill };
}

export function buildResultPopup(onClose: () => void, onReplay: () => void): ResultPopup {
  const view = new Container();
  const dim = new Graphics();
  const card = new Container();
  let cancelReveal: Array<() => void> = [];
  let latestLayout: PopupLayout | null = null;

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
  const defaultPanelH = panel.height;

  const titleFrame = new Sprite(tex[A.result.titleFrame]);
  titleFrame.anchor.set(0.5);
  titleFrame.width = PANEL_W * 0.72;
  titleFrame.scale.y = titleFrame.scale.x;
  card.addChild(titleFrame);

  const title = makeText('KẾT QUẢ', 38, 0xffdf62, '800', HEADING);
  title.style.letterSpacing = 1;
  fitText(title, titleFrame.width * 0.67);
  card.addChild(title);

  const brush = new Sprite(tex[A.result.brushWin]);
  brush.anchor.set(0.5);
  card.addChild(brush);

  const outcomeIcon = new Sprite(tex[A.result.cupWin]);
  outcomeIcon.anchor.set(0.5);
  card.addChild(outcomeIcon);

  const starRow = new Container();
  const leftStar = makeResultStar(STAR_SIDE_SIZE);
  const centerStar = makeResultStar(STAR_CENTER_SIZE);
  const rightStar = makeResultStar(STAR_SIDE_SIZE);
  leftStar.view.position.set(-STAR_SIDE_X, STAR_SIDE_Y);
  leftStar.view.rotation = -0.08;
  centerStar.view.y = STAR_CENTER_Y;
  rightStar.view.position.set(STAR_SIDE_X, STAR_SIDE_Y);
  rightStar.view.rotation = 0.08;
  starRow.addChild(leftStar.view, rightStar.view, centerStar.view);
  starRow.visible = false;
  card.addChild(starRow);
  const stars = [leftStar, centerStar, rightStar] as const;

  const verdict = makeText('THẮNG', 50, 0xffffff, '800', HEADING);
  verdict.style.fontStyle = 'italic';
  verdict.style.letterSpacing = 1;
  verdict.style.stroke = { color: 0x5b1c08, width: 2, join: 'round' };
  verdict.rotation = -0.035;
  card.addChild(verdict);

  const detail = makeText('', 11, 0xfff0c5, '700', HEADING);
  detail.style.wordWrap = true;
  detail.style.wordWrapWidth = PANEL_W * 0.56;
  detail.style.align = 'center';
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
    pressable(btn, () => {
      hidePopup();
      onTap();
    });
    return btn;
  }

  const replayButton = makeButton('CHƠI LẠI', A.result.btnReplay, onReplay);
  const closeButton = makeButton('ĐÓNG', A.result.btnClose, onClose);
  const buttonVisualH = Math.max(replayButton.height, closeButton.height);
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

  function applyLayout({ designH, insetTop, insetBottom }: PopupLayout): void {
    dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
    const availW = DESIGN_W * 0.94;
    const availH = designH - insetTop - insetBottom - 24;
    const fitScale = Math.min(1, availW / PANEL_W, availH / panel.height);
    card.scale.set(fitScale);
    card.x = DESIGN_W / 2;
    const centeredY = insetTop + (designH - insetTop - insetBottom) / 2;
    const buttonBottom = Math.max(
      panel.height / 2,
      replayButton.y + buttonVisualH / 2,
      closeButton.y + buttonVisualH / 2,
    );
    const maxY = designH - insetBottom - 16 - buttonBottom * fitScale;
    card.y = Math.min(centeredY, maxY);
  }

  function arrangeContent(withStars: boolean, hasKen: boolean): void {
    panel.height = defaultPanelH;
    const panelH = panel.height;
    const halfH = panelH / 2;

    titleFrame.y = -halfH;
    title.y = titleFrame.y - 2;
    kenBox.y = panelH * 0.32;

    replayButton.y = halfH;
    closeButton.y = halfH;

    if (withStars) {
      const titleBottom = titleFrame.y + titleFrame.height / 2;
      starRow.y = titleBottom + STAR_TITLE_GAP - STAR_ROW_TOP;
      const iconTop = starRow.y + STAR_ROW_BOTTOM + STAR_ICON_GAP;
      outcomeIcon.y = iconTop + outcomeIcon.height / 2;
      brush.y = outcomeIcon.y + outcomeIcon.height * 0.71;
    } else {
      const dropY = hasKen ? 0 : panelH * 0.1;
      outcomeIcon.y = -panelH * 0.145 + dropY;
      brush.y = panelH * 0.075 + dropY;
    }
    verdict.y = brush.y - 2;
    detail.y = brush.y + panelH * 0.072;
  }

  view.visible = false;
  return {
    view,
    show(data): void {
      stopReveal();
      const lose = data.outcome === 'lose';
      const withStars = data.starRating != null;

      outcomeIcon.texture = tex[lose ? A.result.shieldLose : A.result.cupWin];
      outcomeIcon.width = PANEL_W * (withStars ? (lose ? 0.42 : 0.4) : lose ? 0.48 : 0.46);
      outcomeIcon.scale.y = outcomeIcon.scale.x;
      outcomeIcon.tint = data.outcome === 'draw' ? 0xd8d1bd : 0xffffff;

      brush.texture = tex[lose ? A.result.brushLose : A.result.brushWin];
      brush.width = PANEL_W * (withStars ? (lose ? 0.72 : 0.69) : lose ? 0.78 : 0.73);
      brush.scale.y = brush.scale.x;

      verdict.text = data.outcome === 'draw' ? 'HÒA' : lose ? 'THUA' : 'THẮNG';
      fitText(verdict, brush.width * 0.57);
      detail.text = withStars
        ? `${data.detail}\nXẾP HẠNG ${formatBotStarRating(data.starRating ?? 0)} / 3 SAO`
        : data.detail;

      starRow.visible = withStars;
      if (withStars) {
        const starRating = data.starRating ?? 0;
        stars.forEach((star, index) => {
          star.setFill(starFillAt(starRating, index as 0 | 1 | 2));
        });
      }

      kenBox.visible = data.kenText != null;
      if (data.kenText != null) {
        kenText.text = data.kenText;
        arrangeKen();
      }

      arrangeContent(withStars, kenBox.visible);
      if (latestLayout) applyLayout(latestLayout);

      view.visible = true;
      dim.alpha = 0;
      void tween(dim, { alpha: 1 }, RESULT_REVEAL.dim);

      // Giữ choreography cũ; riêng chế độ Máy thêm ba sao pop lần lượt trước cúp/khiên.
      reveal(card, 0, RESULT_REVEAL.card);
      reveal(titleFrame, RESULT_REVEAL.titleFrameDelay, 430);
      reveal(title, RESULT_REVEAL.titleDelay, 400);
      if (withStars) {
        reveal(centerStar.view, RESULT_REVEAL.starCenterDelay, 470);
        reveal(leftStar.view, RESULT_REVEAL.starLeftDelay, 420);
        reveal(rightStar.view, RESULT_REVEAL.starRightDelay, 420);
      }
      const starDelay = withStars ? 250 : 0;
      reveal(outcomeIcon, RESULT_REVEAL.outcomeDelay + starDelay, 520);
      reveal(brush, RESULT_REVEAL.brushDelay + starDelay, 420);
      reveal(verdict, RESULT_REVEAL.verdictDelay + starDelay, 460);
      reveal(detail, RESULT_REVEAL.detailDelay + starDelay, 380);
      if (kenBox.visible) reveal(kenBox, RESULT_REVEAL.kenDelay + starDelay, 420);
      reveal(replayButton, RESULT_REVEAL.replayDelay + starDelay, 360);
      reveal(closeButton, RESULT_REVEAL.closeDelay + starDelay, 360);
    },
    hide(): void {
      hidePopup();
    },
    layout(designH, insetTop, insetBottom): void {
      latestLayout = { designH, insetTop, insetBottom };
      applyLayout(latestLayout);
    },
  };
}

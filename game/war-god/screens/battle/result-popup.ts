import { Container, Graphics, Rectangle, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import { levelFromExp, levelProgress } from '../../../src/sdk';
import { A, tex } from '../../assets';
import { playSound } from '../../audio';
import { addTick, HEADING, makeText, popIn, pressable, removeTick, tween } from '../../kit';
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
const STAR_RIM_TINT = 0x2d1607;
const STAR_HOLLOW_TINT = 0x4a3122;
const STAR_HALO_TINT = 0xffc23a;
const STAR_FLY_MS = 155;
const STAR_IMPACT_MS = 340;
const STAR_EARN_DELAY = 300;
const STAR_EARN_STEP = 190;
const RESULT_REVEAL = {
  dim: 260,
  card: 500,
  titleFrameDelay: 70,
  titleDelay: 120,
  starRowDelay: 140,
  outcomeDelay: 190,
  brushDelay: 300,
  verdictDelay: 350,
  detailDelay: 430,
  kenDelay: 510,
  expDelay: 560,
  replayDelay: 620,
  closeDelay: 690,
} as const;
const EXP_BAR_W = PANEL_W * 0.6;
const EXP_BAR_H = 9;
const EXP_FILL_MS = 650;
const EXP_LEVELUP_HOLD_MS = 240;

export type ResultOutcome = 'win' | 'lose' | 'draw';
export type ResultStarRating = BotStarRating;

export interface ResultExpInfo {
  gained: number;
  before: number;
}

export interface ResultPopupData {
  outcome: ResultOutcome;
  detail: string;
  kenText?: string;
  starRating?: ResultStarRating;
  exp?: ResultExpInfo;
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
  playEarn(delay: number, intensity: number, finale: boolean): () => void;
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

let starHaloTex: Texture | null = null;

function getStarHaloTexture(): Texture {
  if (starHaloTex) return starHaloTex;
  const size = 128;
  const c = document.createElement('canvas');
  c.width = size;
  c.height = size;
  const ctx = c.getContext('2d')!;
  const g = ctx.createRadialGradient(size / 2, size / 2, 0, size / 2, size / 2, size / 2);
  g.addColorStop(0, 'rgba(255,255,255,0.9)');
  g.addColorStop(0.4, 'rgba(255,255,255,0.3)');
  g.addColorStop(1, 'rgba(255,255,255,0)');
  ctx.fillStyle = g;
  ctx.fillRect(0, 0, size, size);
  starHaloTex = Texture.from(c);
  return starHaloTex;
}

function makeResultStar(displaySize: number): ResultStar {
  const view = new Container();
  const starTexture = tex[A.result.starGold];
  const halo = new Sprite(getStarHaloTexture());
  const body = new Container();
  const goldLayer = new Container();
  const rimSprite = new Sprite(starTexture);
  const hollowSprite = new Sprite(starTexture);
  const goldSprite = new Sprite(starTexture);
  const fillMask = new Graphics();
  const seam = new Graphics();
  const seamMask = new Graphics();
  const burst = new Graphics();
  const rays = new Graphics();

  halo.anchor.set(0.5);
  halo.width = displaySize * 2;
  halo.height = displaySize * 2;
  halo.tint = STAR_HALO_TINT;
  halo.blendMode = 'add';

  for (const sprite of [rimSprite, hollowSprite, goldSprite]) {
    sprite.anchor.set(0.5);
    sprite.width = displaySize;
    sprite.scale.y = sprite.scale.x;
  }

  // Ba lớp dùng chung texture, chung tâm nên mọi trạng thái khớp silhouette:
  // viền tối nở nhẹ tách sao khỏi nền gỗ cam, thân nâu sẫm là ô sao chưa đạt,
  // lớp vàng nằm trên chỉ bị cắt theo mức 0 / 0,5 / 1. Quầng sáng cộng màu chỉ
  // bật khi sao có điểm để mắt bắt ngay số sao đã ăn.
  rimSprite.tint = STAR_RIM_TINT;
  rimSprite.alpha = 0.62;
  rimSprite.scale.set(rimSprite.scale.x * 1.08);
  hollowSprite.tint = STAR_HOLLOW_TINT;
  goldSprite.mask = fillMask;

  // Dải sáng nằm trọn bên nửa vàng nên nửa chưa đạt giữ nguyên độ tối: mép cắt
  // đọc như cạnh vàng đang hắt sáng thay vì một thanh trắng dán ngang ngôi sao.
  const seamW = displaySize * 0.05;
  const seamRadius = displaySize * 0.447;
  seam
    .rect(-seamW, -displaySize / 2, seamW * 0.55, displaySize)
    .fill({ color: 0xffe9a8, alpha: 0.45 })
    .rect(-seamW * 0.45, -displaySize / 2, seamW * 0.45, displaySize)
    .fill({ color: 0xfff6d8, alpha: 0.9 });
  seam.blendMode = 'add';
  seam.alpha = 0.42;
  seamMask.star(0, 0, 5, seamRadius, seamRadius * 0.48, -Math.PI / 2).fill(0xffffff);
  seam.mask = seamMask;

  // Vòng xung và chùm tia vẽ sẵn ở kích thước chuẩn rồi chỉ phóng/mờ dần khi
  // chạy, tránh dựng lại Graphics mỗi khung hình lúc ba sao cùng đập.
  burst.circle(0, 0, displaySize * 0.5).stroke({ width: 5, color: 0xffe08a, alpha: 0.9 });
  burst.blendMode = 'add';
  burst.visible = false;
  for (let i = 0; i < 10; i++) {
    const angle = (Math.PI * 2 * i) / 10;
    const inner = displaySize * 0.44;
    const outer = displaySize * (0.66 + (i % 2) * 0.1);
    rays.moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner);
    rays.lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer);
  }
  rays.stroke({ width: 2, color: 0xffe9a8, alpha: 0.9, cap: 'round' });
  rays.blendMode = 'add';
  rays.visible = false;

  goldLayer.addChild(goldSprite, fillMask, seam, seamMask);
  body.addChild(rimSprite, hollowSprite, goldLayer);
  view.addChild(halo, body, burst, rays);

  let haloTarget = 0;

  function rest(): void {
    goldLayer.alpha = 1;
    goldLayer.scale.set(1);
    goldLayer.position.set(0, 0);
    goldLayer.rotation = 0;
    body.position.set(0, 0);
    halo.alpha = haloTarget;
    burst.visible = false;
    rays.visible = false;
  }

  function setFill(fill: StarFill): void {
    haloTarget = fill === 1 ? 0.4 : 0.22;
    halo.visible = fill > 0;
    goldLayer.visible = fill > 0;
    seam.visible = fill === 0.5;
    fillMask.clear();
    if (fill > 0) {
      fillMask
        .rect(-displaySize / 2, -displaySize / 2, displaySize * fill, displaySize)
        .fill(0xffffff);
    }
    rest();
  }

  // Sao lao từ trên xuống theo easing nhanh dần rồi đóng dấu vào hốc: thân sao
  // rung tắt dần, vòng xung bung ra, quầng sáng mới bật. `intensity` để sao sau
  // đập mạnh hơn sao trước, `finale` thêm chùm tia cho sao thứ ba ăn trọn.
  function playEarn(delay: number, intensity: number, finale: boolean): () => void {
    let clock = -delay;
    let active = true;
    let impacted = false;
    goldLayer.alpha = 0;
    halo.alpha = 0;
    burst.visible = false;
    rays.visible = false;

    const stop = (): void => {
      if (!active) return;
      active = false;
      removeTick(step);
      if (!view.destroyed) rest();
    };

    const step = (ticker: Ticker): void => {
      if (!active || view.destroyed) {
        active = false;
        removeTick(step);
        return;
      }
      clock += ticker.deltaMS;
      if (clock < 0) return;
      if (clock < STAR_FLY_MS) {
        const k = clock / STAR_FLY_MS;
        const e = k * k;
        goldLayer.alpha = Math.min(1, k * 2.2);
        goldLayer.scale.set(2 - e);
        goldLayer.y = -displaySize * 0.5 * (1 - e);
        goldLayer.rotation = -0.38 * (1 - e);
        return;
      }
      if (!impacted) {
        impacted = true;
        playSound('match');
        burst.visible = true;
        rays.visible = finale;
      }
      const k = Math.min(1, (clock - STAR_FLY_MS) / STAR_IMPACT_MS);
      goldLayer.alpha = 1;
      goldLayer.rotation = 0;
      goldLayer.y = 0;
      goldLayer.scale.set(1 + 0.2 * intensity * (1 - k) * Math.cos(k * 9));
      const shake = displaySize * 0.05 * intensity * Math.max(0, 1 - k / 0.55);
      body.position.set(Math.sin(clock * 0.35) * shake, Math.cos(clock * 0.42) * shake * 0.7);
      halo.alpha = haloTarget * Math.min(1, k * 3);
      burst.scale.set(0.5 + 0.85 * k);
      burst.alpha = 0.85 * (1 - k) * (1 - k);
      if (finale) {
        rays.scale.set(0.6 + 0.9 * k);
        rays.rotation = k * 0.5;
        rays.alpha = 0.9 * (1 - k);
      }
      if (k >= 1) stop();
    };

    addTick(step);
    return stop;
  }

  setFill(0);
  return { view, setFill, playEarn };
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

  const expBox = new Container();
  const expGainText = makeText('', 15, 0xffdf62, '800', HEADING);
  expGainText.style.stroke = { color: 0x6f2607, width: 2, join: 'round' };
  expGainText.y = -14;
  const levelUpText = makeText('LÊN CẤP!', 14, 0xffe9a8, '800', HEADING);
  levelUpText.style.stroke = { color: 0x6f2607, width: 3, join: 'round' };
  levelUpText.y = EXP_BAR_H / 2;
  levelUpText.visible = false;
  const expBarBg = new Graphics();
  expBarBg
    .roundRect(-EXP_BAR_W / 2, 0, EXP_BAR_W, EXP_BAR_H, EXP_BAR_H / 2)
    .fill({ color: 0x2d1607, alpha: 0.78 });
  const expBarFill = new Graphics();
  expBarFill.roundRect(0, 0, EXP_BAR_W, EXP_BAR_H, EXP_BAR_H / 2).fill(0xffc23a);
  expBarFill.x = -EXP_BAR_W / 2;
  expBarFill.scale.x = 0;
  const expLevelText = makeText('', 12, 0xfff0c5, '700', HEADING);
  expLevelText.y = -14;
  expBox.addChild(expBarBg, expBarFill, expGainText, expLevelText, levelUpText);
  expBox.visible = false;
  card.addChild(expBox);

  // Thanh EXP bơm tới vạch mới; nếu vượt cấp thì bơm đầy, khựng lại khoe chữ
  // LÊN CẤP! rồi mới rót phần dư của cấp mới, giống nhịp quen thuộc của game RPG.
  function playExpFill(start: number, end: number, leveledUp: boolean, delay: number): () => void {
    let clock = -delay;
    let active = true;
    let phase = 0;
    expBarFill.scale.x = start;
    levelUpText.visible = false;
    const stop = (): void => {
      if (!active) return;
      active = false;
      removeTick(step);
    };
    const step = (ticker: Ticker): void => {
      if (!active || expBarFill.destroyed) {
        stop();
        return;
      }
      clock += ticker.deltaMS;
      if (clock < 0) return;
      if (phase === 0) {
        const target = leveledUp ? 1 : end;
        const k = Math.min(1, clock / EXP_FILL_MS);
        const e = 1 - (1 - k) * (1 - k);
        expBarFill.scale.x = start + (target - start) * e;
        if (k >= 1) {
          if (!leveledUp) {
            stop();
            return;
          }
          phase = 1;
          clock = 0;
          levelUpText.visible = true;
          cancelReveal.push(popIn(levelUpText, 0, 300));
          playSound('match');
        }
        return;
      }
      if (phase === 1) {
        if (clock < EXP_LEVELUP_HOLD_MS) return;
        phase = 2;
        clock = 0;
        expBarFill.scale.x = 0;
        return;
      }
      const k = Math.min(1, clock / EXP_FILL_MS);
      const e = 1 - (1 - k) * (1 - k);
      expBarFill.scale.x = end * e;
      if (k >= 1) stop();
    };
    addTick(step);
    return stop;
  }

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

  function arrangeContent(withStars: boolean, hasKen: boolean, hasExp: boolean): void {
    panel.height = defaultPanelH;
    const panelH = panel.height;
    const halfH = panelH / 2;

    titleFrame.y = -halfH;
    title.y = titleFrame.y - 2;
    kenBox.y = hasExp ? panelH * 0.27 : panelH * 0.32;
    expBox.y = hasKen ? panelH * 0.405 : panelH * 0.33;

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
      const earned: Array<{ star: ResultStar; fill: StarFill }> = [];
      if (withStars) {
        const starRating = data.starRating ?? 0;
        stars.forEach((star, index) => {
          const fill = starFillAt(starRating, index as 0 | 1 | 2);
          star.setFill(fill);
          if (fill > 0) earned.push({ star, fill });
        });
      }

      kenBox.visible = data.kenText != null;
      if (data.kenText != null) {
        kenText.text = data.kenText;
        arrangeKen();
      }

      expBox.visible = data.exp != null;
      let expAnim: { start: number; end: number; leveledUp: boolean } | null = null;
      if (data.exp != null) {
        const after = data.exp.before + data.exp.gained;
        const progress = levelProgress(after);
        const leveledUp = progress.level > levelFromExp(data.exp.before);
        expGainText.text = `+${data.exp.gained} EXP`;
        fitText(expGainText, PANEL_W * 0.3);
        expLevelText.text =
          progress.required > 0
            ? `Lv.${progress.level}  ${progress.current}/${progress.required}`
            : `Lv.${progress.level}  MAX`;
        fitText(expLevelText, PANEL_W * 0.3);
        expGainText.x = -EXP_BAR_W / 2 + expGainText.width / 2;
        expLevelText.x = EXP_BAR_W / 2 - expLevelText.width / 2;
        levelUpText.x = 0;
        levelUpText.visible = false;
        expAnim = {
          start: levelProgress(data.exp.before).ratio,
          end: progress.ratio,
          leveledUp,
        };
        expBarFill.scale.x = expAnim.start;
      }

      arrangeContent(withStars, kenBox.visible, expBox.visible);
      if (latestLayout) applyLayout(latestLayout);

      view.visible = true;
      dim.alpha = 0;
      void tween(dim, { alpha: 1 }, RESULT_REVEAL.dim);

      // Giữ choreography cũ; riêng chế độ Máy: ba hốc sao hiện cùng lúc, rồi
      // từng sao ăn được mới bay xuống đóng dấu, mỗi cú mạnh hơn cú trước.
      reveal(card, 0, RESULT_REVEAL.card);
      reveal(titleFrame, RESULT_REVEAL.titleFrameDelay, 430);
      reveal(title, RESULT_REVEAL.titleDelay, 400);
      let lastImpact = 0;
      if (withStars) {
        reveal(starRow, RESULT_REVEAL.starRowDelay, 260);
        earned.forEach(({ star, fill }, order) => {
          const earnDelay = STAR_EARN_DELAY + order * STAR_EARN_STEP;
          const intensity = 0.7 + 0.15 * order;
          const finale = order === earned.length - 1 && earned.length === 3 && fill === 1;
          cancelReveal.push(star.playEarn(earnDelay, intensity, finale));
          lastImpact = earnDelay + STAR_FLY_MS;
        });
      }
      // Cúp/khiên khởi động ngay trước cú đập cuối để hai nhịp gối nhau thay vì
      // bắt người chơi chờ hết cụm sao.
      const starDelay = withStars
        ? Math.max(220, lastImpact - RESULT_REVEAL.outcomeDelay - 130)
        : 0;
      reveal(outcomeIcon, RESULT_REVEAL.outcomeDelay + starDelay, 520);
      reveal(brush, RESULT_REVEAL.brushDelay + starDelay, 420);
      reveal(verdict, RESULT_REVEAL.verdictDelay + starDelay, 460);
      reveal(detail, RESULT_REVEAL.detailDelay + starDelay, 380);
      if (kenBox.visible) reveal(kenBox, RESULT_REVEAL.kenDelay + starDelay, 420);
      if (expBox.visible && expAnim) {
        reveal(expBox, RESULT_REVEAL.expDelay + starDelay, 420);
        cancelReveal.push(
          playExpFill(
            expAnim.start,
            expAnim.end,
            expAnim.leveledUp,
            RESULT_REVEAL.expDelay + starDelay + 320,
          ),
        );
      }
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

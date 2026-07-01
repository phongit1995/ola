import { useEffect, useRef, useState } from 'react';
import type { CSSProperties, PointerEvent as ReactPointerEvent, ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { kenTreasureAssets, openingFrames } from './kenTreasureAssets';
import { useKenTreasureStore, useKenTreasurePositionStore } from './kenTreasureStore';

const goldTextStyle: CSSProperties = {
  color: '#ffe27a',
  WebkitTextStroke: '1px #6d1a00',
  textShadow: '0 2px 3px rgba(0,0,0,.45)',
};

const whiteTextStyle: CSSProperties = {
  color: '#fff',
  WebkitTextStroke: '1px #7a1e00',
  textShadow: '0 2px 3px rgba(0,0,0,.4)',
};

interface DragState {
  startX: number;
  startY: number;
  baseX: number;
  baseY: number;
}

function formatCountdown(ms: number): string {
  const total = Math.max(0, Math.ceil(ms / 1000));
  const minutes = Math.floor(total / 60);
  const seconds = total % 60;
  return `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
}

function useRemaining(expiresAt: string | null, onExpire: () => void): number {
  const [remaining, setRemaining] = useState(() =>
    expiresAt ? new Date(expiresAt).getTime() - Date.now() : 0
  );
  const expiredRef = useRef(false);

  useEffect(() => {
    expiredRef.current = false;
    if (!expiresAt) return;
    const target = new Date(expiresAt).getTime();
    const tick = () => {
      const left = target - Date.now();
      setRemaining(left);
      if (left <= 0 && !expiredRef.current) {
        expiredRef.current = true;
        onExpire();
      }
    };
    tick();
    const id = setInterval(tick, 250);
    return () => clearInterval(id);
  }, [expiresAt, onExpire]);

  return remaining;
}

function OpeningChest() {
  const [index, setIndex] = useState(0);

  useEffect(() => {
    let current = 0;
    const step = Math.max(120, Math.floor(1000 / openingFrames.length));
    const id = setInterval(() => {
      current = Math.min(openingFrames.length - 1, current + 1);
      setIndex(current);
      if (current >= openingFrames.length - 1) clearInterval(id);
    }, step);
    return () => clearInterval(id);
  }, []);

  return (
    <div className="absolute inset-0 z-[80] flex animate-ken-fade-in items-center justify-center bg-black/40">
      <img
        src={openingFrames[index] ?? kenTreasureAssets.chestWithEffect}
        alt=""
        draggable={false}
        className="pointer-events-none w-[62%] max-w-[280px] animate-ken-pop-in select-none [filter:drop-shadow(0_12px_30px_rgba(0,0,0,.55))]"
      />
    </div>
  );
}

function ChestPanel({
  backgroundSrc,
  widthClassName,
  centered,
  onClose,
  children,
}: {
  backgroundSrc: string;
  widthClassName: string;
  centered?: boolean;
  onClose?: () => void;
  children: ReactNode;
}) {
  const { t } = useTranslation();
  const setPosition = useKenTreasurePositionStore((s) => s.setPosition);
  const [offset, setOffset] = useState(() => {
    const saved = useKenTreasurePositionStore.getState();
    return { x: saved.x, y: saved.y };
  });
  const offsetRef = useRef(offset);
  const dragRef = useRef<DragState | null>(null);

  function handlePointerDown(e: ReactPointerEvent<HTMLDivElement>) {
    dragRef.current = {
      startX: e.clientX,
      startY: e.clientY,
      baseX: offsetRef.current.x,
      baseY: offsetRef.current.y,
    };
    e.currentTarget.setPointerCapture(e.pointerId);
  }

  function handlePointerMove(e: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag) return;
    const next = { x: drag.baseX + e.clientX - drag.startX, y: drag.baseY + e.clientY - drag.startY };
    offsetRef.current = next;
    setOffset(next);
  }

  function handlePointerUp(e: ReactPointerEvent<HTMLDivElement>) {
    if (!dragRef.current) return;
    dragRef.current = null;
    e.currentTarget.releasePointerCapture(e.pointerId);
    setPosition(offsetRef.current.x, offsetRef.current.y);
  }

  const panel = (
    <div
      className={`relative ${widthClassName} animate-ken-pop-in [filter:drop-shadow(0_10px_24px_rgba(0,0,0,.45))]`}
    >
      <img src={backgroundSrc} alt="" draggable={false} className="w-full select-none" />
      <img
        src={kenTreasureAssets.crown}
        alt=""
        draggable={false}
        className="pointer-events-none absolute left-1/2 top-[-9%] w-[24%] -translate-x-1/2 select-none"
      />
      {onClose && (
        <button
          type="button"
          aria-label={t('kenTreasure.close')}
          onClick={onClose}
          onPointerDown={(e) => e.stopPropagation()}
          style={{ backgroundImage: `url(${kenTreasureAssets.buttonClose})` }}
          className="absolute -right-1 top-0 z-20 flex aspect-square w-[13%] items-center justify-center bg-contain bg-center bg-no-repeat transition active:scale-90"
        >
          <img src={kenTreasureAssets.closeX} alt="" draggable={false} className="w-1/2 select-none" />
        </button>
      )}
      {children}
    </div>
  );

  if (centered) {
    return (
      <div
        className="absolute inset-0 z-[80] flex animate-ken-fade-in items-center justify-center bg-black/40 p-4"
        onClick={(e) => {
          if (e.target === e.currentTarget) onClose?.();
        }}
      >
        {panel}
      </div>
    );
  }

  return (
    <div
      className="absolute bottom-16 right-4 z-[80] cursor-grab touch-none select-none active:cursor-grabbing"
      style={{ transform: `translate(${offset.x}px, ${offset.y}px)` }}
      onPointerDown={handlePointerDown}
      onPointerMove={handlePointerMove}
      onPointerUp={handlePointerUp}
    >
      {panel}
    </div>
  );
}

function ResultView({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const result = useKenTreasureStore((s) => s.result);
  const isEmpty = result?.isEmpty ?? false;
  const amount = result?.kenAmount ?? 0;

  return (
    <ChestPanel
      backgroundSrc={kenTreasureAssets.resultBackground}
      widthClassName="w-[330px]"
      centered
      onClose={onClose}
    >
      <div
        className="absolute left-1/2 top-[7%] w-[74%] -translate-x-1/2 text-center text-xl font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {t('kenTreasure.resultTitle')}
      </div>

      <img
        src={isEmpty ? kenTreasureAssets.resultChestEmpty : kenTreasureAssets.resultChestWin}
        alt=""
        draggable={false}
        className="pointer-events-none absolute left-1/2 top-[13%] w-[46%] -translate-x-1/2 select-none"
      />

      <div
        className="absolute left-1/2 top-[55%] w-[80%] -translate-x-1/2 text-center text-3xl font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {isEmpty ? t('kenTreasure.emptyTitle') : t('kenTreasure.congrats')}
      </div>

      <div className="absolute left-1/2 top-[63%] w-[80%] -translate-x-1/2 text-center text-sm font-semibold leading-none text-[#5a2b12]">
        {isEmpty ? t('kenTreasure.emptyDesc') : t('kenTreasure.youWon')}
      </div>

      {!isEmpty && (
        <div className="absolute left-1/2 top-[68%] w-[78%] -translate-x-1/2">
          <img src={kenTreasureAssets.resultKenCount} alt="" draggable={false} className="w-full select-none" />
          <img
            src={kenTreasureAssets.resultKenCoin}
            alt=""
            draggable={false}
            className="absolute left-[6%] top-1/2 w-[24%] -translate-y-1/2 select-none"
          />
          <div
            className="absolute inset-0 flex items-center justify-center pl-[16%] text-xl font-extrabold leading-none"
            style={goldTextStyle}
          >
            {`${amount.toLocaleString('vi-VN')} ${t('kenTreasure.kenSuffix')}`}
          </div>
        </div>
      )}

      <button
        type="button"
        onClick={onClose}
        onPointerDown={(e) => e.stopPropagation()}
        style={{ backgroundImage: `url(${kenTreasureAssets.resultClose})` }}
        className="absolute bottom-[6%] left-1/2 flex aspect-[1214/355] w-[56%] -translate-x-1/2 translate-y-1/2 items-center justify-center bg-contain bg-center bg-no-repeat transition active:scale-95"
      >
        <span className="text-xl font-extrabold uppercase leading-none" style={whiteTextStyle}>
          {t('kenTreasure.close')}
        </span>
      </button>
    </ChestPanel>
  );
}

export function KenTreasureOverlay() {
  const { t } = useTranslation();
  const phase = useKenTreasureStore((s) => s.phase);
  const expiresAt = useKenTreasureStore((s) => s.expiresAt);
  const openChest = useKenTreasureStore((s) => s.open);
  const dismiss = useKenTreasureStore((s) => s.dismiss);

  const remaining = useRemaining(phase === 'closed' ? expiresAt : null, dismiss);

  if (phase === 'idle') return null;
  if (phase === 'result') return <ResultView onClose={dismiss} />;
  if (phase === 'opening') return <OpeningChest />;

  return (
    <ChestPanel
      backgroundSrc={kenTreasureAssets.frameBackground}
      widthClassName="w-[140px]"
      onClose={dismiss}
    >
      <div
        className="absolute left-1/2 top-[6%] w-[70%] -translate-x-1/2 text-center text-xs font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {t('kenTreasure.title')}
      </div>

      <img
        src={kenTreasureAssets.chestClosed}
        alt=""
        draggable={false}
        className="pointer-events-none absolute left-1/2 top-[23%] w-[48%] -translate-x-1/2 select-none"
      />

      <div className="absolute left-1/2 top-[68%] w-[56%] -translate-x-1/2">
        <img src={kenTreasureAssets.frameTime} alt="" draggable={false} className="w-full select-none" />
        <div className="absolute left-[-8%] top-1/2 w-[26%] -translate-y-1/2">
          <img
            src={kenTreasureAssets.buttonHourglass}
            alt=""
            draggable={false}
            className="w-full origin-center animate-hourglass-flip select-none"
          />
        </div>
        <div
          className="absolute inset-0 flex items-center justify-center pl-[10%] text-xs font-extrabold leading-none"
          style={goldTextStyle}
        >
          {formatCountdown(remaining)}
        </div>
      </div>

      <button
        type="button"
        onClick={openChest}
        onPointerDown={(e) => e.stopPropagation()}
        style={{ backgroundImage: `url(${kenTreasureAssets.frameOpen})` }}
        className="absolute bottom-[7%] left-1/2 flex aspect-[1214/355] w-[54%] -translate-x-1/2 translate-y-1/2 items-center justify-center bg-contain bg-center bg-no-repeat transition active:scale-95"
      >
        <span className="text-sm font-extrabold uppercase leading-none" style={whiteTextStyle}>
          {t('kenTreasure.open')}
        </span>
      </button>
    </ChestPanel>
  );
}

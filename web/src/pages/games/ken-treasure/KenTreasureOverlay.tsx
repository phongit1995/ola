import { useEffect, useRef, useState } from 'react';
import type { CSSProperties, ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { kenTreasureAssets, openingFrames } from './kenTreasureAssets';
import { useKenTreasureStore } from './kenTreasureStore';

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
    <img
      src={openingFrames[index] ?? kenTreasureAssets.chestWithEffect}
      alt=""
      draggable={false}
      className="pointer-events-none absolute left-1/2 top-[33%] w-[56%] -translate-x-1/2 select-none"
    />
  );
}

function ChestPanel({
  backgroundSrc,
  widthClassName,
  onClose,
  children,
}: {
  backgroundSrc: string;
  widthClassName: string;
  onClose?: () => void;
  children: ReactNode;
}) {
  const { t } = useTranslation();
  return (
    <div className="fixed inset-0 z-[80] flex items-center justify-center bg-black/60 p-4">
      <div className={`relative w-full ${widthClassName}`}>
        <img src={backgroundSrc} alt="" draggable={false} className="w-full select-none" />
        <img
          src={kenTreasureAssets.crown}
          alt=""
          draggable={false}
          className="pointer-events-none absolute left-1/2 top-[-5%] w-[25%] -translate-x-1/2 select-none"
        />
        {onClose && (
          <button
            type="button"
            aria-label={t('kenTreasure.close')}
            onClick={onClose}
            className="absolute right-[1%] top-[5%] w-[13%] transition active:scale-95"
          >
            <img src={kenTreasureAssets.buttonClose} alt="" draggable={false} className="w-full select-none" />
          </button>
        )}
        {children}
      </div>
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
      widthClassName="max-w-[340px]"
      onClose={onClose}
    >
      <div
        className="absolute left-1/2 top-[8%] w-[74%] -translate-x-1/2 text-center text-xl font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {t('kenTreasure.resultTitle')}
      </div>

      <img
        src={isEmpty ? kenTreasureAssets.resultChestEmpty : kenTreasureAssets.resultChestWin}
        alt=""
        draggable={false}
        className="pointer-events-none absolute left-1/2 top-[23%] w-[54%] -translate-x-1/2 select-none"
      />

      <div
        className="absolute left-1/2 top-[52%] w-[80%] -translate-x-1/2 text-center text-3xl font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {isEmpty ? t('kenTreasure.emptyTitle') : t('kenTreasure.congrats')}
      </div>

      <div className="absolute left-1/2 top-[61%] w-[80%] -translate-x-1/2 text-center text-sm font-semibold leading-none text-[#5a2b12]">
        {isEmpty ? t('kenTreasure.emptyDesc') : t('kenTreasure.youWon')}
      </div>

      {!isEmpty && (
        <div className="absolute left-1/2 top-[67%] w-[78%] -translate-x-1/2">
          <img src={kenTreasureAssets.resultKenCount} alt="" draggable={false} className="w-full select-none" />
          <img
            src={kenTreasureAssets.resultKenCoin}
            alt=""
            draggable={false}
            className="absolute left-[-6%] top-1/2 w-[24%] -translate-y-1/2 select-none"
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
        className="absolute left-1/2 top-[83%] w-[56%] -translate-x-1/2 transition active:scale-95"
      >
        <img src={kenTreasureAssets.resultClose} alt="" draggable={false} className="w-full select-none" />
        <span
          className="absolute inset-0 flex items-center justify-center text-xl font-extrabold uppercase leading-none"
          style={whiteTextStyle}
        >
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

  return (
    <ChestPanel
      backgroundSrc={kenTreasureAssets.frameBackground}
      widthClassName="max-w-[360px]"
      onClose={phase === 'closed' ? dismiss : undefined}
    >
      <div
        className="absolute left-1/2 top-[9%] w-[70%] -translate-x-1/2 text-center text-2xl font-extrabold uppercase leading-none"
        style={goldTextStyle}
      >
        {t('kenTreasure.title')}
      </div>

      {phase === 'opening' ? (
        <OpeningChest />
      ) : (
        <img
          src={kenTreasureAssets.chestWithEffect}
          alt=""
          draggable={false}
          className="pointer-events-none absolute left-1/2 top-[33%] w-[56%] -translate-x-1/2 select-none"
        />
      )}

      {phase === 'closed' && (
        <>
          <div className="absolute left-1/2 top-[64%] w-[64%] -translate-x-1/2">
            <img src={kenTreasureAssets.frameTime} alt="" draggable={false} className="w-full select-none" />
            <img
              src={kenTreasureAssets.buttonHourglass}
              alt=""
              draggable={false}
              className="absolute left-[-8%] top-1/2 w-[26%] -translate-y-1/2 select-none"
            />
            <div
              className="absolute inset-0 flex items-center justify-center pl-[14%] text-xl font-extrabold leading-none"
              style={goldTextStyle}
            >
              {formatCountdown(remaining)}
            </div>
          </div>

          <button
            type="button"
            onClick={openChest}
            className="absolute left-1/2 top-[80%] w-[58%] -translate-x-1/2 transition active:scale-95"
          >
            <img src={kenTreasureAssets.frameOpen} alt="" draggable={false} className="w-full select-none" />
            <span
              className="absolute inset-0 flex items-center justify-center text-2xl font-extrabold uppercase leading-none"
              style={whiteTextStyle}
            >
              {t('kenTreasure.open')}
            </span>
          </button>
        </>
      )}
    </ChestPanel>
  );
}

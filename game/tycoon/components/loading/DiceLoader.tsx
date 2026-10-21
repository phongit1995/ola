import { useEffect, useRef, useState } from 'react';
import fallbackUrl from '../../assets/lobby/ill-dice.webp';
import ringUrl from '../../assets/lobby/loading-ring-enamel.svg';
import { createRoundedDieRenderer } from './roundedDieRenderer';
import './DiceLoader.css';

export function DiceLoader() {
  const rootRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [fallback, setFallback] = useState(false);
  const [hidden, setHidden] = useState(document.hidden);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    setFallback(false);
    const renderer = createRoundedDieRenderer(canvas, () => setFallback(true), frame => {
      rootRef.current?.style.setProperty('--ty-loading-ring-angle', `${frame.ringAngle}deg`);
    });
    return () => renderer?.dispose();
  }, []);

  useEffect(() => {
    const onVisibility = () => setHidden(document.hidden);
    document.addEventListener('visibilitychange', onVisibility);
    return () => document.removeEventListener('visibilitychange', onVisibility);
  }, []);

  return (
    <div ref={rootRef} className="ty-dice-loader" role="status" data-renderer={fallback ? 'fallback' : 'webgl'} data-paused={hidden}>
      <span className="ty-visually-hidden">Đang tải hồ sơ</span>
      <img className="ty-dice-loader-ring" src={ringUrl} alt="" draggable={false} />
      <canvas ref={canvasRef} className="ty-dice-loader-canvas" aria-hidden="true" />
      <img className="ty-dice-loader-fallback" src={fallbackUrl} alt="" draggable={false} />
    </div>
  );
}

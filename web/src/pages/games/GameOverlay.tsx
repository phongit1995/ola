import { lazy, Suspense } from 'react';
import { useGameOverlayStore } from '@/store/gameOverlayStore';

const PenGamePage = lazy(() =>
  import('./pen/PenGamePage').then((m) => ({ default: m.PenGamePage }))
);
const EggGamePage = lazy(() =>
  import('./egg/EggGamePage').then((m) => ({ default: m.EggGamePage }))
);

export function GameOverlay() {
  const active = useGameOverlayStore((s) => s.active);
  const close = useGameOverlayStore((s) => s.close);

  if (active == null) return null;

  return (
    <Suspense fallback={null}>
      {active === 'pen' ? <PenGamePage onClose={close} /> : <EggGamePage onClose={close} />}
    </Suspense>
  );
}

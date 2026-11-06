import { useLayoutEffect, useRef } from 'react';
import { logBreadcrumb } from '@lib/telemetry';

export function useOverlayBreadcrumb(name: string, state: string | null) {
  const lastRef = useRef<string | null>(null);

  useLayoutEffect(() => {
    if (state === lastRef.current) return;
    lastRef.current = state;
    logBreadcrumb(`overlay ${name}: ${state ?? 'hidden'}`);
  }, [name, state]);
}

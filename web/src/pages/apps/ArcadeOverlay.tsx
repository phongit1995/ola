import { useEffect, useRef } from 'react';
import { ensureFreshToken } from '@ola/shared/api';
import { useArcadeStore } from '@/store/arcadeStore';

interface GameBridgeMessage {
  source?: string;
  type?: string;
}

export function ArcadeOverlay() {
  const active = useArcadeStore((s) => s.active);
  const close = useArcadeStore((s) => s.close);
  const iframeRef = useRef<HTMLIFrameElement>(null);

  useEffect(() => {
    if (!active) return;
    const gameOrigin = new URL(active.gameUrl).origin;

    async function onMessage(event: MessageEvent) {
      if (event.origin !== gameOrigin) return;
      const data = event.data as GameBridgeMessage;
      if (data?.source !== 'ola-game') return;
      if (data.type === 'get_token') {
        const token = await ensureFreshToken();
        iframeRef.current?.contentWindow?.postMessage(
          { source: 'ola-host', type: 'token', data: token },
          gameOrigin,
        );
      }
      if (data.type === 'exit') {
        close();
      }
    }

    window.addEventListener('message', onMessage);
    return () => window.removeEventListener('message', onMessage);
  }, [active, close]);

  if (!active) return null;

  return (
    <div className="absolute inset-0 z-50 bg-[#0f0f23]">
      <iframe
        ref={iframeRef}
        src={active.gameUrl}
        title={active.name}
        className="h-full w-full border-0"
        allow="autoplay; fullscreen"
      />
    </div>
  );
}

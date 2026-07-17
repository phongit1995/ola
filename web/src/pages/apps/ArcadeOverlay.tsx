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
    <div className="absolute inset-0 z-50 flex flex-col bg-[#0f0f23]">
      <div className="flex items-center justify-between border-b border-white/10 px-3 py-2">
        <span className="flex items-center gap-2 text-sm font-semibold text-white">
          {active.iconUrl && (
            <img src={active.iconUrl} alt="" className="h-6 w-6 rounded object-cover" />
          )}
          {active.name}
        </span>
        <button
          type="button"
          onClick={close}
          aria-label="Đóng game"
          className="flex h-8 w-8 items-center justify-center rounded-full text-white/70 hover:bg-white/10 hover:text-white"
        >
          <svg
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            className="h-5 w-5"
          >
            <path d="M18 6 6 18M6 6l12 12" />
          </svg>
        </button>
      </div>
      <iframe
        ref={iframeRef}
        src={active.gameUrl}
        title={active.name}
        className="w-full flex-1 border-0"
        allow="autoplay; fullscreen"
      />
    </div>
  );
}

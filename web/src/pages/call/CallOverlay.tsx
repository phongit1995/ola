import { LiveKitRoom, RoomAudioRenderer } from '@livekit/components-react';
import { CALL_MODE } from '@constants';
import { useCallStore } from '@/store/callStore';
import { CallContent } from './CallContent';
import { IncomingCallCard } from './IncomingCallCard';
import { useEndCallOnUnload } from './hooks/useEndCallOnUnload';

export function CallOverlay() {
  const mode = useCallStore((s) => s.mode);
  const active = useCallStore((s) => s.active);

  useEndCallOnUnload();

  if (mode === CALL_MODE.incoming) return <IncomingCallCard />;
  if (active == null || mode === CALL_MODE.idle) return null;

  return (
    <LiveKitRoom
      serverUrl={active.wsUrl}
      token={active.token}
      connect
      audio={false}
      video={false}
      options={{ adaptiveStream: true, dynacast: true }}
      className="contents"
    >
      <RoomAudioRenderer />
      <CallContent />
    </LiveKitRoom>
  );
}

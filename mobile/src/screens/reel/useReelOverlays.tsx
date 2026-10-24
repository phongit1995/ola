import { useCallback, useState } from 'react';
import { activeReelGroups } from '@ola/shared/lib';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import type { ReelTrayGroup, ReelViewerSession } from '@ola/shared/types';
import { ReelComposerModal } from './components/ReelComposerModal';
import { ReelViewer } from './components/ReelViewer';

export type OpenReelViewer = (groups: ReelTrayGroup[], authorId: string, own: boolean) => void;

export function useReelOverlays() {
  const tick = useReelStore((s) => s.tick);
  const flushSeen = useReelStore((s) => s.flushSeen);
  const [session, setSession] = useState<ReelViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);

  const openViewer = useCallback<OpenReelViewer>(
    (groups, authorId, own) => {
      const active = activeReelGroups(groups, Date.now());
      const startIndex = active.findIndex((group) => group.author.id === authorId);
      tick();
      if (startIndex >= 0) setSession({ groups: active, startIndex, own });
    },
    [tick]
  );

  const closeViewer = useCallback(() => {
    setSession(null);
    tick();
    void flushSeen();
  }, [tick, flushSeen]);

  const openComposer = useCallback(() => setComposerOpen(true), []);

  const overlays = (
    <>
      {session && <ReelViewer session={session} onClose={closeViewer} />}
      <ReelComposerModal visible={composerOpen} onClose={() => setComposerOpen(false)} />
    </>
  );

  return { openViewer, openComposer, overlays };
}

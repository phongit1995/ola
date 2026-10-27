import { useCallback, useState } from 'react';
import { activeMomentGroups } from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import type { Moment, MomentTrayGroup, MomentViewerSession } from '@ola/shared/types';
import { MomentComposerModal } from './components/MomentComposerModal';
import { MomentViewer } from './components/MomentViewer';

export type OpenMomentViewer = (groups: MomentTrayGroup[], authorId: string, own: boolean) => void;

export function useMomentOverlays() {
  const tick = useMomentStore((s) => s.tick);
  const flushSeen = useMomentStore((s) => s.flushSeen);
  const flushReactions = useMomentStore((s) => s.flushReactions);
  const [session, setSession] = useState<MomentViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);

  const openViewer = useCallback<OpenMomentViewer>(
    (groups, authorId, own) => {
      const active = activeMomentGroups(groups, Date.now());
      const startIndex = active.findIndex((group) => group.author.id === authorId);
      tick();
      if (startIndex >= 0) setSession({ groups: active, startIndex, own });
    },
    [tick]
  );

  const openArchive = useCallback(
    (moment: Moment) => {
      tick();
      setSession({
        groups: [{ author: moment.author, moments: [] }],
        startIndex: 0,
        own: true,
        archive: true,
        startMomentId: moment.id,
      });
    },
    [tick]
  );

  const closeViewer = useCallback(() => {
    setSession(null);
    tick();
    void flushSeen();
    void flushReactions();
  }, [tick, flushSeen, flushReactions]);

  const openComposer = useCallback(() => setComposerOpen(true), []);

  const overlays = (
    <>
      {session && <MomentViewer session={session} onClose={closeViewer} />}
      <MomentComposerModal visible={composerOpen} onClose={() => setComposerOpen(false)} />
    </>
  );

  return { openViewer, openArchive, openComposer, overlays };
}

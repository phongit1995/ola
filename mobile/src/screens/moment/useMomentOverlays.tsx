import { useCallback, useState } from 'react';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { activeMomentGroups, colorForName, isMomentGroupSeen } from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import type { Moment, MomentAuthor, MomentTrayGroup, MomentViewerSession } from '@ola/shared/types';
import { ROOT_ROUTES } from '@navigation/routes';
import type { RootStackParamList } from '@navigation/types';
import { MomentComposerModal } from './components/MomentComposerModal';
import { MomentViewer } from './components/MomentViewer';

export type OpenMomentViewer = (groups: MomentTrayGroup[], authorId: string, own: boolean) => void;

export function useMomentOverlays() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const tick = useMomentStore((s) => s.tick);
  const flushSeen = useMomentStore((s) => s.flushSeen);
  const flushReactions = useMomentStore((s) => s.flushReactions);
  const seenIds = useMomentStore((s) => s.seenIds);
  const [session, setSession] = useState<MomentViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);

  const openViewer = useCallback<OpenMomentViewer>(
    (groups, authorId, own) => {
      const active = activeMomentGroups(groups, Date.now());
      const startIndex = active.findIndex((group) => group.author.id === authorId);
      const start = active[startIndex];
      tick();
      if (start == null) return;
      setSession({ groups: active, startIndex, own, unseenOnly: !own && !isMomentGroupSeen(start, seenIds) });
    },
    [tick, seenIds]
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

  const openProfile = useCallback(
    (author: MomentAuthor) => {
      closeViewer();
      navigation.navigate(ROOT_ROUTES.ProfileView, {
        userId: author.username,
        color: colorForName(author.username),
      });
    },
    [closeViewer, navigation]
  );

  const openComposer = useCallback(() => setComposerOpen(true), []);

  const overlays = (
    <>
      {session && <MomentViewer session={session} onClose={closeViewer} onOpenProfile={openProfile} />}
      <MomentComposerModal visible={composerOpen} onClose={() => setComposerOpen(false)} />
    </>
  );

  return { openViewer, openArchive, openComposer, overlays };
}

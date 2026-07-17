import { OlaModal } from '@components/OlaModal';
import { useClanOverlayStore, type ClanOverlayEntry } from '@store/clanOverlayStore';
import { ClanHomeScreen } from './ClanHomeScreen';
import { ClanScreen } from './ClanScreen';
import { ClanMembersScreen } from './ClanMembersScreen';
import { ClanManageScreen } from './ClanManageScreen';
import { ClanBansScreen } from './ClanBansScreen';

function ClanEntryScreen({ entry }: { entry: ClanOverlayEntry }) {
  const back = useClanOverlayStore((s) => s.back);
  const push = useClanOverlayStore((s) => s.push);

  switch (entry.kind) {
    case 'home':
      return (
        <ClanHomeScreen onClose={back} onOpenClan={(handle) => push({ kind: 'clan', handle })} />
      );
    case 'clan':
      return (
        <ClanScreen
          key={entry.handle ?? entry.id}
          handle={entry.handle}
          id={entry.id}
          onClose={back}
          onOpenManage={(clanId) => push({ kind: 'manage', clanId })}
          onOpenMembers={(clanId) => push({ kind: 'members', clanId })}
        />
      );
    case 'manage':
      return (
        <ClanManageScreen
          clanId={entry.clanId}
          onClose={back}
          onOpenMembers={(clanId) => push({ kind: 'members', clanId })}
          onOpenBans={(clanId) => push({ kind: 'bans', clanId })}
        />
      );
    case 'members':
      return <ClanMembersScreen clanId={entry.clanId} onClose={back} />;
    case 'bans':
      return <ClanBansScreen clanId={entry.clanId} onClose={back} />;
  }
}

export function ClanOverlayHost() {
  const stack = useClanOverlayStore((s) => s.stack);
  const back = useClanOverlayStore((s) => s.back);

  const top = stack[stack.length - 1];
  if (top == null) return null;

  return (
    <OlaModal visible transparent animationType="slide" onRequestClose={back}>
      <ClanEntryScreen key={stack.length} entry={top} />
    </OlaModal>
  );
}

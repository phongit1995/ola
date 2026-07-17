import { useClanOverlayStore } from '@/store/clanOverlayStore';
import { ClanBansView } from './ClanBansView';
import { ClanHomeView } from './ClanHomeView';
import { ClanManagePage } from './ClanManagePage';
import { ClanMembersView } from './ClanMembersView';
import { ClanPage } from './ClanPage';

export function ClanOverlayHost() {
  const stack = useClanOverlayStore((s) => s.stack);
  const back = useClanOverlayStore((s) => s.back);
  const push = useClanOverlayStore((s) => s.push);

  const top = stack[stack.length - 1];
  if (top == null) return null;

  switch (top.kind) {
    case 'home':
      return (
        <ClanHomeView
          onClose={back}
          onOpenClan={(handle) => push({ kind: 'clan', handle })}
        />
      );
    case 'clan':
      return (
        <ClanPage
          key={top.handle ?? top.id}
          handle={top.handle}
          id={top.id}
          onClose={back}
          onOpenManage={(clanId) => push({ kind: 'manage', clanId })}
          onOpenMembers={(clanId) => push({ kind: 'members', clanId })}
        />
      );
    case 'manage':
      return (
        <ClanManagePage
          clanId={top.clanId}
          onClose={back}
          onOpenMembers={(clanId) => push({ kind: 'members', clanId })}
          onOpenBans={(clanId) => push({ kind: 'bans', clanId })}
        />
      );
    case 'members':
      return <ClanMembersView clanId={top.clanId} onClose={back} />;
    case 'bans':
      return <ClanBansView clanId={top.clanId} onClose={back} />;
  }
}

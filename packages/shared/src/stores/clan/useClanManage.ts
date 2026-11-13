import { useCallback, useEffect, useState } from 'react';
import i18n from 'i18next';
import { CLAN_ROLE } from '../../constants/clan';
import { clanErrorText, clanRoleHolder } from '../../lib/clanHelpers';
import { toast } from '../../lib/toast';
import { ClanService } from '../../services/clan.service';
import type { Clan, ClanPolicy } from '../../types/api/clan.type';

export type ClanAssignableRole = typeof CLAN_ROLE.deputy | typeof CLAN_ROLE.ambassador;

export type ClanVerifyAction = 'verify' | 'unverify';

function normalizeNick(value: string): string {
  return value.trim().replace(/^@/, '');
}

export function useClanManage(clanId: string) {
  const [clan, setClan] = useState<Clan | null>(null);
  const [roleDialog, setRoleDialog] = useState<ClanAssignableRole | null>(null);
  const [roleNick, setRoleNick] = useState('');
  const [revokeRole, setRevokeRole] = useState<{
    role: ClanAssignableRole;
    username: string;
  } | null>(null);
  const [policyOpen, setPolicyOpen] = useState(false);
  const [publicPostConfirm, setPublicPostConfirm] = useState(false);
  const [verifyDialog, setVerifyDialog] = useState<ClanVerifyAction | null>(null);
  const [verifyNick, setVerifyNick] = useState('');
  const [busy, setBusy] = useState(false);

  const reload = useCallback(async () => {
    try {
      setClan(await ClanService.get(clanId));
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }, [clanId]);

  useEffect(() => {
    let active = true;
    ClanService.get(clanId)
      .then((loaded) => {
        if (active) setClan(loaded);
      })
      .catch((error) => toast.error(clanErrorText(error)));
    return () => {
      active = false;
    };
  }, [clanId]);

  async function runAction(action: () => Promise<void>, onSettled?: () => void) {
    setBusy(true);
    try {
      await action();
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
      onSettled?.();
    }
  }

  function openRoleDialog(role: ClanAssignableRole) {
    if (clan == null) return;
    setRoleNick(clanRoleHolder(clan, role) ?? '');
    setRoleDialog(role);
  }

  async function submitRole() {
    if (clan == null || roleDialog == null || busy) return;
    const nick = normalizeNick(roleNick);
    const currentHolder = clanRoleHolder(clan, roleDialog);
    if (nick === '') {
      setRoleDialog(null);
      if (currentHolder != null && currentHolder !== '') {
        setRevokeRole({ role: roleDialog, username: currentHolder });
      }
      return;
    }
    await runAction(async () => {
      await ClanService.assignRole(clan.id, { username: nick, role: roleDialog });
      toast.success(i18n.t('clan.assignSuccess', { username: nick }));
      setRoleDialog(null);
      await reload();
    });
  }

  async function submitRevoke() {
    if (clan == null || revokeRole == null || busy) return;
    await runAction(async () => {
      await ClanService.revokeRole(clan.id, revokeRole.role);
      toast.success(i18n.t('clan.revokeSuccess'));
      setRevokeRole(null);
      await reload();
    });
  }

  async function submitPolicy(policy: ClanPolicy) {
    if (clan == null || busy || policy === clan.policy) return;
    await runAction(async () => {
      setClan(await ClanService.update(clan.id, { policy }));
    });
  }

  async function submitMemberPublicPost(value: boolean) {
    if (clan == null || busy) return;
    await runAction(
      async () => {
        setClan(await ClanService.update(clan.id, { memberPublicPost: value }));
      },
      () => setPublicPostConfirm(false)
    );
  }

  async function submitVerify() {
    if (clan == null || verifyDialog == null || busy) return;
    const nick = normalizeNick(verifyNick);
    if (nick === '') return;
    await runAction(async () => {
      if (verifyDialog === 'verify') {
        await ClanService.verify(clan.id, nick);
        toast.success(i18n.t('clan.verifySuccess', { username: nick, name: clan.handle }));
      } else {
        await ClanService.unverify(clan.id, nick);
        toast.success(i18n.t('clan.unverifySuccess', { username: nick, name: clan.handle }));
      }
      setVerifyDialog(null);
      setVerifyNick('');
    });
  }

  return {
    clan,
    busy,
    roleDialog,
    setRoleDialog,
    roleNick,
    setRoleNick,
    revokeRole,
    setRevokeRole,
    policyOpen,
    setPolicyOpen,
    publicPostConfirm,
    setPublicPostConfirm,
    verifyDialog,
    setVerifyDialog,
    verifyNick,
    setVerifyNick,
    openRoleDialog,
    submitRole,
    submitRevoke,
    submitPolicy,
    submitMemberPublicPost,
    submitVerify,
  };
}

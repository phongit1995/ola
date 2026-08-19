import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  Dialog,
  DialogButton,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  Spinner,
  type ListOption,
} from '@components';
import { toast } from '@lib';
import { ClanService } from '@services';
import type { Clan, ClanPolicy } from '@app-types';
import { clanErrorText, clanPolicyLabel } from './clanHelpers';
import editIcon from '@/assets/icons/me/ic_action_edit.png';

interface ClanManagePageProps {
  clanId: string;
  onClose: () => void;
  onOpenMembers: (clanId: string) => void;
  onOpenBans: (clanId: string) => void;
}

type RoleKind = 'deputy' | 'ambassador';
type VerifyKind = 'verify' | 'unverify';

interface ManageRowProps {
  label: string;
  value: string;
  emptyText: string;
  editable: boolean;
  onEdit?: () => void;
}

function ManageRow({
  label,
  value,
  emptyText,
  editable,
  onEdit,
}: ManageRowProps) {
  const body = (
    <>
      <span className="block text-xs text-black/54">{label}</span>
      <span className="mt-1 flex items-center gap-2">
        <span
          className={`flex-1 truncate text-sm ${
            value !== '' ? 'text-black/87' : 'text-ola-error'
          }`}
        >
          {value !== '' ? value : emptyText}
        </span>
        {editable && (
          <span className="rounded bg-black/38 p-1">
            <img
              src={editIcon}
              alt=""
              className="h-4 w-4 object-contain brightness-0 invert"
            />
          </span>
        )}
      </span>
    </>
  );
  if (!editable) {
    return <div className="px-2 py-3">{body}</div>;
  }
  return (
    <button
      type="button"
      onClick={onEdit}
      className="block w-full px-2 py-3 text-left active:bg-black/5"
    >
      {body}
    </button>
  );
}

export function ClanManagePage({
  clanId,
  onClose,
  onOpenMembers,
  onOpenBans,
}: ClanManagePageProps) {
  const { t } = useTranslation();
  const [clan, setClan] = useState<Clan | null>(null);
  const [roleDialog, setRoleDialog] = useState<RoleKind | null>(null);
  const [roleNick, setRoleNick] = useState('');
  const [revokeRole, setRevokeRole] = useState<{
    role: RoleKind;
    username: string;
  } | null>(null);
  const [policyOpen, setPolicyOpen] = useState(false);
  const [publicPostConfirm, setPublicPostConfirm] = useState(false);
  const [verifyDialog, setVerifyDialog] = useState<VerifyKind | null>(null);
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

  function openRoleDialog(role: RoleKind) {
    if (clan == null) return;
    setRoleNick(
      (role === 'deputy' ? clan.deputy?.username : clan.ambassador?.username) ??
        ''
    );
    setRoleDialog(role);
  }

  async function submitRole() {
    if (clan == null || roleDialog == null || busy) return;
    const nick = roleNick.trim().replace(/^@/, '');
    const currentHolder =
      roleDialog === 'deputy'
        ? clan.deputy?.username
        : clan.ambassador?.username;
    if (nick === '') {
      setRoleDialog(null);
      if (currentHolder != null && currentHolder !== '') {
        setRevokeRole({ role: roleDialog, username: currentHolder });
      }
      return;
    }
    setBusy(true);
    try {
      await ClanService.assignRole(clan.id, {
        username: nick,
        role: roleDialog,
      });
      toast.success(t('clan.assignSuccess', { username: nick }));
      setRoleDialog(null);
      await reload();
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  async function submitRevoke() {
    if (clan == null || revokeRole == null || busy) return;
    setBusy(true);
    try {
      await ClanService.revokeRole(clan.id, revokeRole.role);
      toast.success(t('clan.revokeSuccess'));
      setRevokeRole(null);
      await reload();
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  async function submitPolicy(policy: ClanPolicy) {
    if (clan == null || busy || policy === clan.policy) return;
    setBusy(true);
    try {
      setClan(await ClanService.update(clan.id, { policy }));
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  async function submitMemberPublicPost(value: boolean) {
    if (clan == null || busy) return;
    setBusy(true);
    try {
      setClan(await ClanService.update(clan.id, { memberPublicPost: value }));
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
      setPublicPostConfirm(false);
    }
  }

  async function submitVerify() {
    if (clan == null || verifyDialog == null || busy) return;
    const nick = verifyNick.trim().replace(/^@/, '');
    if (nick === '') return;
    setBusy(true);
    try {
      if (verifyDialog === 'verify') {
        await ClanService.verify(clan.id, nick);
        toast.success(
          t('clan.verifySuccess', { username: nick, name: clan.handle })
        );
      } else {
        await ClanService.unverify(clan.id, nick);
        toast.success(
          t('clan.unverifySuccess', { username: nick, name: clan.handle })
        );
      }
      setVerifyDialog(null);
      setVerifyNick('');
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  const policyOptions: ListOption[] = ([0, 1, 2, 4, 3] as ClanPolicy[]).map(
    (policy) => ({
      key: String(policy),
      label: (clan?.policy === policy ? '✓ ' : '') + clanPolicyLabel(policy),
      onSelect: () => void submitPolicy(policy),
    })
  );

  return (
    <FullScreenOverlay>
      <ScreenHeader
        title={clan != null ? `#${clan.handle}` : t('clan.manage')}
        onBack={onClose}
      />
      {clan == null ? (
        <div className="flex flex-1 items-center justify-center">
          <Spinner size={28} />
        </div>
      ) : (
        <div className="flex-1 overflow-y-auto p-2">
          <div className="rounded-md bg-white">
            <ManageRow
              label={t('clan.roleOwner')}
              value={clan.owner?.username ?? ''}
              emptyText={t('clan.none')}
              editable={false}
            />
            <div className="h-px bg-black/12" />
            <ManageRow
              label={t('clan.roleDeputy')}
              value={clan.deputy?.username ?? ''}
              emptyText={t('clan.none')}
              editable
              onEdit={() => openRoleDialog('deputy')}
            />
            <div className="h-px bg-black/12" />
            <ManageRow
              label={t('clan.roleAmbassador')}
              value={clan.ambassador?.username ?? ''}
              emptyText={t('clan.none')}
              editable
              onEdit={() => openRoleDialog('ambassador')}
            />
            <div className="h-px bg-black/12" />
            <ManageRow
              label={t('clan.policy')}
              value={clanPolicyLabel(clan.policy)}
              emptyText=""
              editable
              onEdit={() => setPolicyOpen(true)}
            />
            <div className="h-px bg-black/12" />
            <div className="flex items-center px-2 py-3">
              <span className="flex-1 text-sm text-black/87">
                {t('clan.memberPublicPost')}
              </span>
              <button
                type="button"
                role="switch"
                aria-checked={clan.memberPublicPost}
                onClick={() => {
                  if (clan.memberPublicPost) {
                    setPublicPostConfirm(true);
                  } else {
                    void submitMemberPublicPost(true);
                  }
                }}
                className={`h-6 w-11 rounded-full p-0.5 transition-colors ${
                  clan.memberPublicPost ? 'bg-ola-primary' : 'bg-black/26'
                }`}
              >
                <span
                  className={`block h-5 w-5 rounded-full bg-white transition-transform ${
                    clan.memberPublicPost ? 'translate-x-5' : ''
                  }`}
                />
              </button>
            </div>
          </div>

          <div className="mt-4 flex gap-2">
            <button
              type="button"
              onClick={() => {
                setVerifyNick('');
                setVerifyDialog('verify');
              }}
              className="flex-1 truncate rounded-sm border border-black/12 bg-white px-2 py-3 text-xs text-[#808080] active:bg-black/5"
            >
              {t('clan.verifyMember')}
            </button>
            <button
              type="button"
              onClick={() => {
                setVerifyNick('');
                setVerifyDialog('unverify');
              }}
              className="flex-1 truncate rounded-sm border border-black/12 bg-white px-2 py-3 text-xs text-[#808080] active:bg-black/5"
            >
              {t('clan.unverifyMember')}
            </button>
          </div>

          <div className="mt-4 overflow-hidden rounded-md bg-white">
            <button
              type="button"
              onClick={() => onOpenMembers(clan.id)}
              className="flex w-full items-center justify-between px-4 py-3 text-sm text-black/87 active:bg-black/5"
            >
              {t('clan.members')}
              <span className="text-black/54">
                {clan.memberCount.toLocaleString()}
              </span>
            </button>
            <div className="h-px bg-black/12" />
            <button
              type="button"
              onClick={() => onOpenBans(clan.id)}
              className="flex w-full items-center justify-between px-4 py-3 text-sm text-black/87 active:bg-black/5"
            >
              {t('clan.banList')}
              <span className="text-black/54">›</span>
            </button>
          </div>
        </div>
      )}

      <Dialog
        open={roleDialog != null}
        onClose={() => setRoleDialog(null)}
        title={
          roleDialog === 'deputy'
            ? t('clan.roleDeputy')
            : t('clan.roleAmbassador')
        }
        footer={
          <>
            <DialogButton
              variant="green"
              onClick={() => void submitRole()}
              disabled={busy}
            >
              {t('dialog.accept')}
            </DialogButton>
            <DialogButton variant="default" onClick={() => setRoleDialog(null)}>
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <input
          value={roleNick}
          onChange={(event) => setRoleNick(event.target.value)}
          placeholder={t('clan.enterNick')}
          maxLength={32}
          className="w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
        />
      </Dialog>

      <ConfirmDialog
        open={revokeRole != null}
        title={t('clan.manage')}
        message={
          revokeRole == null
            ? ''
            : revokeRole.role === 'deputy'
            ? t('clan.revokeConfirmDeputy', { username: revokeRole.username })
            : t('clan.revokeConfirmAmbassador', {
                username: revokeRole.username,
              })
        }
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        danger
        onCancel={() => setRevokeRole(null)}
        onConfirm={() => void submitRevoke()}
      />

      <ListOptionDialog
        open={policyOpen}
        title={t('clan.policy')}
        options={policyOptions}
        onClose={() => setPolicyOpen(false)}
      />

      <ConfirmDialog
        open={publicPostConfirm}
        title={t('clan.memberPublicPost')}
        message={t('clan.memberPublicPostOffConfirm')}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        danger
        onCancel={() => setPublicPostConfirm(false)}
        onConfirm={() => void submitMemberPublicPost(false)}
      />

      <Dialog
        open={verifyDialog != null}
        onClose={() => setVerifyDialog(null)}
        title={
          verifyDialog === 'unverify'
            ? t('clan.unverifyMember')
            : t('clan.verifyMember')
        }
        footer={
          <>
            <DialogButton
              variant="green"
              onClick={() => void submitVerify()}
              disabled={busy || verifyNick.trim() === ''}
            >
              {t('dialog.accept')}
            </DialogButton>
            <DialogButton
              variant="default"
              onClick={() => setVerifyDialog(null)}
            >
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <input
          value={verifyNick}
          onChange={(event) => setVerifyNick(event.target.value)}
          placeholder={t('clan.enterNick')}
          maxLength={32}
          className="w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
        />
      </Dialog>
    </FullScreenOverlay>
  );
}

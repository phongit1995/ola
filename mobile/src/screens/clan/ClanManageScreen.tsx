import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  ScrollView,
  Switch,
  Text,
  TextInput,
  View,
} from 'react-native';
import { ClanService } from '@ola/shared/services';
import type { Clan, ClanPolicy } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { ConfirmDialog } from '@components/ConfirmDialog';
import { Dialog, DialogButton } from '@components/Dialog';
import { ListOptionDialog, type ListOption } from '@components/ListOptionDialog';
import { ScreenHeader } from '@components/ScreenHeader';
import { clanErrorText, clanPolicyLabel } from '@lib/clanHelpers';

const editIcon = require('@assets/icons/me/ic_action_edit.png');

interface ClanManageScreenProps {
  clanId: string;
  onClose: () => void;
  onOpenMembers: (clanId: string) => void;
  onOpenBans: (clanId: string) => void;
}

type RoleKind = 'deputy' | 'ambassador';
type VerifyKind = 'verify' | 'unverify';

function ManageRow({
  label,
  value,
  emptyText,
  editable,
  onEdit,
}: {
  label: string;
  value: string;
  emptyText: string;
  editable: boolean;
  onEdit?: () => void;
}) {
  const body = (
    <>
      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
        {label}
      </Text>
      <View className="mt-1 flex-row items-center gap-2">
        <Text
          numberOfLines={1}
          className="flex-1 text-sm"
          style={{ color: value !== '' ? 'rgba(0,0,0,0.87)' : '#e34545' }}
        >
          {value !== '' ? value : emptyText}
        </Text>
        {editable && (
          <View className="rounded p-1" style={{ backgroundColor: 'rgba(0,0,0,0.38)' }}>
            <Image source={editIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
          </View>
        )}
      </View>
    </>
  );
  if (!editable) {
    return <View className="px-2 py-3">{body}</View>;
  }
  return (
    <Pressable onPress={onEdit} className="px-2 py-3 active:bg-black/5">
      {body}
    </Pressable>
  );
}

export function ClanManageScreen({
  clanId,
  onClose,
  onOpenMembers,
  onOpenBans,
}: ClanManageScreenProps) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);
  const [clan, setClan] = useState<Clan | null>(null);
  const [roleDialog, setRoleDialog] = useState<RoleKind | null>(null);
  const [roleNick, setRoleNick] = useState('');
  const [revokeRole, setRevokeRole] = useState<{ role: RoleKind; username: string } | null>(null);
  const [policyOpen, setPolicyOpen] = useState(false);
  const [publicPostConfirm, setPublicPostConfirm] = useState(false);
  const [verifyDialog, setVerifyDialog] = useState<VerifyKind | null>(null);
  const [verifyNick, setVerifyNick] = useState('');
  const [busy, setBusy] = useState(false);

  const reload = useCallback(async () => {
    try {
      setClan(await ClanService.get(clanId));
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }, [clanId, pushToast]);

  useEffect(() => {
    void reload();
  }, [reload]);

  function openRoleDialog(role: RoleKind) {
    if (clan == null) return;
    setRoleNick((role === 'deputy' ? clan.deputy?.username : clan.ambassador?.username) ?? '');
    setRoleDialog(role);
  }

  async function submitRole() {
    if (clan == null || roleDialog == null || busy) return;
    const nick = roleNick.trim().replace(/^@/, '');
    const currentHolder =
      roleDialog === 'deputy' ? clan.deputy?.username : clan.ambassador?.username;
    if (nick === '') {
      setRoleDialog(null);
      if (currentHolder != null && currentHolder !== '') {
        setRevokeRole({ role: roleDialog, username: currentHolder });
      }
      return;
    }
    setBusy(true);
    try {
      await ClanService.assignRole(clan.id, { username: nick, role: roleDialog });
      pushToast('success', t('clan.assignSuccess', { username: nick }));
      setRoleDialog(null);
      await reload();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  async function submitRevoke() {
    if (clan == null || revokeRole == null || busy) return;
    setBusy(true);
    try {
      await ClanService.revokeRole(clan.id, revokeRole.role);
      pushToast('success', t('clan.revokeSuccess'));
      setRevokeRole(null);
      await reload();
    } catch (error) {
      pushToast('error', clanErrorText(error));
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
      pushToast('error', clanErrorText(error));
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
      pushToast('error', clanErrorText(error));
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
        pushToast('success', t('clan.verifySuccess', { username: nick, name: clan.handle }));
      } else {
        await ClanService.unverify(clan.id, nick);
        pushToast('success', t('clan.unverifySuccess', { username: nick, name: clan.handle }));
      }
      setVerifyDialog(null);
      setVerifyNick('');
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setBusy(false);
    }
  }

  const policyOptions: ListOption[] = ([0, 1, 2, 4, 3] as ClanPolicy[]).map((policy) => ({
    key: String(policy),
    label: (clan?.policy === policy ? '✓ ' : '') + clanPolicyLabel(policy),
    onSelect: () => void submitPolicy(policy),
  }));

  const divider = <View style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />;

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={clan != null ? `#${clan.handle}` : t('clan.manage')} onBack={onClose} />
      {clan == null ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <ScrollView className="flex-1 p-2">
          <View className="rounded-md bg-white">
            <ManageRow
              label={t('clan.roleOwner')}
              value={clan.owner?.username ?? ''}
              emptyText={t('clan.none')}
              editable={false}
            />
            {divider}
            <ManageRow
              label={t('clan.roleDeputy')}
              value={clan.deputy?.username ?? ''}
              emptyText={t('clan.none')}
              editable
              onEdit={() => openRoleDialog('deputy')}
            />
            {divider}
            <ManageRow
              label={t('clan.roleAmbassador')}
              value={clan.ambassador?.username ?? ''}
              emptyText={t('clan.none')}
              editable
              onEdit={() => openRoleDialog('ambassador')}
            />
            {divider}
            <ManageRow
              label={t('clan.policy')}
              value={clanPolicyLabel(clan.policy)}
              emptyText=""
              editable
              onEdit={() => setPolicyOpen(true)}
            />
            {divider}
            <View className="flex-row items-center px-2 py-3">
              <Text className="flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {t('clan.memberPublicPost')}
              </Text>
              <Switch
                value={clan.memberPublicPost}
                trackColor={{ true: '#7cb342' }}
                onValueChange={(value) => {
                  if (!value) {
                    setPublicPostConfirm(true);
                  } else {
                    void submitMemberPublicPost(true);
                  }
                }}
              />
            </View>
          </View>

          <View className="mt-4 flex-row gap-2">
            <Pressable
              onPress={() => {
                setVerifyNick('');
                setVerifyDialog('verify');
              }}
              className="flex-1 items-center rounded-sm bg-white px-2 py-3 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Text numberOfLines={1} className="text-xs" style={{ color: '#808080' }}>
                {t('clan.verifyMember')}
              </Text>
            </Pressable>
            <Pressable
              onPress={() => {
                setVerifyNick('');
                setVerifyDialog('unverify');
              }}
              className="flex-1 items-center rounded-sm bg-white px-2 py-3 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Text numberOfLines={1} className="text-xs" style={{ color: '#808080' }}>
                {t('clan.unverifyMember')}
              </Text>
            </Pressable>
          </View>

          <View className="mt-4 overflow-hidden rounded-md bg-white">
            <Pressable
              onPress={() => onOpenMembers(clan.id)}
              className="flex-row items-center justify-between px-4 py-3 active:bg-black/5"
            >
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {t('clan.members')}
              </Text>
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {clan.memberCount.toLocaleString()}
              </Text>
            </Pressable>
            {divider}
            <Pressable
              onPress={() => onOpenBans(clan.id)}
              className="flex-row items-center justify-between px-4 py-3 active:bg-black/5"
            >
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {t('clan.banList')}
              </Text>
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                ›
              </Text>
            </Pressable>
          </View>
        </ScrollView>
      )}

      <Dialog
        visible={roleDialog != null}
        onClose={() => setRoleDialog(null)}
        title={roleDialog === 'deputy' ? t('clan.roleDeputy') : t('clan.roleAmbassador')}
        footer={
          <>
            <DialogButton variant="green" onPress={() => void submitRole()} disabled={busy}>
              {t('dialog.accept')}
            </DialogButton>
            <DialogButton variant="default" onPress={() => setRoleDialog(null)}>
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <TextInput
          value={roleNick}
          onChangeText={setRoleNick}
          placeholder={t('clan.enterNick')}
          placeholderTextColor="rgba(0,0,0,0.38)"
          maxLength={32}
          autoCapitalize="none"
          autoCorrect={false}
          className="w-full rounded px-3 text-base"
          style={{
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.12)',
            color: 'rgba(0,0,0,0.87)',
            paddingVertical: 8,
          }}
        />
      </Dialog>

      <ConfirmDialog
        visible={revokeRole != null}
        danger
        title={t('clan.manage')}
        message={
          revokeRole == null
            ? ''
            : revokeRole.role === 'deputy'
              ? t('clan.revokeConfirmDeputy', { username: revokeRole.username })
              : t('clan.revokeConfirmAmbassador', { username: revokeRole.username })
        }
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onCancel={() => setRevokeRole(null)}
        onConfirm={() => void submitRevoke()}
      />

      <ListOptionDialog
        visible={policyOpen}
        title={t('clan.policy')}
        options={policyOptions}
        onClose={() => setPolicyOpen(false)}
      />

      <ConfirmDialog
        visible={publicPostConfirm}
        danger
        title={t('clan.memberPublicPost')}
        message={t('clan.memberPublicPostOffConfirm')}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        onCancel={() => setPublicPostConfirm(false)}
        onConfirm={() => void submitMemberPublicPost(false)}
      />

      <Dialog
        visible={verifyDialog != null}
        onClose={() => setVerifyDialog(null)}
        title={verifyDialog === 'unverify' ? t('clan.unverifyMember') : t('clan.verifyMember')}
        footer={
          <>
            <DialogButton
              variant="green"
              onPress={() => void submitVerify()}
              disabled={busy || verifyNick.trim() === ''}
            >
              {t('dialog.accept')}
            </DialogButton>
            <DialogButton variant="default" onPress={() => setVerifyDialog(null)}>
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <TextInput
          value={verifyNick}
          onChangeText={setVerifyNick}
          placeholder={t('clan.enterNick')}
          placeholderTextColor="rgba(0,0,0,0.38)"
          maxLength={32}
          autoCapitalize="none"
          autoCorrect={false}
          className="w-full rounded px-3 text-base"
          style={{
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.12)',
            color: 'rgba(0,0,0,0.87)',
            paddingVertical: 8,
          }}
        />
      </Dialog>
    </View>
  );
}

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
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useThemeColors } from '@hooks/useThemeColors';
import { clanPolicyLabel } from '@ola/shared/lib';
import { CLAN_ROLE, CLAN_POLICY_OPTION_ORDER } from '@ola/shared/constants';
import { useClanManage } from '@ola/shared/stores/clan/useClanManage';

const editIcon = require('@assets/icons/me/ic_action_edit.png');

interface ClanManageScreenProps {
  clanId: string;
  onClose: () => void;
  onOpenMembers: (clanId: string) => void;
  onOpenBans: (clanId: string) => void;
}


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
      <Text className="text-xs text-ola-ink-soft">
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
            <Image source={editIcon} style={{ width: 16, height: 16, tintColor: '#ffffff' }} resizeMode="contain" />
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
  const colors = useThemeColors();
  const {
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
  } = useClanManage(clanId);

  const policyOptions: ListOption[] = CLAN_POLICY_OPTION_ORDER.map((policy) => ({
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
          <ActivityIndicator color={colors.primary} size="large" />
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
              onEdit={() => openRoleDialog(CLAN_ROLE.deputy)}
            />
            {divider}
            <ManageRow
              label={t('clan.roleAmbassador')}
              value={clan.ambassador?.username ?? ''}
              emptyText={t('clan.none')}
              editable
              onEdit={() => openRoleDialog(CLAN_ROLE.ambassador)}
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
              <Text className="flex-1 text-sm text-ola-ink">
                {t('clan.memberPublicPost')}
              </Text>
              <Switch
                value={clan.memberPublicPost}
                trackColor={{ true: colors.primary }}
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
              <Text className="text-sm text-ola-ink">
                {t('clan.members')}
              </Text>
              <Text className="text-sm text-ola-ink-soft">
                {clan.memberCount.toLocaleString()}
              </Text>
            </Pressable>
            {divider}
            <Pressable
              onPress={() => onOpenBans(clan.id)}
              className="flex-row items-center justify-between px-4 py-3 active:bg-black/5"
            >
              <Text className="text-sm text-ola-ink">
                {t('clan.banList')}
              </Text>
              <Text className="text-sm text-ola-ink-soft">
                ›
              </Text>
            </Pressable>
          </View>
        </ScrollView>
      )}

      <Dialog
        visible={roleDialog != null}
        onClose={() => setRoleDialog(null)}
        title={roleDialog === CLAN_ROLE.deputy ? t('clan.roleDeputy') : t('clan.roleAmbassador')}
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
            : revokeRole.role === CLAN_ROLE.deputy
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

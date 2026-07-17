import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  RefreshControl,
  ScrollView,
  Text,
  TextInput,
  View,
  type ImageSourcePropType,
} from 'react-native';
import { colorForName } from '@ola/shared/lib';
import { ClanService } from '@ola/shared/services';
import type { ClanCheckNameResult } from '@ola/shared/types';
import { useClanStore } from '@ola/shared/stores/clanStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { Avatar } from '@components/ui/Avatar';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { UserProfileScreen } from '@screens/profile/UserProfileScreen';
import {
  CLAN_HANDLE_PATTERN,
  CLAN_ROLE_ICONS,
  clanErrorText,
  clanRoleLabel,
  normalizeClanHandle,
} from '@lib/clanHelpers';

const addIcon = require('@assets/icons/clan/ic_action_add.png');
const memberIcon = require('@assets/icons/clan/ic_clan_member.png');
const visitIcon = require('@assets/icons/clan/ic_clan_visit.png');

interface ClanHomeScreenProps {
  onClose: () => void;
  onOpenClan: (handle: string) => void;
}

function PreviewRow({
  icon,
  text,
  onPress,
}: {
  icon: ImageSourcePropType;
  text: string;
  onPress?: () => void;
}) {
  const content = (
    <>
      <Image source={icon} style={{ width: 17, height: 15 }} resizeMode="contain" />
      <Text className="text-xs" style={{ color: '#636363' }}>
        {text}
      </Text>
    </>
  );
  if (onPress == null) {
    return <View className="mt-1 flex-row items-center gap-1">{content}</View>;
  }
  return (
    <Pressable onPress={onPress} className="mt-1 flex-row items-center gap-1">
      {content}
    </Pressable>
  );
}

export function ClanHomeScreen({ onClose, onOpenClan }: ClanHomeScreenProps) {
  const { t, i18n } = useTranslation();
  const myClans = useClanStore((s) => s.myClans);
  const mineLoading = useClanStore((s) => s.mineLoading);
  const ensureMine = useClanStore((s) => s.ensureMine);
  const refreshMine = useClanStore((s) => s.refreshMine);
  const pushToast = useToastStore((s) => s.push);
  const [refreshing, setRefreshing] = useState(false);

  const onRefresh = useCallback(() => {
    setRefreshing(true);
    void refreshMine().finally(() => setRefreshing(false));
  }, [refreshMine]);

  const [createOpen, setCreateOpen] = useState(false);
  const [name, setName] = useState('');
  const [checking, setChecking] = useState(false);
  const [result, setResult] = useState<ClanCheckNameResult | null>(null);
  const [freshCheck, setFreshCheck] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [creating, setCreating] = useState(false);
  const [profileTarget, setProfileTarget] = useState<string | null>(null);

  useEffect(() => {
    void ensureMine();
  }, [ensureMine]);

  function closeCreate() {
    setCreateOpen(false);
    setName('');
    setResult(null);
    setFreshCheck(false);
  }

  function handleNameChange(value: string) {
    setName(value);
    setFreshCheck(false);
  }

  async function check() {
    if (checking) return;
    const handle = normalizeClanHandle(name);
    if (!CLAN_HANDLE_PATTERN.test(handle)) {
      pushToast('error', t('clan.nameHint'));
      return;
    }
    setChecking(true);
    try {
      const checked = await ClanService.checkName(handle);
      setResult(checked);
      setFreshCheck(true);
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setChecking(false);
    }
  }

  function openClan(handle: string) {
    closeCreate();
    onOpenClan(handle);
  }

  async function create() {
    if (result == null || creating) return;
    setCreating(true);
    try {
      const clan = await ClanService.create({ name: result.name });
      pushToast('success', t('clan.createSuccess', { name: clan.handle }));
      void useClanStore.getState().refreshMine();
      openClan(clan.handle);
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setCreating(false);
      setConfirmOpen(false);
    }
  }

  const takenVisible =
    result != null && !result.available && normalizeClanHandle(name) === result.name;
  const availableVisible = result != null && result.available && freshCheck;
  const preview = takenVisible ? result.clan : undefined;

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader
        title={t('clan.title')}
        onBack={onClose}
        right={
          <Pressable
            onPress={() => setCreateOpen(true)}
            className="mr-1 h-8 flex-row items-center gap-1 rounded-full bg-white/15 px-2.5 active:bg-white/25"
          >
            <Image source={addIcon} style={{ width: 18, height: 18 }} resizeMode="contain" />
            <Text className="text-sm text-white">{t('clan.createShort')}</Text>
          </Pressable>
        }
      />

      <ScrollView
        className="flex-1 p-2"
        refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
      >
        <Text className="px-1 text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {t('clan.myClans')}
        </Text>
        {mineLoading && myClans.length === 0 ? (
          <ActivityIndicator className="py-6" color="#7cb342" />
        ) : myClans.length === 0 ? (
          <Text className="px-1 py-4 text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
            {t('clan.noClans')}
          </Text>
        ) : (
          <View
            className="mt-2 overflow-hidden rounded-md bg-white"
            style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
          >
            {myClans.map((clan, index) => (
              <Pressable
                key={clan.id}
                onPress={() => onOpenClan(clan.handle)}
                className="flex-row items-center gap-3 px-4 py-3 active:bg-black/5"
                style={
                  index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' } : undefined
                }
              >
                <Avatar
                  name={clan.handle}
                  uri={clan.avatar !== '' ? clan.avatar : undefined}
                  color={colorForName(clan.handle)}
                  size={40}
                  rounded={false}
                />
                <View className="min-w-0 flex-1">
                  <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                    #{clan.handle}
                  </Text>
                  <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                    {clanRoleLabel(clan.myRole ?? 'member')} ·{' '}
                    {t('clan.membersCount', { count: clan.memberCount })}
                  </Text>
                </View>
              </Pressable>
            ))}
          </View>
        )}
      </ScrollView>

      <Dialog
        visible={createOpen}
        onClose={closeCreate}
        title={t('clan.create')}
        footer={
          <>
            {availableVisible && (
              <DialogButton
                variant="green"
                onPress={() => setConfirmOpen(true)}
                disabled={creating}
              >
                {t('clan.create')}
              </DialogButton>
            )}
            <DialogButton variant="default" onPress={closeCreate}>
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <View className="flex-row items-center gap-2">
          <TextInput
            value={name}
            onChangeText={handleNameChange}
            onSubmitEditing={() => void check()}
            placeholder={t('clan.searchPlaceholder')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            autoCapitalize="none"
            autoCorrect={false}
            className="min-w-0 flex-1 rounded px-3 text-base"
            style={{
              borderWidth: 1,
              borderColor: '#7cb342',
              color: 'rgba(0,0,0,0.87)',
              paddingVertical: 10,
            }}
          />
          <Pressable
            onPress={() => void check()}
            disabled={checking}
            className="shrink-0 rounded-sm bg-white px-3 py-2 active:bg-black/5"
            style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
          >
            {checking ? (
              <ActivityIndicator size="small" color="#7cb342" />
            ) : (
              <Text className="text-sm" style={{ color: '#4c4c4c' }}>
                {t('clan.validate')}
              </Text>
            )}
          </Pressable>
        </View>
        <Text className="mt-2 text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('clan.nameHint')}
        </Text>

        {takenVisible && (
          <Text className="mt-2 text-xs font-bold italic" style={{ color: '#e34545' }}>
            {t('clan.nameTaken', { name: result.name })}
          </Text>
        )}
        {availableVisible && (
          <Text className="mt-2 text-xs font-bold italic" style={{ color: '#1d4ed8' }}>
            {t('clan.nameAvailable')}
          </Text>
        )}

        {preview != null && (
          <View
            className="mt-3 rounded-md bg-white p-4"
            style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
          >
            <Text className="text-center text-sm font-bold" style={{ color: 'rgba(0,0,0,0.87)' }}>
              #{preview.handle}
            </Text>
            {preview.owner != null && preview.owner !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.owner}
                text={preview.owner}
                onPress={() => setProfileTarget(preview.owner!)}
              />
            )}
            {preview.deputy != null && preview.deputy !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.deputy}
                text={preview.deputy}
                onPress={() => setProfileTarget(preview.deputy!)}
              />
            )}
            {preview.ambassador != null && preview.ambassador !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.ambassador}
                text={preview.ambassador}
                onPress={() => setProfileTarget(preview.ambassador!)}
              />
            )}
            <PreviewRow
              icon={memberIcon}
              text={t('clan.membersCount', { count: preview.memberCount })}
            />
            <PreviewRow icon={visitIcon} text={t('clan.visits', { count: preview.visitCount })} />
            <Pressable
              onPress={() => openClan(preview.handle)}
              className="mt-4 items-center rounded-sm bg-white py-2 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Text className="text-sm" style={{ color: '#4c4c4c' }}>
                {t('clan.openClan')}
              </Text>
            </Pressable>
          </View>
        )}
      </Dialog>

      <ConfirmDialog
        visible={confirmOpen}
        title={t('clan.create')}
        message={t('clan.createConfirm', {
          cost: (result?.cost ?? 0).toLocaleString(),
          name: result?.name ?? '',
        })}
        confirmLabel={creating ? '...' : t('clan.create')}
        cancelLabel={t('dialog.cancel')}
        onCancel={() => setConfirmOpen(false)}
        onConfirm={() => void create()}
      />

      {profileTarget != null && (
        <UserProfileScreen
          key={profileTarget}
          username={profileTarget}
          language={i18n.language}
          onClose={() => setProfileTarget(null)}
          onOpenProfile={(nick) => setProfileTarget(nick)}
        />
      )}
    </View>
  );
}

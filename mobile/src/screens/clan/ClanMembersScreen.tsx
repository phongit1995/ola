import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { colorForName } from '@ola/shared/lib';
import { ClanService } from '@ola/shared/services';
import type { Clan, ClanMember } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { Avatar } from '@components/ui/Avatar';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useThemeColors } from '@hooks/useThemeColors';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { CLAN_ROLE_ICONS, clanErrorText, clanRoleLabel, isClanStaff } from '@lib/clanHelpers';
import { MEMBERS_PAGE_SIZE } from './constants';
import { CLAN_ROLE } from '@ola/shared/constants';

interface ClanMembersScreenProps {
  clanId: string;
  onClose: () => void;
}

export function ClanMembersScreen({ clanId, onClose }: ClanMembersScreenProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const pushToast = useToastStore((s) => s.push);
  const [clan, setClan] = useState<Clan | null>(null);
  const [members, setMembers] = useState<ClanMember[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [menuTarget, setMenuTarget] = useState<ClanMember | null>(null);
  const [banTarget, setBanTarget] = useState<ClanMember | null>(null);

  function openProfile(nick: string) {
    navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick });
  }

  const fetchFirst = useCallback(async () => {
    const [clanResult, memberResult] = await Promise.all([
      ClanService.get(clanId),
      ClanService.members(clanId, { limit: MEMBERS_PAGE_SIZE, offset: 0 }),
    ]);
    setClan(clanResult);
    setMembers(memberResult.items);
    setTotal(memberResult.total);
  }, [clanId]);

  const loadFirst = useCallback(async () => {
    setLoading(true);
    try {
      await fetchFirst();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setLoading(false);
    }
  }, [fetchFirst, pushToast]);

  const onRefresh = useCallback(() => {
    setRefreshing(true);
    fetchFirst()
      .catch((error) => pushToast('error', clanErrorText(error)))
      .finally(() => setRefreshing(false));
  }, [fetchFirst, pushToast]);

  useEffect(() => {
    void loadFirst();
  }, [loadFirst]);

  async function loadMore() {
    if (loadingMore || loading || members.length >= total) return;
    setLoadingMore(true);
    try {
      const result = await ClanService.members(clanId, {
        limit: MEMBERS_PAGE_SIZE,
        offset: members.length,
      });
      setMembers((current) => [...current, ...result.items]);
      setTotal(result.total);
    } catch (error) {
      pushToast('error', clanErrorText(error));
    } finally {
      setLoadingMore(false);
    }
  }

  async function toggleVerify(member: ClanMember) {
    if (member.user == null) return;
    try {
      if (member.verified) {
        await ClanService.unverify(clanId, member.user.username);
        pushToast(
          'success',
          t('clan.unverifySuccess', { username: member.user.username, name: clan?.handle ?? '' })
        );
      } else {
        await ClanService.verify(clanId, member.user.username);
        pushToast(
          'success',
          t('clan.verifySuccess', { username: member.user.username, name: clan?.handle ?? '' })
        );
      }
      await loadFirst();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  async function banMember() {
    const target = banTarget;
    setBanTarget(null);
    if (target?.user == null) return;
    try {
      await ClanService.ban(clanId, target.user.username);
      pushToast('success', t('clan.banSuccess', { username: target.user.username }));
      await loadFirst();
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  const staff = clan != null && isClanStaff(clan);
  const owner = clan?.myRole === CLAN_ROLE.owner;
  const bannable = (member: ClanMember) => member.role === CLAN_ROLE.member;

  const menuOptions: ListOption[] =
    menuTarget == null
      ? []
      : [
          ...(owner
            ? [
                {
                  key: 'verify',
                  label: menuTarget.verified ? t('clan.unverifyMember') : t('clan.verifyMember'),
                  onSelect: () => void toggleVerify(menuTarget),
                },
              ]
            : []),
          ...(bannable(menuTarget)
            ? [
                {
                  key: 'ban',
                  label: t('clan.banUser'),
                  danger: true,
                  onSelect: () => setBanTarget(menuTarget),
                },
              ]
            : []),
        ];

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={t('clan.members')} onBack={onClose} />
      {loading ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color={colors.primary} size="large" />
        </View>
      ) : (
        <FlashList
          data={members}
          keyExtractor={(item, index) => `${item.user?.id ?? ''}-${index}`}
          contentContainerClassName="p-2"
          refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
          onEndReached={() => void loadMore()}
          onEndReachedThreshold={0.4}
          ListFooterComponent={
            loadingMore ? <ActivityIndicator className="my-3" color={colors.primary} /> : null
          }
          renderItem={({ item, index }) => {
            const username = item.user?.username ?? '';
            const fullName = item.user?.fullName ?? '';
            return (
              <View
                className="flex-row items-center gap-3 bg-white px-4 py-3"
                style={
                  index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' } : undefined
                }
              >
                <Pressable
                  onPress={() => username !== '' && openProfile(username)}
                  className="min-w-0 flex-1 flex-row items-center gap-3"
                >
                  <Avatar
                    name={username}
                    uri={item.user?.avatar !== '' ? item.user?.avatar : undefined}
                    color={colorForName(username)}
                    size={40}
                  />
                  <View className="min-w-0 flex-1">
                    <View className="flex-row items-center gap-1.5">
                      <Text
                        numberOfLines={1}
                        className="text-sm text-ola-ink"
                      >
                        {username}
                        {fullName !== '' && fullName !== username && (
                          <Text className="text-ola-ink-soft"> · {fullName}</Text>
                        )}
                      </Text>
                      {item.role !== 'member' && (
                        <Image
                          source={CLAN_ROLE_ICONS[item.role]}
                          style={{ width: 17, height: 15 }}
                          resizeMode="contain"
                        />
                      )}
                    </View>
                    <Text className="text-xs text-ola-ink-soft">
                      {clanRoleLabel(item.role)}
                      {item.verified ? ` · ${t('clan.verified')}` : ''}
                    </Text>
                  </View>
                </Pressable>
                {staff && item.role !== 'owner' && (owner || bannable(item)) && (
                  <Pressable onPress={() => setMenuTarget(item)} className="px-2 py-1" hitSlop={6}>
                    <Text className="text-lg text-ola-ink-soft">
                      ⋯
                    </Text>
                  </Pressable>
                )}
              </View>
            );
          }}
        />
      )}

      <ListOptionDialog
        visible={menuTarget != null}
        title={menuTarget?.user?.username != null ? `@${menuTarget.user.username}` : ''}
        options={menuOptions}
        onClose={() => setMenuTarget(null)}
      />

      <ConfirmDialog
        visible={banTarget != null}
        danger
        title={t('clan.banUser')}
        message={t('clan.banConfirm', { username: banTarget?.user?.username ?? '' })}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        onCancel={() => setBanTarget(null)}
        onConfirm={() => void banMember()}
      />
    </View>
  );
}

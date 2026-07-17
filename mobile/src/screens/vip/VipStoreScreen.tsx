import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FlatList, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { VipService } from '@ola/shared/services';
import { formatDateDMY, vipName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { VipIconInstance, VipStoreResult } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { VipIconImage } from './components/VipIconImage';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { DIVIDER } from '@constants';

const PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;
const VIP_PAGE_SIZE = 100;
const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';

interface VipRowProps {
  icon: VipIconInstance;
  onSelect: () => void;
}

function VipRow({ icon, onSelect }: VipRowProps) {
  const { t } = useTranslation();
  const stateKey =
    icon.isUsing ? 'vip.stateInUse' : icon.isLocked ? 'vip.stateLocked' : 'vip.stateAvailable';
  return (
    <Pressable
      onPress={onSelect}
      className="active:bg-black/5"
      style={{ height: 72, backgroundColor: 'rgba(255,255,255,0.8)' }}
    >
      <View className="flex-1 flex-row items-center px-4">
        <VipIconImage typeId={icon.typeId} size={40} rounded />
        <View className="ml-2 justify-center">
          <Text className="text-base" style={{ color: BODY }}>{vipName(icon.typeId)}</Text>
          <Text className="mt-0.5 text-xs" style={{ color: MUTED }}>{t(stateKey)}</Text>
        </View>
      </View>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />
    </Pressable>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.VipStore>;

export function VipStoreScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);

  const [store, setStore] = useState<VipStoreResult | null>(null);
  const [items, setItems] = useState<VipIconInstance[]>([]);
  const [loadedAt, setLoadedAt] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [busy, setBusy] = useState(false);
  const [privacyOpen, setPrivacyOpen] = useState(false);
  const [menuIcon, setMenuIcon] = useState<VipIconInstance | null>(null);
  const [useTarget, setUseTarget] = useState<VipIconInstance | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<VipIconInstance | null>(null);

  const loadPage = useCallback(async (offset: number) => {
    const res = await VipService.store({ limit: VIP_PAGE_SIZE, offset });
    setStore(res);
    setLoadedAt(Date.now());
    setItems((prev) => (offset === 0 ? res.items : [...prev, ...res.items]));
    return res;
  }, []);

  const reload = useCallback(() => loadPage(0), [loadPage]);

  useEffect(() => {
    let active = true;
    loadPage(0)
      .catch(() => {
        if (active) push('info', t('common.error'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [loadPage, push, t]);

  const total = store?.total ?? 0;
  const hasMore = items.length < total;
  const usingIcon = items.find((icon) => icon.isUsing) ?? null;
  const privacy = (store?.privacy ?? 0) as 0 | 1 | 2;
  const remainingDays = store?.days ?? null;
  const vipEndTime = store?.vipEndTime ?? null;

  function loadMore() {
    if (loadingMore || loading || !hasMore) return;
    setLoadingMore(true);
    void loadPage(items.length).finally(() => setLoadingMore(false));
  }

  function buildDurationText(): string {
    if (vipEndTime != null) {
      const diffMs = new Date(vipEndTime).getTime() - loadedAt;
      if (Number.isNaN(diffMs)) {
        return remainingDays != null && remainingDays > 0
          ? t('vip.daysLeft', { count: remainingDays })
          : t('vip.noVip');
      }
      if (diffMs <= 0) return t('vip.expired');
      const ONE_DAY = 86_400_000;
      const ONE_HOUR = 3_600_000;
      const ONE_MINUTE = 60_000;
      if (diffMs >= ONE_DAY) return t('vip.daysLeft', { count: Math.ceil(diffMs / ONE_DAY) });
      const hours = Math.floor(diffMs / ONE_HOUR);
      const minutes = Math.floor((diffMs % ONE_HOUR) / ONE_MINUTE);
      if (hours >= 1) {
        return minutes > 0
          ? t('vip.hoursMinutesLeft', { hours, minutes })
          : t('vip.hoursLeft', { count: hours });
      }
      if (minutes >= 1) return t('vip.minutesLeft', { count: minutes });
      return t('vip.expiringSoon');
    }
    return remainingDays != null && remainingDays > 0
      ? t('vip.daysLeft', { count: remainingDays })
      : t('vip.noVip');
  }

  const durationText = buildDurationText();

  async function runAction(action: () => Promise<unknown>, successText: string, syncUser = false) {
    if (busy) return;
    setBusy(true);
    try {
      await action();
      await reload();
      if (syncUser) await refreshUser();
      push('success', successText);
    } catch {
      push('info', t('common.error'));
    } finally {
      setBusy(false);
    }
  }

  function changePrivacy(value: 0 | 1 | 2) {
    void runAction(() => VipService.setPrivacy(value), t('vip.privacyChanged'));
  }

  function confirmUse() {
    if (useTarget == null) return;
    const target = useTarget;
    setUseTarget(null);
    void runAction(
      () => VipService.activateIcon(target.instanceId),
      t('vip.toastUsed', { name: vipName(target.typeId) }),
      true,
    );
  }

  function toggleLock(icon: VipIconInstance) {
    const willLock = !icon.isLocked;
    void runAction(
      () => (willLock ? VipService.lockIcon(icon.instanceId) : VipService.unlockIcon(icon.instanceId)),
      t(willLock ? 'vip.toastLocked' : 'vip.toastUnlocked', { name: vipName(icon.typeId) }),
    );
  }

  function confirmDelete() {
    if (deleteTarget == null) return;
    const target = deleteTarget;
    setDeleteTarget(null);
    void runAction(
      () => VipService.deleteIcon(target.instanceId),
      t('vip.toastDeleted', { name: vipName(target.typeId) }),
      true,
    );
  }

  function openBuy(mode: 'buy' | 'give' | 'extend') {
    navigation.navigate(ROOT_ROUTES.BuyVip, { mode });
  }

  function buildMenuOptions(icon: VipIconInstance): ListOption[] {
    const options: ListOption[] = [];
    if (!icon.isUsing) {
      options.push({ key: 'use', label: t('vip.actionUse'), onSelect: () => setUseTarget(icon) });
    }
    options.push({
      key: 'lock',
      label: icon.isLocked ? t('vip.actionUnlock') : t('vip.actionLock'),
      onSelect: () => toggleLock(icon),
    });
    if (!icon.isLocked) {
      options.push({ key: 'transfer', label: t('vip.actionTransfer'), onSelect: () => openBuy('give') });
      options.push({
        key: 'delete',
        label: t('vip.actionDelete'),
        danger: true,
        onSelect: () => setDeleteTarget(icon),
      });
    }
    return options;
  }

  const privacyOptions: ListOption[] = PRIVACY_KEYS.map((key, index) => ({
    key,
    label: t(`vip.${key}`),
    onSelect: () => changePrivacy(index as 0 | 1 | 2),
  }));

  const listHeader = (
    <View style={{ backgroundColor: 'rgba(255,255,255,0.8)' }}>
      <Text className="px-4 pt-4 text-xs" style={{ color: MUTED }}>{t('vip.usingIcon')}</Text>
      <View className="mt-1 flex-row items-center px-4" style={{ height: 72 }}>
        {usingIcon != null ? (
          <VipIconImage typeId={usingIcon.typeId} size={40} rounded />
        ) : (
          <View className="rounded" style={{ width: 40, height: 40, backgroundColor: DIVIDER }} />
        )}
        <View className="ml-2 justify-center">
          <Text className="text-base" style={{ color: BODY }}>
            {usingIcon != null ? vipName(usingIcon.typeId) : t('vip.empty')}
          </Text>
          <Text className="mt-0.5 text-xs" style={{ color: MUTED }}>
            {usingIcon != null
              ? vipEndTime != null
                ? formatDateDMY(vipEndTime)
                : t('vip.stateInUse')
              : t('vip.empty')}
          </Text>
        </View>
      </View>

      <Pressable
        onPress={() => setPrivacyOpen(true)}
        className="w-full flex-row items-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="flex-1 text-base" style={{ color: BODY }}>{t('vip.whoCanSee')}</Text>
        <Text className="mx-2 text-xs" style={{ color: MUTED }}>{t(`vip.${PRIVACY_KEYS[privacy]}`)}</Text>
        <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.4)' }}>›</Text>
      </Pressable>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable
        onPress={() => openBuy('buy')}
        className="w-full justify-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="text-base" style={{ color: BODY }}>{t('vip.buyVip')}</Text>
      </Pressable>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable
        onPress={() => openBuy('extend')}
        className="w-full justify-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="text-base" style={{ color: BODY }}>{t('vip.extendVip')}</Text>
      </Pressable>

      <View className="items-center justify-center" style={{ height: 36, backgroundColor: '#d5d5d5' }}>
        <Text className="text-base text-white">{t('vip.collection')}</Text>
      </View>
    </View>
  );

  const listEmpty = (
    <View className="items-center justify-center" style={{ height: 96 }}>
      <Text className="text-sm" style={{ color: MUTED }}>
        {loading ? t('common.loading') : t('vip.empty')}
      </Text>
    </View>
  );

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('vip.title')} onBack={() => navigation.goBack()} />

      <FlatList
        className="flex-1"
        data={items}
        keyExtractor={(item) => item.instanceId}
        renderItem={({ item }) => <VipRow icon={item} onSelect={() => setMenuIcon(item)} />}
        ListHeaderComponent={listHeader}
        ListEmptyComponent={listEmpty}
        ListFooterComponent={
          loadingMore ? (
            <View className="items-center justify-center" style={{ height: 48 }}>
              <Text className="text-sm" style={{ color: MUTED }}>{t('common.loading')}</Text>
            </View>
          ) : null
        }
        onEndReachedThreshold={0.4}
        onEndReached={loadMore}
      />

      <View
        className="flex-row items-center gap-2 bg-white px-2"
        style={{
          height: 48 + insets.bottom,
          paddingBottom: insets.bottom,
          borderTopWidth: 1,
          borderTopColor: DIVIDER,
        }}
      >
        <Text className="text-xs" style={{ color: MUTED }}>{t('vip.duration')}</Text>
        <Text className="flex-1 text-xl font-bold" style={{ color: BODY }} numberOfLines={1}>
          {durationText}
        </Text>
        <Pressable
          onPress={() => openBuy('extend')}
          className="rounded border border-ola-primary-dark bg-ola-button px-4 py-1.5 active:opacity-90"
        >
          <Text className="text-sm font-medium text-white">{t('vip.extendVip')}</Text>
        </Pressable>
      </View>

      <ListOptionDialog
        visible={privacyOpen}
        title={t('vip.privacyTitle')}
        options={privacyOptions}
        onClose={() => setPrivacyOpen(false)}
      />

      <ListOptionDialog
        visible={menuIcon != null}
        title={menuIcon != null ? vipName(menuIcon.typeId) : ''}
        options={menuIcon != null ? buildMenuOptions(menuIcon) : []}
        onClose={() => setMenuIcon(null)}
      />

      <ConfirmDialog
        visible={useTarget != null}
        title={t('vip.confirmUseTitle')}
        message={t('vip.confirmUse', { name: useTarget != null ? vipName(useTarget.typeId) : '' })}
        confirmLabel={t('vip.confirm')}
        cancelLabel={t('vip.cancel')}
        onConfirm={confirmUse}
        onCancel={() => setUseTarget(null)}
      />

      <ConfirmDialog
        visible={deleteTarget != null}
        danger
        title={t('vip.confirmDeleteTitle')}
        message={t('vip.confirmDelete', {
          name: deleteTarget != null ? vipName(deleteTarget.typeId) : '',
        })}
        confirmLabel={t('vip.actionDelete')}
        cancelLabel={t('vip.cancel')}
        onConfirm={confirmDelete}
        onCancel={() => setDeleteTarget(null)}
      />
    </View>
  );
}

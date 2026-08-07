import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { TFunction } from 'i18next';
import { VipService } from '@ola/shared/services';
import { vipName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { VipIconInstance, VipStoreResult } from '@ola/shared/types';
import type { ListOption } from '@components/ui/ListOptionDialog';
import { PRIVACY_KEYS, VIP_PAGE_SIZE } from './constants';

function buildDurationText(
  t: TFunction,
  vipEndTime: string | null,
  remainingDays: number | null,
  loadedAt: number,
): string {
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

export function useVipStoreScreen() {
  const { t } = useTranslation();
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
  const [selectMode, setSelectMode] = useState(false);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [batchDeleteOpen, setBatchDeleteOpen] = useState(false);

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

  const durationText = buildDurationText(t, vipEndTime, remainingDays, loadedAt);

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
      () =>
        willLock ? VipService.lockIcon(icon.instanceId) : VipService.unlockIcon(icon.instanceId),
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

  function isSelectable(icon: VipIconInstance): boolean {
    return !icon.isLocked && !icon.isUsing;
  }

  function toggleSelect(id: string) {
    setSelectedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  function exitSelectMode() {
    setSelectMode(false);
    setSelectedIds(new Set());
  }

  function confirmBatchDelete() {
    const ids = [...selectedIds];
    setBatchDeleteOpen(false);
    if (ids.length === 0) return;
    exitSelectMode();
    void runAction(
      () => VipService.batchDeleteIcons(ids),
      t('vip.toastDeletedMany', { count: ids.length }),
      true,
    );
  }

  function buildMenuOptions(icon: VipIconInstance, onTransfer: () => void): ListOption[] {
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
      options.push({ key: 'transfer', label: t('vip.actionTransfer'), onSelect: onTransfer });
      options.push({
        key: 'delete',
        label: t('vip.actionDelete'),
        danger: true,
        onSelect: () => setDeleteTarget(icon),
      });
    }
    return options;
  }

  function changePrivacyOptions(): ListOption[] {
    return PRIVACY_KEYS.map((key, index) => ({
      key,
      label: t(`vip.${key}`),
      onSelect: () => changePrivacy(index as 0 | 1 | 2),
    }));
  }

  return {
    items,
    loading,
    loadingMore,
    loadMore,
    usingIcon,
    privacy,
    vipEndTime,
    durationText,
    privacyOpen,
    setPrivacyOpen,
    menuIcon,
    setMenuIcon,
    useTarget,
    setUseTarget,
    deleteTarget,
    setDeleteTarget,
    confirmUse,
    confirmDelete,
    buildMenuOptions,
    changePrivacyOptions,
    busy,
    selectMode,
    setSelectMode,
    selectedIds,
    isSelectable,
    toggleSelect,
    exitSelectMode,
    batchDeleteOpen,
    setBatchDeleteOpen,
    confirmBatchDelete,
  };
}

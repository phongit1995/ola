import { useCallback, useEffect, useState } from 'react';
import i18n from 'i18next';
import { VIP_PRIVACY_KEYS } from '../../constants/settings';
import { VIP_STORE_PAGE_SIZE } from '../../constants/vip';
import { isVipIconTransferable } from '../../lib/giftCode';
import { toast } from '../../lib/toast';
import { vipName } from '../../lib/vip';
import { vipRemainingText } from '../../lib/vipPurchase';
import { VipService } from '../../services/vip.service';
import type { VipIconInstance, VipStoreResult } from '../../types/api/vip.type';
import type { MenuOption } from '../../types/client/menu.type';
import { useAuthStore } from '../auth/authStore';

export function useVipStore() {
  const t = i18n.t;
  const refreshUser = useAuthStore((s) => s.refreshUser);

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
    const res = await VipService.store({ limit: VIP_STORE_PAGE_SIZE, offset });
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
        if (active) toast.info(t('common.error'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [loadPage, t]);

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

  const durationText = vipRemainingText(t, vipEndTime, remainingDays, loadedAt);

  async function runAction(action: () => Promise<unknown>, successText: string, syncUser = false) {
    if (busy) return;
    setBusy(true);
    try {
      await action();
      await reload();
      if (syncUser) await refreshUser();
      toast.success(successText);
    } catch {
      toast.info(t('common.error'));
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

  function buildMenuOptions(icon: VipIconInstance, onTransfer: () => void): MenuOption[] {
    const options: MenuOption[] = [];
    if (!icon.isUsing) {
      options.push({ key: 'use', label: t('vip.actionUse'), onSelect: () => setUseTarget(icon) });
    }
    options.push({
      key: 'lock',
      label: icon.isLocked ? t('vip.actionUnlock') : t('vip.actionLock'),
      onSelect: () => toggleLock(icon),
    });
    if (!icon.isLocked) {
      if (isVipIconTransferable(icon)) {
        options.push({ key: 'transfer', label: t('vip.actionTransfer'), onSelect: onTransfer });
      }
      options.push({
        key: 'delete',
        label: t('vip.actionDelete'),
        danger: true,
        onSelect: () => setDeleteTarget(icon),
      });
    }
    return options;
  }

  function privacyOptions(): MenuOption[] {
    return VIP_PRIVACY_KEYS.map((key, index) => ({
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
    privacyOptions,
    hasMore,
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

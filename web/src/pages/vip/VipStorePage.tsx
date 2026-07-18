import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  VipIcon,
  type ListOption,
} from '@components';
import { formatDateDMY, vipName } from '@lib';
import { VipService } from '@services';
import type { VipIconInstance, VipStoreResult } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { VipHistoryDialog } from './VipHistoryDialog';

const PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;
const VIP_PAGE_SIZE = 100;

interface VipRowProps {
  icon: VipIconInstance;
  onSelect: () => void;
}

function VipRow({ icon, onSelect }: VipRowProps) {
  const { t } = useTranslation();
  const stateKey =
    icon.isUsing ? 'vip.stateInUse' : icon.isLocked ? 'vip.stateLocked' : 'vip.stateAvailable';
  return (
    <button
      type="button"
      onClick={onSelect}
      className="flex h-[72px] w-full flex-col bg-white/80 text-left active:bg-black/5"
    >
      <div className="flex flex-1 items-center px-4">
        <VipIcon typeId={icon.typeId} size={40} rounded alt={vipName(icon.typeId)} />
        <div className="ml-2 flex flex-col justify-center">
          <span className="text-base text-black/87">{vipName(icon.typeId)}</span>
          <span className="mt-0.5 text-xs text-black/54">{t(stateKey)}</span>
        </div>
      </div>
      <div className="mx-4 h-px bg-black/12" />
    </button>
  );
}

export function VipStorePage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const pushOverlay = useAppOverlayStore((s) => s.push);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [store, setStore] = useState<VipStoreResult | null>(null);
  const [items, setItems] = useState<VipIconInstance[]>([]);
  const [loadedAt, setLoadedAt] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [busy, setBusy] = useState(false);
  const [privacyOpen, setPrivacyOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);
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
    // eslint-disable-next-line react-hooks/set-state-in-effect -- fetch bất đồng bộ: setState chạy sau await, không gây cascading render
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

  function handleScroll(event: React.UIEvent<HTMLDivElement>) {
    if (loadingMore || loading || !hasMore) return;
    const el = event.currentTarget;
    if (el.scrollHeight - el.scrollTop - el.clientHeight > 300) return;
    setLoadingMore(true);
    void loadPage(items.length).finally(() => setLoadingMore(false));
  }
  const remainingDays = store?.days ?? null;
  const vipEndTime = store?.vipEndTime ?? null;

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
    if (!useTarget) return;
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
    if (!deleteTarget) return;
    const target = deleteTarget;
    setDeleteTarget(null);
    void runAction(
      () => VipService.deleteIcon(target.instanceId),
      t('vip.toastDeleted', { name: vipName(target.typeId) }),
      true,
    );
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
      options.push({
        key: 'transfer',
        label: t('vip.actionTransfer'),
        onSelect: () => pushOverlay('vipBuy', 'give'),
      });
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

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('vip.title')} onBack={onClose}>
        <button
          type="button"
          onClick={() => setHistoryOpen(true)}
          className="rounded px-2 py-1 text-sm font-medium text-white hover:bg-white/15"
        >
          {t('vip.history')}
        </button>
      </ScreenHeader>

      <div className="flex-1 overflow-y-auto" onScroll={handleScroll}>
        <div className="bg-white/80">
          <div className="px-4 pt-4 text-xs text-black/54">{t('vip.usingIcon')}</div>
          <div className="mt-1 flex h-[72px] flex-col">
            <div className="flex flex-1 items-center px-4">
              {usingIcon ? (
                <VipIcon typeId={usingIcon.typeId} size={40} rounded alt={vipName(usingIcon.typeId)} />
              ) : (
                <span className="shrink-0 rounded bg-black/12" style={{ width: 40, height: 40 }} />
              )}
              <div className="ml-2 flex flex-col justify-center">
                <span className="text-base text-black/87">
                  {usingIcon ? vipName(usingIcon.typeId) : t('vip.empty')}
                </span>
                <span className="mt-0.5 text-xs text-black/54">
                  {usingIcon
                    ? vipEndTime
                      ? formatDateDMY(vipEndTime)
                      : t('vip.stateInUse')
                    : t('vip.empty')}
                </span>
              </div>
            </div>
          </div>

          <button
            type="button"
            onClick={() => setPrivacyOpen(true)}
            className="flex min-h-12 w-full items-center px-4 text-left active:bg-black/5"
          >
            <span className="flex-1 text-base text-black/87">{t('vip.whoCanSee')}</span>
            <span className="mx-2 text-xs text-black/54">{t(`vip.${PRIVACY_KEYS[privacy]}`)}</span>
            <svg viewBox="0 0 24 24" className="h-5 w-5 text-black/40" fill="currentColor" aria-hidden="true">
              <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
            </svg>
          </button>
          <div className="mx-4 h-px bg-black/12" />

          <button
            type="button"
            onClick={() => pushOverlay('vipBuy', 'buy')}
            className="flex min-h-12 w-full items-center px-4 text-left text-base text-black/87 active:bg-black/5"
          >
            {t('vip.buyVip')}
          </button>
          <div className="mx-4 h-px bg-black/12" />

          <button
            type="button"
            onClick={() => pushOverlay('vipBuy', 'extend')}
            className="flex min-h-12 w-full items-center px-4 text-left text-base text-black/87 active:bg-black/5"
          >
            {t('vip.extendVip')}
          </button>

          <div className="flex h-9 items-center justify-center bg-[#d5d5d5] text-base text-white">
            {t('vip.collection')}
          </div>
        </div>

        {loading ? (
          <div className="flex h-24 items-center justify-center text-sm text-black/54">
            {t('common.loading')}
          </div>
        ) : items.length === 0 ? (
          <div className="flex h-24 items-center justify-center text-sm text-black/54">
            {t('vip.empty')}
          </div>
        ) : (
          items.map((icon) => (
            <VipRow key={icon.instanceId} icon={icon} onSelect={() => setMenuIcon(icon)} />
          ))
        )}
        {loadingMore && (
          <div className="flex h-12 items-center justify-center text-sm text-black/54">
            {t('common.loading')}
          </div>
        )}
      </div>

      <div className="flex h-12 shrink-0 items-center gap-2 border-t border-black/12 bg-white px-2">
        <span className="text-xs text-black/54">{t('vip.duration')}</span>
        <span className="flex-1 text-xl font-bold text-black/87">{durationText}</span>
        <button
          type="button"
          onClick={() => pushOverlay('vipBuy', 'extend')}
          className="rounded border border-ola-primary-dark bg-ola-button px-4 py-1.5 text-sm font-medium text-white"
        >
          {t('vip.extendVip')}
        </button>
      </div>

      <VipHistoryDialog open={historyOpen} onClose={() => setHistoryOpen(false)} />

      <ListOptionDialog
        open={privacyOpen}
        title={t('vip.privacyTitle')}
        options={privacyOptions}
        onClose={() => setPrivacyOpen(false)}
      />

      <ListOptionDialog
        open={menuIcon != null}
        title={menuIcon ? vipName(menuIcon.typeId) : ''}
        options={menuIcon ? buildMenuOptions(menuIcon) : []}
        onClose={() => setMenuIcon(null)}
      />

      <ConfirmDialog
        open={useTarget != null}
        title={t('vip.confirmUseTitle')}
        message={t('vip.confirmUse', { name: useTarget ? vipName(useTarget.typeId) : '' })}
        confirmLabel={t('vip.confirm')}
        cancelLabel={t('vip.cancel')}
        onConfirm={confirmUse}
        onCancel={() => setUseTarget(null)}
      />

      <ConfirmDialog
        open={deleteTarget != null}
        danger
        title={t('vip.confirmDeleteTitle')}
        message={t('vip.confirmDelete', { name: deleteTarget ? vipName(deleteTarget.typeId) : '' })}
        confirmLabel={t('vip.actionDelete')}
        cancelLabel={t('vip.cancel')}
        onConfirm={confirmDelete}
        onCancel={() => setDeleteTarget(null)}
      />
    </FullScreenOverlay>
  );
}

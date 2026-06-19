import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  type ListOption,
} from '@components';
import { VipService } from '@services';
import type { VipIconInstance, VipStoreResult } from '@app-types';
import { vipById, vipIconUrl } from './vipCatalog';

const PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;

function vipName(typeId: number): string {
  return vipById(typeId)?.name ?? `VIP ${typeId}`;
}

function VipIconImage({ typeId, size = 40 }: { typeId: number; size?: number }) {
  return (
    <img
      src={vipIconUrl(typeId)}
      alt={vipName(typeId)}
      width={size}
      height={size}
      className="shrink-0 rounded object-contain"
      style={{ width: size, height: size }}
    />
  );
}

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
        <VipIconImage typeId={icon.typeId} />
        <div className="ml-2 flex flex-col justify-center">
          <span className="text-base text-black/87">{vipName(icon.typeId)}</span>
          <span className="mt-0.5 text-xs text-black/54">{t(stateKey)}</span>
        </div>
      </div>
      <div className="mx-4 h-px bg-black/12" />
    </button>
  );
}

export function VipStorePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  const [store, setStore] = useState<VipStoreResult | null>(null);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [privacyOpen, setPrivacyOpen] = useState(false);
  const [menuIcon, setMenuIcon] = useState<VipIconInstance | null>(null);
  const [useTarget, setUseTarget] = useState<VipIconInstance | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<VipIconInstance | null>(null);

  const reload = useCallback(async () => {
    const res = await VipService.store();
    setStore(res);
  }, []);

  useEffect(() => {
    let active = true;
    VipService.store()
      .then((res) => {
        if (active) setStore(res);
      })
      .catch(() => {
        if (active) toast.info(t('common.error'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [t]);

  const items = store?.items ?? [];
  const usingIcon = items.find((icon) => icon.isUsing) ?? null;
  const privacy = (store?.privacy ?? 0) as 0 | 1 | 2;
  const remainingDays = store?.days ?? 0;
  const hasVip = usingIcon != null;
  const durationText = hasVip ? t('vip.daysLeft', { count: remainingDays }) : t('vip.noVip');

  async function runAction(action: () => Promise<unknown>, successText: string) {
    if (busy) return;
    setBusy(true);
    try {
      await action();
      await reload();
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
        onSelect: () => navigate(ROUTES.vipBuy, { state: { mode: 'give' } }),
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
      <ScreenHeader title={t('vip.title')} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto">
        <div className="bg-white/80">
          <div className="px-4 pt-4 text-xs text-black/54">{t('vip.usingIcon')}</div>
          <div className="mt-1 flex h-[72px] flex-col">
            <div className="flex flex-1 items-center px-4">
              {usingIcon ? (
                <VipIconImage typeId={usingIcon.typeId} />
              ) : (
                <span className="shrink-0 rounded bg-black/12" style={{ width: 40, height: 40 }} />
              )}
              <div className="ml-2 flex flex-col justify-center">
                <span className="text-base text-black/87">
                  {usingIcon ? vipName(usingIcon.typeId) : t('vip.empty')}
                </span>
                <span className="mt-0.5 text-xs text-black/54">
                  {usingIcon ? t('vip.stateInUse') : t('vip.empty')}
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
            onClick={() => navigate(ROUTES.vipBuy, { state: { mode: 'buy' } })}
            className="flex min-h-12 w-full items-center px-4 text-left text-base text-black/87 active:bg-black/5"
          >
            {t('vip.buyVip')}
          </button>
          <div className="mx-4 h-px bg-black/12" />

          <button
            type="button"
            onClick={() => navigate(ROUTES.vipBuy, { state: { mode: 'extend' } })}
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
      </div>

      <div className="flex h-12 shrink-0 items-center gap-2 border-t border-black/12 bg-white px-2">
        <span className="text-xs text-black/54">{t('vip.duration')}</span>
        <span className="flex-1 text-xl font-bold text-black/87">{durationText}</span>
        <button
          type="button"
          onClick={() => navigate(ROUTES.vipBuy, { state: { mode: 'extend' } })}
          className="rounded border border-ola-primary-dark bg-ola-button px-4 py-1.5 text-sm font-medium text-white"
        >
          {t('vip.extendVip')}
        </button>
      </div>

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

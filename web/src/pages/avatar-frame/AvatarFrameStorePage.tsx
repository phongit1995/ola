import { useState, type UIEvent } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ChevronRightIcon,
  ScreenHeader,
  Spinner,
  type ListOption,
} from '@components';
import { AVATAR_FRAME_PRIVACY_OPTIONS } from '@constants';
import { avatarFramePrivacyLabelKey, isAvatarFrameTransferable, toast } from '@lib';
import type { OwnedAvatarFrame } from '@app-types';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAvatarFrameCollection } from '@ola/shared/stores/avatar-frame/useAvatarFrameCollection';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { AvatarFrameHistoryDialog } from './components/AvatarFrameHistoryDialog';
import { AvatarFrameTile } from './components/AvatarFrameTile';
import { AvatarFrameTransferDialog } from './components/AvatarFrameTransferDialog';
import { OwnFramedAvatar } from './components/OwnFramedAvatar';
import { VipRequiredHint } from './components/VipRequiredHint';
import {
  FRAME_PREVIEW_AVATAR_SIZE,
  LOAD_MORE_THRESHOLD_PX,
} from './constants';

export function AvatarFrameStorePage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const pushOverlay = useAppOverlayStore((s) => s.push);
  const {
    store,
    loading,
    loadingMore,
    failed,
    busy,
    hasMore,
    reload,
    loadMore,
    transfer,
    items,
    equippedFrameId,
    vipActive,
    privacy,
    transferFrameId,
    setTransferFrameId,
    vipPromptOpen,
    setVipPromptOpen,
    requestEquip,
    changePrivacy,
    requestTransfer,
  } = useAvatarFrameCollection();
  const [menuFrame, setMenuFrame] = useState<OwnedAvatarFrame | null>(null);
  const [privacyOpen, setPrivacyOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);

  const shownFrameId = vipActive ? equippedFrameId : null;

  function handleScroll(event: UIEvent<HTMLDivElement>) {
    if (loadingMore || loading || !hasMore) return;
    const el = event.currentTarget;
    if (
      el.scrollHeight - el.scrollTop - el.clientHeight >
      LOAD_MORE_THRESHOLD_PX
    )
      return;
    void loadMore().catch(() => toast.error(t('common.error')));
  }

  function buildMenuOptions(frame: OwnedAvatarFrame): ListOption[] {
    return [
      frame.isEquipped
        ? {
            key: 'unequip',
            label: t('avatarFrame.actionUnequip'),
            onSelect: () => void requestEquip(null),
          }
        : {
            key: 'equip',
            label: t('avatarFrame.actionEquip'),
            onSelect: () => void requestEquip(frame.frameId),
          },
      ...(isAvatarFrameTransferable(frame)
        ? [
            {
              key: 'transfer',
              label: (
                <span className={frame.isEquipped ? 'text-black/38' : undefined}>
                  {t('avatarFrame.actionTransfer')}
                </span>
              ),
              onSelect: () => requestTransfer(frame),
            },
          ]
        : []),
    ];
  }

  const privacyOptions: ListOption[] = AVATAR_FRAME_PRIVACY_OPTIONS.map((option) => ({
    key: String(option.value),
    label: t(option.labelKey),
    onSelect: () => void changePrivacy(option.value),
  }));

  function renderCollection() {
    if (loading && store == null) {
      return (
        <div className="flex justify-center py-10">
          <Spinner size={24} />
        </div>
      );
    }
    if (failed && store == null) {
      return (
        <button
          type="button"
          onClick={() => void reload()}
          className="w-full py-16 text-center text-sm text-black/54"
        >
          {t('common.error')}
        </button>
      );
    }
    if (items.length === 0) {
      return (
        <div className="py-16 text-center text-sm text-black/54">
          {t('avatarFrame.empty')}
        </div>
      );
    }
    return (
      <div className="grid grid-cols-3 gap-2 p-2">
        {items.map((frame) => (
          <AvatarFrameTile
            key={frame.frameId}
            frameId={frame.frameId}
            highlighted={frame.isEquipped}
            badge={frame.isEquipped ? t('avatarFrame.equipped') : undefined}
            onClick={() => setMenuFrame(frame)}
          />
        ))}
      </div>
    );
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('avatarFrame.storeTitle')} onBack={onClose}>
        <button
          type="button"
          onClick={() => setHistoryOpen(true)}
          className="rounded bg-white/15 px-2 py-1 text-sm font-medium text-white hover:bg-white/25"
        >
          {t('avatarFrame.history.title')}
        </button>
      </ScreenHeader>

      <div
        className="flex-1 overflow-y-auto bg-ola-surface"
        onScroll={handleScroll}
      >
        <div className="flex flex-col items-center gap-1 bg-white px-4 pt-6 pb-4">
          <OwnFramedAvatar
            frameId={shownFrameId}
            size={FRAME_PREVIEW_AVATAR_SIZE}
          />
          {equippedFrameId != null && (
            <>
              <span className="mt-3 text-base font-medium text-black/87">
                {avatarFrameLabel(equippedFrameId)}
              </span>
              <span className="text-xs text-black/54">
                {vipActive
                  ? t('avatarFrame.equipped')
                  : t('avatarFrame.equippedHidden')}
              </span>
            </>
          )}
        </div>
        {store != null && !vipActive && <VipRequiredHint />}

        <div className="mt-2 bg-white">
          <button
            type="button"
            onClick={() => setPrivacyOpen(true)}
            className="flex min-h-12 w-full items-center px-4 text-left active:bg-black/5"
          >
            <span className="flex-1 text-base text-black/87">
              {t('avatarFrame.privacyTitle')}
            </span>
            <span className="mx-2 text-xs text-black/54">
              {t(avatarFramePrivacyLabelKey(privacy))}
            </span>
            <ChevronRightIcon className="h-5 w-5 text-black/40" />
          </button>
          <div className="mx-4 h-px bg-black/12" />
          <button
            type="button"
            onClick={() => pushOverlay('avatarFrameShop')}
            className="flex min-h-12 w-full items-center px-4 text-left active:bg-black/5"
          >
            <span className="flex-1 text-base text-black/87">
              {t('avatarFrame.shopTitle')}
            </span>
            <ChevronRightIcon className="h-5 w-5 text-black/40" />
          </button>
        </div>

        <div className="flex h-9 items-center justify-center bg-ola-border-strong px-3 text-base text-white">
          {t('avatarFrame.count', { count: store?.total ?? 0 })}
        </div>

        {renderCollection()}
        {loadingMore && (
          <div className="flex h-12 items-center justify-center">
            <Spinner size={20} />
          </div>
        )}
      </div>

      <ListOptionDialog
        open={menuFrame != null}
        title={menuFrame ? avatarFrameLabel(menuFrame.frameId) : ''}
        options={menuFrame ? buildMenuOptions(menuFrame) : []}
        onClose={() => setMenuFrame(null)}
      />

      <ListOptionDialog
        open={privacyOpen}
        title={t('avatarFrame.privacyTitle')}
        options={privacyOptions}
        onClose={() => setPrivacyOpen(false)}
      />

      <ConfirmDialog
        open={vipPromptOpen}
        title={t('avatarFrame.storeTitle')}
        message={t('avatarFrame.errors.vipRequired')}
        confirmLabel={t('avatarFrame.buyVip')}
        cancelLabel={t('avatarFrame.cancel')}
        onConfirm={() => {
          setVipPromptOpen(false);
          pushOverlay('vipBuy', 'extend');
        }}
        onCancel={() => setVipPromptOpen(false)}
      />

      {transferFrameId != null && (
        <AvatarFrameTransferDialog
          frameId={transferFrameId}
          busy={busy}
          onTransfer={transfer}
          onClose={() => setTransferFrameId(null)}
        />
      )}

      {historyOpen && (
        <AvatarFrameHistoryDialog onClose={() => setHistoryOpen(false)} />
      )}
    </FullScreenOverlay>
  );
}

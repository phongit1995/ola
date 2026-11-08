import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, UserRow, UserSearchPicker } from '@components';
import { avatarFrameErrorKey, colorForName, toast } from '@lib';
import type { UserSearchResult } from '@app-types';
import { FRAME_INPUT_CLASS } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { AvatarFrameThumb } from './AvatarFrameThumb';

interface AvatarFrameTransferDialogProps {
  frameId: string;
  busy: boolean;
  onTransfer: (
    frameId: string,
    toUserId: string,
    password: string
  ) => Promise<void>;
  onClose: () => void;
}

export function AvatarFrameTransferDialog({
  frameId,
  busy,
  onTransfer,
  onClose,
}: AvatarFrameTransferDialogProps) {
  const { t } = useTranslation();
  const [receiver, setReceiver] = useState<UserSearchResult | null>(null);
  const [password, setPassword] = useState('');
  const canSubmit = receiver != null && password.trim() !== '' && !busy;

  async function submit() {
    if (!canSubmit || receiver == null) return;
    try {
      await onTransfer(frameId, receiver.id, password);
      toast.success(t('avatarFrame.toastTransferred'));
      onClose();
    } catch (error) {
      toast.error(t(avatarFrameErrorKey(error)));
    }
  }

  const footer =
    receiver != null ? (
      <>
        <DialogButton
          disabled={busy}
          onClick={() => {
            setReceiver(null);
            setPassword('');
          }}
        >
          {t('avatarFrame.cancel')}
        </DialogButton>
        <DialogButton
          variant="green"
          disabled={!canSubmit}
          onClick={() => void submit()}
        >
          {t('avatarFrame.actionTransfer')}
        </DialogButton>
      </>
    ) : null;

  return (
    <Dialog
      open
      onClose={onClose}
      showClose
      title={t('avatarFrame.transferTitle')}
      footer={footer}
    >
      <div className="mb-2 flex items-center gap-2 px-1">
        <AvatarFrameThumb frameId={frameId} />
        <span className="truncate text-base font-medium text-black/87">
          {avatarFrameLabel(frameId)}
        </span>
      </div>
      {receiver == null ? (
        <UserSearchPicker
          label={t('avatarFrame.transferReceiver')}
          placeholder={t('vip.buy.receiverHint')}
          onPick={setReceiver}
        />
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-sm text-black/54">
            {t('avatarFrame.transferReceiver')}
          </span>
          <div className="rounded border border-black/12 px-3">
            <UserRow
              name={receiver.fullName || receiver.username}
              username={receiver.username}
              avatar={receiver.avatar}
              color={colorForName(receiver.username)}
            />
          </div>
          <label className="mt-3 flex flex-col text-sm text-black/54">
            {t('avatarFrame.password')}
            <input
              type="password"
              autoFocus
              value={password}
              onChange={(event) => setPassword(event.target.value)}
              onKeyDown={(event) => {
                if (event.key === 'Enter') void submit();
              }}
              placeholder={t('avatarFrame.passwordHint')}
              className={FRAME_INPUT_CLASS}
            />
          </label>
        </div>
      )}
    </Dialog>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog } from '@components';
import { colorForName } from '@lib';
import type { SavedAccount } from './savedAccountsStore';

interface SavedAccountGalleryProps {
  accounts: SavedAccount[];
  onPick: (account: SavedAccount) => void;
  onRemove: (username: string) => void;
}

export function SavedAccountGallery({
  accounts,
  onPick,
  onRemove,
}: SavedAccountGalleryProps) {
  const { t } = useTranslation();
  const [removeTarget, setRemoveTarget] = useState<string | null>(null);

  return (
    <>
      <div className="mb-4 flex w-full max-w-md justify-center gap-8 overflow-x-auto px-1 py-1">
        {accounts.map((account) => (
          <div
            key={account.username}
            className="flex shrink-0 flex-col items-center gap-1"
          >
            <div className="relative">
              <button
                type="button"
                onClick={() => onPick(account)}
                className="block overflow-hidden rounded shadow-[0_1px_4px_rgba(0,0,0,.3)]"
              >
                <Avatar
                  name={account.username}
                  color={colorForName(account.username)}
                  src={account.avatar}
                  size={96}
                  rounded={false}
                />
              </button>
              <button
                type="button"
                aria-label={t('login.removeAccount')}
                onClick={() => setRemoveTarget(account.username)}
                className="absolute right-0 bottom-0 flex h-6 w-6 items-center justify-center rounded bg-black/38 text-sm leading-none text-white"
              >
                ×
              </button>
            </div>
            <span className="max-w-24 truncate text-sm font-bold text-white">
              {account.username}
            </span>
          </div>
        ))}
      </div>

      <ConfirmDialog
        open={removeTarget != null}
        title={t('login.removeAccountTitle')}
        message={t('login.removeAccountConfirm', {
          username: removeTarget != null ? `@${removeTarget}` : '',
        })}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          if (removeTarget != null) {
            onRemove(removeTarget);
          }
          setRemoveTarget(null);
        }}
        onCancel={() => setRemoveTarget(null)}
      />
    </>
  );
}

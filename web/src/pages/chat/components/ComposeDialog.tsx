import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';

interface ComposeDialogProps {
  open: boolean;
  onClose: () => void;
  onStart: (name: string) => void;
}

export function ComposeDialog({ open, onClose, onStart }: ComposeDialogProps) {
  const { t } = useTranslation();
  const [value, setValue] = useState('');

  function start() {
    const name = value.trim();
    if (name === '') return;
    setValue('');
    onStart(name);
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('chat.composeTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={start}>
            {t('chat.composeStart')}
          </DialogButton>
          <DialogButton variant="default" onClick={onClose}>
            {t('dialog.cancel')}
          </DialogButton>
        </>
      }
    >
      <input
        value={value}
        onChange={(event) => setValue(event.target.value)}
        onKeyDown={(event) => {
          if (event.key === 'Enter') start();
        }}
        placeholder={t('chat.composePlaceholder')}
        className="w-full rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />
      <div className="mt-3 divide-y divide-black/8">
        <p className="py-2 text-sm text-black/87">{t('chat.inviteFriends')}</p>
        <p className="py-2 text-sm text-black/87">{t('chat.chatGroup')}</p>
      </div>
    </Dialog>
  );
}

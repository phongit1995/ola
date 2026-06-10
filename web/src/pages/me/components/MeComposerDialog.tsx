import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';

type Privacy = 'public' | 'friend' | 'private';

interface MeComposerDialogProps {
  open: boolean;
  onClose: () => void;
  onPost: (content: string) => void;
}

const PRIVACY_OPTIONS: Privacy[] = ['public', 'friend', 'private'];

export function MeComposerDialog({ open, onClose, onPost }: MeComposerDialogProps) {
  const { t } = useTranslation();
  const [content, setContent] = useState('');
  const [privacy, setPrivacy] = useState<Privacy>('public');

  function submit() {
    const text = content.trim();
    if (text === '') return;
    setContent('');
    setPrivacy('public');
    onPost(text);
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('me.composerTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={submit}>
            {t('me.post')}
          </DialogButton>
          <DialogButton variant="default" onClick={onClose}>
            {t('dialog.cancel')}
          </DialogButton>
        </>
      }
    >
      <label className="flex items-center gap-2 text-sm text-black/54">
        {t('me.privacyTo')}
        <select
          value={privacy}
          onChange={(event) => setPrivacy(event.target.value as Privacy)}
          className="rounded border border-black/12 px-2 py-1 text-black/87 outline-none"
        >
          {PRIVACY_OPTIONS.map((option) => (
            <option key={option} value={option}>
              {t(`me.privacy_${option}` as 'me.privacy_public')}
            </option>
          ))}
        </select>
      </label>
      <textarea
        value={content}
        onChange={(event) => setContent(event.target.value)}
        placeholder={t('me.composerHint')}
        rows={4}
        className="mt-3 w-full resize-none rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />
    </Dialog>
  );
}

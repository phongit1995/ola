import { useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';

type Privacy = 'public' | 'friend' | 'private';

interface MeComposerDialogProps {
  open: boolean;
  onClose: () => void;
  onPost: (content: string, photos: string[]) => void;
}

const PRIVACY_OPTIONS: Privacy[] = ['public', 'friend', 'private'];
const MAX_PHOTOS = 5;

export function MeComposerDialog({ open, onClose, onPost }: MeComposerDialogProps) {
  const { t } = useTranslation();
  const [content, setContent] = useState('');
  const [privacy, setPrivacy] = useState<Privacy>('public');
  const [photos, setPhotos] = useState<string[]>([]);
  const fileInputRef = useRef<HTMLInputElement>(null);

  function reset() {
    setContent('');
    setPrivacy('public');
    setPhotos([]);
  }

  function handleClose() {
    photos.forEach((url) => URL.revokeObjectURL(url));
    reset();
    onClose();
  }

  function pickPhotos(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0) return;
    setPhotos((current) => {
      const room = MAX_PHOTOS - current.length;
      const added = files.slice(0, room).map((file) => URL.createObjectURL(file));
      return [...current, ...added];
    });
  }

  function removePhoto(url: string) {
    URL.revokeObjectURL(url);
    setPhotos((current) => current.filter((item) => item !== url));
  }

  function submit() {
    const text = content.trim();
    if (text === '' && photos.length === 0) return;
    onPost(text, photos);
    reset();
  }

  return (
    <Dialog
      open={open}
      onClose={handleClose}
      title={t('me.composerTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={submit}>
            {t('me.post')}
          </DialogButton>
          <DialogButton variant="default" onClick={handleClose}>
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

      {photos.length > 0 && (
        <div className="mt-3 grid grid-cols-3 gap-2">
          {photos.map((url) => (
            <div
              key={url}
              className="relative aspect-square overflow-hidden rounded-md border border-black/12"
            >
              <img src={url} alt="" className="h-full w-full object-cover" />
              <button
                type="button"
                aria-label={t('me.removePhoto')}
                onClick={() => removePhoto(url)}
                className="absolute right-1 top-1 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-sm leading-none text-white"
              >
                ×
              </button>
            </div>
          ))}
        </div>
      )}

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        hidden
        onChange={pickPhotos}
      />
      <button
        type="button"
        onClick={() => fileInputRef.current?.click()}
        disabled={photos.length >= MAX_PHOTOS}
        className="mt-3 flex items-center gap-2 rounded-md border border-dashed border-black/24 px-3 py-2 text-sm text-black/54 disabled:opacity-40"
      >
        <span className="text-lg leading-none">＋</span>
        {t('me.addPhoto')} ({photos.length}/{MAX_PHOTOS})
      </button>
    </Dialog>
  );
}

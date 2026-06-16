import { useEffect, useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { CONTACTS } from '../../chat/data';
import { Avatar } from '@components';
import { ATTACH_BUTTONS, PRIVACY_OPTIONS, type AttachButtonKey } from '../constants';
import { KUL_STICKERS, kulCode, stickerImage } from '../stickers';
import { insertAtCursor } from '@lib';
import checkInIcon from '@/assets/icons/me/ic_check_in.png';
import { ComposerCheckInPanel, type ComposedCheckIn } from './ComposerCheckInPanel';
import { ComposerSmileyPanel } from '@components';
import type { PostVisibility } from '@app-types';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | 'smiley' | null;
type PickedPhoto = { url: string; file?: File };

const MAX_IMAGES = 5;

export interface ComposedPost {
  content: string;
  files: File[];
  imageUrls: string[];
  checkIn: ComposedCheckIn | null;
  sticker: string | null;
  visibility: PostVisibility;
}

interface MeComposerDialogProps {
  open: boolean;
  onClose: () => void;
  onPost: (post: ComposedPost) => Promise<boolean>;
}

export function MeComposerDialog({ open, onClose, onPost }: MeComposerDialogProps) {
  const { t } = useTranslation();
  const [content, setContent] = useState('');
  const [privacy, setPrivacy] = useState<PostVisibility>('public');
  const [photos, setPhotos] = useState<PickedPhoto[]>([]);
  const [checkIn, setCheckIn] = useState<ComposedCheckIn | null>(null);
  const [sticker, setSticker] = useState<string | null>(null);
  const [panel, setPanel] = useState<AttachPanel>(null);
  const [submitting, setSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  function reset() {
    setContent('');
    setPrivacy('public');
    setPhotos([]);
    setCheckIn(null);
    setSticker(null);
    setPanel(null);
  }

  function revokePhotos(items: PickedPhoto[]) {
    items.forEach((photo) => {
      if (photo.file != null) URL.revokeObjectURL(photo.url);
    });
  }

  const photosRef = useRef<PickedPhoto[]>([]);
  useEffect(() => {
    photosRef.current = photos;
  }, [photos]);
  useEffect(() => {
    return () => {
      photosRef.current.forEach((photo) => {
        if (photo.file != null) URL.revokeObjectURL(photo.url);
      });
    };
  }, []);

  function handleClose() {
    revokePhotos(photos);
    reset();
    onClose();
  }

  function pickPhotos(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0) return;
    setPhotos((current) => {
      const room = MAX_IMAGES - current.length;
      if (room <= 0) return current;
      const added = files.slice(0, room).map((file) => ({ url: URL.createObjectURL(file), file }));
      return [...current, ...added];
    });
  }

  function removePhoto(url: string) {
    URL.revokeObjectURL(url);
    setPhotos((current) => current.filter((item) => item.url !== url));
  }

  function insertMention(nick: string) {
    setContent((current) => insertAtCursor(current, ` @${nick}`, textareaRef.current));
  }

  function insertSmiley(code: string) {
    setContent((current) => insertAtCursor(current, `${code} `, textareaRef.current));
  }

  function handleAttach(key: AttachButtonKey) {
    if (key === 'local') {
      fileInputRef.current?.click();
      return;
    }
    setPanel((current) => (current === key ? null : key));
  }

  async function submit() {
    if (submitting) return;
    const text = content.trim();
    if (text === '' && photos.length === 0 && sticker == null && checkIn == null) return;
    setSubmitting(true);
    const ok = await onPost({
      content: text,
      files: photos.filter((photo) => photo.file != null).map((photo) => photo.file as File),
      imageUrls: photos.filter((photo) => photo.file == null).map((photo) => photo.url),
      checkIn,
      sticker,
      visibility: privacy,
    });
    setSubmitting(false);
    if (ok) {
      revokePhotos(photos);
      reset();
      onClose();
    }
  }

  return (
    <Dialog
      open={open}
      onClose={handleClose}
      title={t('me.composerTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={submit} disabled={submitting}>
            {t('me.post')}
          </DialogButton>
          <DialogButton variant="default" onClick={handleClose}>
            {t('dialog.cancel')}
          </DialogButton>
        </>
      }
    >
      <div className="flex items-center gap-2 text-sm text-black/54">
        <label className="flex items-center gap-2">
          {t('me.privacyTo')}
          <select
            value={privacy}
            onChange={(event) => setPrivacy(event.target.value as PostVisibility)}
            className="rounded border border-black/12 px-2 py-1 text-black/87 outline-none"
          >
            {PRIVACY_OPTIONS.map((option) => (
              <option key={option} value={option}>
                {t(`me.privacy_${option}` as 'me.privacy_public')}
              </option>
            ))}
          </select>
        </label>
      </div>

      <textarea
        ref={textareaRef}
        value={content}
        onChange={(event) => setContent(event.target.value)}
        placeholder={t('me.composerHint')}
        rows={4}
        className="mt-3 w-full resize-none rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />

      {sticker != null && stickerImage(sticker) != null && (
        <div className="relative mt-2 rounded-md border border-black/12 p-2 pr-20">
          <img src={stickerImage(sticker) ?? ''} alt="" className="h-16 w-16 object-contain" />
          <button
            type="button"
            onClick={() => setSticker(null)}
            className="absolute right-1 top-1/2 -translate-y-1/2 text-xs text-ola-error"
          >
            {t('me.removeSticker')}
          </button>
        </div>
      )}

      {checkIn != null && (
        <div className="relative mt-2 rounded-md border border-black/12 p-2 pr-20 text-sm text-black/54">
          <div className="flex items-center gap-2">
            <img src={checkInIcon} alt="" className="h-7 w-7 shrink-0 object-contain" />
            <span className="min-w-0 flex-1">
              {(checkIn.action ?? '') !== '' && (
                <span className="block truncate text-black/87">
                  {checkIn.actionIcon} {checkIn.action}
                </span>
              )}
              <span className="block truncate text-xs text-black/40">{checkIn.name}</span>
            </span>
          </div>
          <button
            type="button"
            onClick={() => setCheckIn(null)}
            className="absolute right-1 top-1/2 -translate-y-1/2 text-xs text-ola-error"
          >
            {t('me.removeCheckIn')}
          </button>
        </div>
      )}

      {photos.length > 0 && (
        <div className="mt-3 flex gap-2 overflow-x-auto pb-1">
          {photos.map((photo) => (
            <div
              key={photo.url}
              className="relative h-20 w-20 shrink-0 overflow-hidden rounded-md border border-black/12"
            >
              <img src={photo.url} alt="" className="h-full w-full object-cover" />
              <button
                type="button"
                aria-label={t('me.removePhoto')}
                onClick={() => removePhoto(photo.url)}
                className="absolute right-1 top-1 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-sm leading-none text-white"
              >
                ×
              </button>
            </div>
          ))}
        </div>
      )}

      {photos.length >= MAX_IMAGES && (
        <p className="mt-1 text-xs text-black/40">{t('me.maxImages')}</p>
      )}

      <div className="mt-3 flex justify-around border-t border-black/12 pt-2">
        {ATTACH_BUTTONS.map((button) => (
          <button
            key={button.key}
            type="button"
            aria-label={t(button.labelKey)}
            onClick={() => handleAttach(button.key)}
            className={`flex flex-col items-center gap-0.5 text-xs ${
              panel === button.key ? 'text-ola-primary' : 'text-black/54'
            }`}
          >
            <span className="text-2xl leading-none">{button.glyph}</span>
            {t(button.labelKey)}
          </button>
        ))}
      </div>

      {panel === 'tag' && (
        <div className="mt-2 max-h-44 overflow-y-auto rounded-md border border-black/12">
          {CONTACTS.map((contact) => (
            <button
              key={contact.name}
              type="button"
              onClick={() => insertMention(contact.name)}
              className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm hover:bg-ola-primary-light"
            >
              <Avatar name={contact.name} color={contact.color} size={28} />
              <span className="text-black/87">@{contact.name}</span>
            </button>
          ))}
        </div>
      )}

      {panel === 'checkin' && (
        <ComposerCheckInPanel
          onSelect={(value) => {
            setCheckIn(value);
            setPanel(null);
          }}
        />
      )}

      {panel === 'sticker' && (
        <div className="mt-2 grid max-h-44 grid-cols-6 gap-1 overflow-y-auto rounded-md border border-black/12 p-2">
          {KUL_STICKERS.map((item) => (
            <button
              key={item.index}
              type="button"
              onClick={() => {
                setSticker(kulCode(item.index));
                setPanel(null);
              }}
              className="flex h-12 items-center justify-center rounded hover:bg-gray-100"
            >
              <img src={item.src} alt="" className="h-10 w-10 object-contain" />
            </button>
          ))}
        </div>
      )}

      {panel === 'smiley' && <ComposerSmileyPanel onPick={insertSmiley} />}

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        hidden
        onChange={pickPhotos}
      />
    </Dialog>
  );
}

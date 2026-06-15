import { useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { CONTACTS } from '../../chat/data';
import { Avatar } from '../../chat/components/Avatar';
import {
  ATTACH_BUTTONS,
  PRIVACY_OPTIONS,
  STICKERS,
  VENUES,
  type AttachButtonKey,
} from '../constants';
import type { PostVisibility } from '@app-types';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | null;
type PickedPhoto = { url: string; file: File };

export interface ComposedPost {
  content: string;
  files: File[];
  checkIn: string | null;
  sticker: string | null;
  visibility: PostVisibility;
}

interface MeComposerDialogProps {
  open: boolean;
  onClose: () => void;
  onPost: (post: ComposedPost) => void;
}

export function MeComposerDialog({ open, onClose, onPost }: MeComposerDialogProps) {
  const { t } = useTranslation();
  const [content, setContent] = useState('');
  const [privacy, setPrivacy] = useState<PostVisibility>('public');
  const [photos, setPhotos] = useState<PickedPhoto[]>([]);
  const [checkIn, setCheckIn] = useState<string | null>(null);
  const [sticker, setSticker] = useState<string | null>(null);
  const [postToMe, setPostToMe] = useState(false);
  const [panel, setPanel] = useState<AttachPanel>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  function reset() {
    setContent('');
    setPrivacy('public');
    setPhotos([]);
    setCheckIn(null);
    setSticker(null);
    setPostToMe(false);
    setPanel(null);
  }

  function handleClose() {
    photos.forEach((photo) => URL.revokeObjectURL(photo.url));
    reset();
    onClose();
  }

  function pickPhotos(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0) return;
    setPhotos((current) => [
      ...current,
      ...files.map((file) => ({ url: URL.createObjectURL(file), file })),
    ]);
  }

  function removePhoto(url: string) {
    URL.revokeObjectURL(url);
    setPhotos((current) => current.filter((item) => item.url !== url));
  }

  function insertMention(nick: string) {
    const mention = ` @${nick}`;
    const el = textareaRef.current;
    setContent((current) => {
      if (el == null) return current + mention;
      const at = el.selectionStart ?? current.length;
      return current.slice(0, at) + mention + current.slice(at);
    });
  }

  function togglePanel(next: AttachPanel) {
    setPanel((current) => (current === next ? null : next));
  }

  function handleAttach(key: AttachButtonKey) {
    if (key === 'local' || key === 'cloud') {
      fileInputRef.current?.click();
      return;
    }
    togglePanel(key);
  }

  function submit() {
    const text = content.trim();
    if (text === '' && photos.length === 0 && sticker == null && checkIn == null) return;
    onPost({ content: text, files: photos.map((photo) => photo.file), checkIn, sticker, visibility: privacy });
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

      <label className="mt-2 flex items-center gap-2 text-sm text-black/54">
        <input
          type="checkbox"
          checked={postToMe}
          onChange={(event) => setPostToMe(event.target.checked)}
          className="h-4 w-4 accent-ola-primary"
        />
        {t('me.postToMePage')}
      </label>

      <textarea
        ref={textareaRef}
        value={content}
        onChange={(event) => setContent(event.target.value)}
        placeholder={t('me.composerHint')}
        rows={4}
        className="mt-3 w-full resize-none rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
      />

      {sticker != null && (
        <div className="mt-2 flex items-center gap-2">
          <span className="text-5xl">{sticker}</span>
          <button
            type="button"
            onClick={() => setSticker(null)}
            className="text-xs text-ola-error"
          >
            {t('me.removePhoto')}
          </button>
        </div>
      )}

      {checkIn != null && (
        <div className="mt-2 flex items-center gap-1 text-sm text-black/54">
          <span>📍</span>
          <span className="flex-1 truncate">{checkIn}</span>
          <button
            type="button"
            onClick={() => setCheckIn(null)}
            className="text-xs text-ola-error"
          >
            {t('me.removePhoto')}
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
        <div className="mt-2 overflow-hidden rounded-md border border-black/12">
          {VENUES.map((venue) => (
            <button
              key={venue}
              type="button"
              onClick={() => {
                setCheckIn(venue);
                setPanel(null);
              }}
              className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm text-black/87 hover:bg-ola-primary-light"
            >
              <span>📍</span>
              {venue}
            </button>
          ))}
        </div>
      )}

      {panel === 'sticker' && (
        <div className="mt-2 grid grid-cols-6 gap-1 rounded-md border border-black/12 p-2">
          {STICKERS.map((item) => (
            <button
              key={item}
              type="button"
              onClick={() => {
                setSticker(item);
                setPanel(null);
              }}
              className="flex h-10 items-center justify-center rounded text-2xl hover:bg-gray-100"
            >
              {item}
            </button>
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
    </Dialog>
  );
}

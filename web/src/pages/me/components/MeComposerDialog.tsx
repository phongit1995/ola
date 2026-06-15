import { useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { CONTACTS } from '../../chat/data';
import { Avatar } from '../../chat/components/Avatar';
import { ATTACH_BUTTONS, PRIVACY_OPTIONS, type AttachButtonKey } from '../constants';
import { KUL_STICKERS, kulCode, stickerImage } from '../stickers';
import { GeoService, type GeoVenue } from '@services';
import type { PostVisibility } from '@app-types';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | 'cloud' | null;
type PickedPhoto = { url: string; file?: File };

const MAX_IMAGES = 5;

function isValidImageUrl(value: string): boolean {
  try {
    const parsed = new URL(value);
    return parsed.protocol === 'http:' || parsed.protocol === 'https:';
  } catch {
    return false;
  }
}

export interface ComposedPost {
  content: string;
  files: File[];
  imageUrls: string[];
  checkIn: GeoVenue | null;
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
  const [checkIn, setCheckIn] = useState<GeoVenue | null>(null);
  const [sticker, setSticker] = useState<string | null>(null);
  const [panel, setPanel] = useState<AttachPanel>(null);
  const [submitting, setSubmitting] = useState(false);
  const [nearby, setNearby] = useState<GeoVenue[]>([]);
  const [locating, setLocating] = useState(false);
  const [locateError, setLocateError] = useState(false);
  const [cloudUrl, setCloudUrl] = useState('');
  const [cloudChecking, setCloudChecking] = useState(false);
  const [cloudError, setCloudError] = useState<'invalid' | 'load' | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  function reset() {
    setContent('');
    setPrivacy('public');
    setPhotos([]);
    setCheckIn(null);
    setSticker(null);
    setPanel(null);
    setNearby([]);
    setLocateError(false);
    setCloudUrl('');
    setCloudError(null);
  }

  function locate() {
    if (!GeoService.enabled || !('geolocation' in navigator)) {
      setLocateError(true);
      return;
    }
    setLocating(true);
    setLocateError(false);
    navigator.geolocation.getCurrentPosition(
      async (pos) => {
        try {
          setNearby(await GeoService.nearby(pos.coords.latitude, pos.coords.longitude));
        } catch {
          setLocateError(true);
        } finally {
          setLocating(false);
        }
      },
      () => {
        setLocating(false);
        setLocateError(true);
      },
      { enableHighAccuracy: true, timeout: 10000 }
    );
  }

  function revokePhotos(items: PickedPhoto[]) {
    items.forEach((photo) => {
      if (photo.file != null) URL.revokeObjectURL(photo.url);
    });
  }

  function addCloudUrl() {
    const url = cloudUrl.trim();
    if (!isValidImageUrl(url)) {
      setCloudError('invalid');
      return;
    }
    if (photos.length >= MAX_IMAGES) return;
    setCloudChecking(true);
    setCloudError(null);
    const probe = new Image();
    probe.onload = () => {
      setCloudChecking(false);
      setPhotos((current) => (current.length >= MAX_IMAGES ? current : [...current, { url }]));
      setCloudUrl('');
      setPanel(null);
    };
    probe.onerror = () => {
      setCloudChecking(false);
      setCloudError('load');
    };
    probe.src = url;
  }

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
    if (key === 'local') {
      fileInputRef.current?.click();
      return;
    }
    const opening = panel !== key;
    togglePanel(key);
    if (key === 'cloud') setCloudError(null);
    if (key === 'checkin' && opening && nearby.length === 0 && !locating) {
      locate();
    }
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
            className="absolute right-1 top-1 text-xs text-ola-error"
          >
            {t('me.removeSticker')}
          </button>
        </div>
      )}

      {checkIn != null && (
        <div className="relative mt-2 rounded-md border border-black/12 p-2 pr-20 text-sm text-black/54">
          <div className="flex items-start gap-1">
            <span>📍</span>
            <span className="min-w-0 flex-1">
              <span className="block truncate text-black/87">{checkIn.name}</span>
              {checkIn.address !== '' && (
                <span className="block truncate text-xs text-black/40">{checkIn.address}</span>
              )}
            </span>
          </div>
          <button
            type="button"
            onClick={() => setCheckIn(null)}
            className="absolute right-1 top-1 text-xs text-ola-error"
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
        <div className="mt-2 overflow-hidden rounded-md border border-black/12">
          <button
            type="button"
            onClick={locate}
            disabled={locating}
            className="flex w-full items-center gap-2 border-b border-black/12 px-3 py-2 text-left text-sm text-ola-primary disabled:opacity-50"
          >
            <span>📡</span>
            {locating ? t('me.checkInLocating') : t('me.checkInLocate')}
          </button>
          {locateError && (
            <p className="px-3 py-2 text-xs text-ola-error">{t('me.checkInError')}</p>
          )}
          {!locating && !locateError && nearby.length === 0 && (
            <p className="px-3 py-2 text-xs text-black/40">{t('me.checkInNoVenues')}</p>
          )}
          <div className="max-h-44 overflow-y-auto">
            {nearby.map((venue) => (
              <button
                key={`${venue.name}-${venue.lat}-${venue.lng}`}
                type="button"
                onClick={() => {
                  setCheckIn(venue);
                  setPanel(null);
                }}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm text-black/87 hover:bg-ola-primary-light"
              >
                <span>📍</span>
                <span className="min-w-0 flex-1">
                  <span className="block truncate">{venue.name}</span>
                  {venue.address !== '' && (
                    <span className="block truncate text-xs text-black/40">{venue.address}</span>
                  )}
                </span>
              </button>
            ))}
          </div>
        </div>
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

      {panel === 'cloud' && (
        <div className="mt-2 rounded-md border border-black/12 p-2">
          <div className="flex gap-2">
            <input
              type="url"
              value={cloudUrl}
              onChange={(event) => {
                setCloudUrl(event.target.value);
                setCloudError(null);
              }}
              onKeyDown={(event) => {
                if (event.key === 'Enter') {
                  event.preventDefault();
                  addCloudUrl();
                }
              }}
              placeholder={t('me.cloudUrlHint')}
              disabled={photos.length >= MAX_IMAGES}
              className="min-w-0 flex-1 rounded border border-black/12 px-2 py-1 text-sm text-black/87 outline-none focus:border-ola-primary disabled:opacity-50"
            />
            <button
              type="button"
              onClick={addCloudUrl}
              disabled={cloudChecking || photos.length >= MAX_IMAGES}
              className="shrink-0 rounded bg-ola-primary px-3 py-1 text-sm text-white disabled:opacity-50"
            >
              {cloudChecking ? t('me.cloudChecking') : t('me.cloudAdd')}
            </button>
          </div>
          {cloudError === 'invalid' && (
            <p className="mt-1 text-xs text-ola-error">{t('me.cloudInvalid')}</p>
          )}
          {cloudError === 'load' && (
            <p className="mt-1 text-xs text-ola-error">{t('me.cloudLoadError')}</p>
          )}
          {photos.length >= MAX_IMAGES && (
            <p className="mt-1 text-xs text-black/40">{t('me.maxImages')}</p>
          )}
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

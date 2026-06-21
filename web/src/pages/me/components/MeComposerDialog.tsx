import { useEffect, useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, SmileyInput, type SmileyInputHandle } from '@components';
import { ATTACH_BUTTONS, MAX_IMAGES, PRIVACY_OPTIONS, type AttachButtonKey } from '../constants';
import { type ComposedCheckIn } from './ComposerCheckInPanel';
import { ComposerPreview } from './ComposerPreview';
import { ComposerAttachPanels } from './ComposerAttachPanels';
import type { PostVisibility } from '@app-types';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | 'smiley' | null;
type PickedPhoto = { url: string; file?: File };

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
  initial?: ComposedPost | null;
  title?: string;
  submitLabel?: string;
}

export function MeComposerDialog({
  open,
  onClose,
  onPost,
  initial,
  title,
  submitLabel,
}: MeComposerDialogProps) {
  const { t } = useTranslation();
  const [content, setContent] = useState(initial?.content ?? '');
  const [privacy, setPrivacy] = useState<PostVisibility>(initial?.visibility ?? 'public');
  const [photos, setPhotos] = useState<PickedPhoto[]>(() =>
    (initial?.imageUrls ?? []).map((url) => ({ url }))
  );
  const [checkIn, setCheckIn] = useState<ComposedCheckIn | null>(initial?.checkIn ?? null);
  const [sticker, setSticker] = useState<string | null>(initial?.sticker ?? null);
  const [panel, setPanel] = useState<AttachPanel>(null);
  const [submitting, setSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);

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
    const target = photos.find((item) => item.url === url);
    if (target?.file != null) URL.revokeObjectURL(url);
    setPhotos((current) => current.filter((item) => item.url !== url));
  }

  function insertMention(nick: string) {
    composerRef.current?.insertText(` @${nick}`);
  }

  function insertSmiley(code: string) {
    composerRef.current?.insertCode(code);
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
      title={title ?? t('me.composerTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={submit} disabled={submitting}>
            {submitLabel ?? t('me.post')}
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

      <SmileyInput
        ref={composerRef}
        value={content}
        onChange={setContent}
        placeholder={t('me.composerHint')}
        multiline
        className="mt-3 max-h-60 min-h-24 w-full overflow-y-auto rounded-md border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary"
      />

      <ComposerPreview
        sticker={sticker}
        checkIn={checkIn}
        photos={photos}
        maxReached={photos.length >= MAX_IMAGES}
        onRemoveSticker={() => setSticker(null)}
        onRemoveCheckIn={() => setCheckIn(null)}
        onRemovePhoto={removePhoto}
      />

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

      <ComposerAttachPanels
        panel={panel}
        onMention={insertMention}
        onSticker={(code) => {
          setSticker(code);
          setPanel(null);
        }}
        onCheckIn={(value) => {
          setCheckIn(value);
          setPanel(null);
        }}
        onSmiley={insertSmiley}
      />

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

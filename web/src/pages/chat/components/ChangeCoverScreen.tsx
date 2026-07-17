import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { MeService, UserService } from '@services';
import { compressImageForUpload, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { MIN_SOURCE_WIDTH } from '../constants';
import { COVER_ASPECT } from '../../profile/constants';
import { CoverCropOverlay } from '../../profile/components/CoverCropOverlay';
import { CheckIcon } from './Icons';

interface ChangeCoverScreenProps {
  open: boolean;
  onClose: () => void;
}

function readImageSize(url: string): Promise<{ width: number; height: number }> {
  return new Promise((resolve, reject) => {
    const probe = new Image();
    probe.onload = () => resolve({ width: probe.naturalWidth, height: probe.naturalHeight });
    probe.onerror = () => reject(new Error('decode failed'));
    probe.src = url;
  });
}

export function ChangeCoverScreen({ open, onClose }: ChangeCoverScreenProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const previewRef = useRef<string | null>(null);
  const rawRef = useRef<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [rawSrc, setRawSrc] = useState<string | null>(null);
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [postToMe, setPostToMe] = useState(false);
  const [saving, setSaving] = useState(false);

  function setCropped(next: File | null) {
    if (previewRef.current) URL.revokeObjectURL(previewRef.current);
    previewRef.current = next ? URL.createObjectURL(next) : null;
    setPreview(previewRef.current);
    setFile(next);
  }

  function clearRaw() {
    if (rawRef.current) URL.revokeObjectURL(rawRef.current);
    rawRef.current = null;
    setRawSrc(null);
  }

  useEffect(
    () => () => {
      if (previewRef.current) URL.revokeObjectURL(previewRef.current);
      if (rawRef.current) URL.revokeObjectURL(rawRef.current);
    },
    []
  );

  function close() {
    if (saving) return;
    setCropped(null);
    clearRaw();
    setPostToMe(false);
    onClose();
  }

  async function handleFile(event: React.ChangeEvent<HTMLInputElement>) {
    const picked = event.target.files?.[0];
    event.target.value = '';
    if (!picked) return;
    const url = URL.createObjectURL(picked);
    try {
      const size = await readImageSize(url);
      if (Math.min(size.width, size.height) < MIN_SOURCE_WIDTH) {
        URL.revokeObjectURL(url);
        toast.error(t('cover.tooSmall'));
        return;
      }
    } catch {
      URL.revokeObjectURL(url);
      toast.error(t('cover.error'));
      return;
    }
    clearRaw();
    rawRef.current = url;
    setRawSrc(url);
  }

  async function save() {
    if (!file || saving) return;
    setSaving(true);
    try {
      const uploaded = await UserService.uploadAvatar(await compressImageForUpload(file));
      await UserService.updateMe({ coverPhoto: uploaded.url });
      if (postToMe) {
        await MeService.create({
          content: t('cover.postContent'),
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      toast.success(t('cover.success'));
      setSaving(false);
      setCropped(null);
      setPostToMe(false);
      onClose();
    } catch {
      toast.error(t('cover.error'));
      setSaving(false);
    }
  }

  if (!open || !user) return null;

  if (rawSrc != null) {
    return (
      <CoverCropOverlay
        src={rawSrc}
        aspect={COVER_ASPECT}
        onCancel={clearRaw}
        onApply={(cropped) => {
          setCropped(cropped);
          clearRaw();
        }}
      />
    );
  }

  const shownCover = preview ?? user.coverPhoto ?? '';

  return (
    <Dialog
      open
      onClose={close}
      dismissOnBackdrop={!saving}
      title={t('cover.title')}
      footer={
        <>
          <DialogButton variant="green" onClick={save} disabled={saving || !file}>
            {saving ? t('cover.saving') : t('cover.save')}
          </DialogButton>
          <DialogButton variant="default" onClick={close} disabled={saving}>
            {t('cover.cancel')}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col items-center py-2">
        <input
          ref={fileInputRef}
          type="file"
          accept="image/*"
          className="hidden"
          onChange={handleFile}
        />
        <button
          type="button"
          onClick={() => fileInputRef.current?.click()}
          disabled={saving}
          style={{ aspectRatio: String(COVER_ASPECT) }}
          className="relative w-full overflow-hidden rounded-lg bg-black/5 disabled:opacity-60"
          aria-label={t('cover.title')}
        >
          {shownCover ? (
            <img src={shownCover} alt="" className="h-full w-full object-cover" />
          ) : (
            <span className="flex h-full w-full items-center justify-center px-4 text-center text-sm text-black/40">
              {t('cover.changeHint')}
            </span>
          )}
        </button>

        <p className="mt-3 text-xs text-black/54">{t('cover.changeHint')}</p>

        <label className="mt-6 flex cursor-pointer items-center justify-center gap-3">
          <input
            type="checkbox"
            checked={postToMe}
            onChange={(event) => setPostToMe(event.target.checked)}
            className="sr-only"
          />
          <span
            className={`flex h-5 w-5 shrink-0 items-center justify-center rounded border ${
              postToMe ? 'border-ola-primary bg-ola-primary' : 'border-black/30'
            }`}
          >
            {postToMe && <CheckIcon />}
          </span>
          <span className="text-sm text-black/87">{t('cover.postToMe')}</span>
        </label>
      </div>
    </Dialog>
  );
}

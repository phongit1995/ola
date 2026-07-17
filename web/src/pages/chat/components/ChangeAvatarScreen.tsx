import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog, DialogButton } from '@components';
import { MeService, UserService } from '@services';
import { colorForName, compressImageForUpload, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { MIN_SOURCE_WIDTH } from '../constants';
import { CoverCropOverlay } from '../../profile/components/CoverCropOverlay';
import { CameraIcon, CheckIcon } from './Icons';

interface ChangeAvatarScreenProps {
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

export function ChangeAvatarScreen({ open, onClose }: ChangeAvatarScreenProps) {
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

  function setPicked(next: File | null) {
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
    setPicked(null);
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
        toast.error(t('avatar.tooSmall'));
        return;
      }
    } catch {
      URL.revokeObjectURL(url);
      toast.error(t('avatar.error'));
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
      await UserService.updateMe({ avatar: uploaded.url });
      if (postToMe) {
        await MeService.create({
          content: t('avatar.postContent'),
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      toast.success(t('avatar.success'));
      setSaving(false);
      setPicked(null);
      setPostToMe(false);
      onClose();
    } catch {
      toast.error(t('avatar.error'));
      setSaving(false);
    }
  }

  if (!open || !user) return null;

  if (rawSrc != null) {
    return (
      <CoverCropOverlay
        src={rawSrc}
        aspect={1}
        onCancel={clearRaw}
        onApply={(cropped) => {
          setPicked(cropped);
          clearRaw();
        }}
      />
    );
  }

  const nick = user.fullName || user.username;
  const shownAvatar = preview ?? user.avatar ?? '';

  return (
    <Dialog
      open
      onClose={close}
      dismissOnBackdrop={!saving}
      title={t('avatar.title')}
      footer={
        <>
          <DialogButton variant="green" onClick={save} disabled={saving || !file}>
            {saving ? t('avatar.saving') : t('avatar.save')}
          </DialogButton>
          <DialogButton variant="default" onClick={close} disabled={saving}>
            {t('avatar.cancel')}
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
          className="relative disabled:opacity-60"
          aria-label={t('avatar.title')}
        >
          {shownAvatar ? (
            <img src={shownAvatar} alt="" className="h-28 w-28 rounded-full object-cover" />
          ) : (
            <Avatar name={nick} color={colorForName(nick)} size={112} />
          )}
          <span className="absolute bottom-0 right-0 flex h-8 w-8 items-center justify-center rounded-full border-2 border-white bg-ola-primary text-white">
            <CameraIcon />
          </span>
        </button>

        <p className="mt-3 text-xs text-black/54">{t('avatar.changeHint')}</p>

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
          <span className="text-sm text-black/87">{t('avatar.postToMe')}</span>
        </label>
      </div>
    </Dialog>
  );
}

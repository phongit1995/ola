import { useEffect, useRef, useState } from 'react';
import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, ImageCropOverlay } from '@components';
import { MeService, UserService } from '@services';
import { compressImageForUpload, imageUploadErrorText, toast, validatedImageObjectUrl } from '@lib';
import { MIN_IMAGE_SOURCE } from '@constants';
import { useAuthStore } from '@/store/authStore';
import { CheckIcon } from './Icons';

interface ChangeUserImageTexts {
  title: string;
  tooSmall: string;
  error: string;
  success: string;
  saving: string;
  save: string;
  cancel: string;
  changeHint: string;
  postToMe: string;
  postContent: string;
}

interface PickerRenderProps {
  shown: string;
  saving: boolean;
  openPicker: () => void;
}

interface ChangeUserImageDialogProps {
  onClose: () => void;
  aspect: number;
  currentUrl: string;
  texts: ChangeUserImageTexts;
  buildUpdate: (url: string) => Parameters<typeof UserService.updateMe>[0];
  renderPicker: (picker: PickerRenderProps) => ReactNode;
}

export function ChangeUserImageDialog({
  onClose,
  aspect,
  currentUrl,
  texts,
  buildUpdate,
  renderPicker,
}: ChangeUserImageDialogProps) {
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const previewRef = useRef<string | null>(null);
  const rawRef = useRef<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const { t } = useTranslation();
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

  function openPicker() {
    fileInputRef.current?.click();
  }

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
    const url = await validatedImageObjectUrl(picked, MIN_IMAGE_SOURCE, texts);
    if (!url) return;
    clearRaw();
    rawRef.current = url;
    setRawSrc(url);
  }

  async function save() {
    if (!file || saving) return;
    setSaving(true);
    try {
      const uploaded = await UserService.uploadAvatar(
        await compressImageForUpload(file)
      );
      await UserService.updateMe(buildUpdate(uploaded.url));
      if (postToMe) {
        await MeService.create({
          content: texts.postContent,
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      toast.success(texts.success);
      setSaving(false);
      setCropped(null);
      setPostToMe(false);
      onClose();
    } catch (error) {
      toast.error(imageUploadErrorText(t, error, texts.error));
      setSaving(false);
    }
  }

  if (rawSrc != null) {
    return (
      <ImageCropOverlay
        src={rawSrc}
        aspect={aspect}
        onCancel={clearRaw}
        onApply={(cropped) => {
          setCropped(cropped);
          clearRaw();
        }}
      />
    );
  }

  return (
    <Dialog
      open
      onClose={close}
      dismissOnBackdrop={!saving}
      title={texts.title}
      footer={
        <>
          <DialogButton
            variant="green"
            onClick={save}
            disabled={saving || !file}
          >
            {saving ? texts.saving : texts.save}
          </DialogButton>
          <DialogButton variant="default" onClick={close} disabled={saving}>
            {texts.cancel}
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
        {/* eslint-disable-next-line react-hooks/refs -- openPicker chỉ được gọi trong onClick, không trong render */}
        {renderPicker({ shown: preview ?? currentUrl, saving, openPicker })}

        <p className="mt-3 text-xs text-black/54">{texts.changeHint}</p>

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
          <span className="text-sm text-black/87">{texts.postToMe}</span>
        </label>
      </div>
    </Dialog>
  );
}

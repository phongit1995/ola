import { useEffect, useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { compressImageForUpload, imageUploadErrorText, toast } from '@lib';
import type { PendingImage } from './types';

interface PendingChatImageOptions {
  sendImage: (file: File) => Promise<unknown>;
  onBeforeAdd: () => void;
  onBeforeSend: () => void;
}

export function usePendingChatImage({
  sendImage,
  onBeforeAdd,
  onBeforeSend,
}: PendingChatImageOptions) {
  const { t } = useTranslation();
  const [pendingImage, setPendingImage] = useState<PendingImage | null>(null);
  const imageIdRef = useRef(0);
  const pendingImageRef = useRef(pendingImage);

  useEffect(() => {
    pendingImageRef.current = pendingImage;
  }, [pendingImage]);
  useEffect(
    () => () => {
      if (pendingImageRef.current != null)
        URL.revokeObjectURL(pendingImageRef.current.url);
    },
    []
  );

  async function addImageFile(files: File[]) {
    const file = files[0];
    if (file == null) return;
    onBeforeAdd();
    try {
      const prepared = await compressImageForUpload(file);
      const url = URL.createObjectURL(prepared);
      imageIdRef.current += 1;
      const id = String(imageIdRef.current);
      setPendingImage((current) => {
        if (current != null) URL.revokeObjectURL(current.url);
        return { id, file: prepared, url };
      });
    } catch (error) {
      toast.error(imageUploadErrorText(t, error, t('chat.imageError')));
    }
  }

  function clearPendingImage() {
    setPendingImage((current) => {
      if (current != null) URL.revokeObjectURL(current.url);
      return null;
    });
  }

  async function sendPendingImage() {
    const image = pendingImage;
    if (image == null) return;
    setPendingImage(null);
    onBeforeSend();
    await sendImage(image.file);
    URL.revokeObjectURL(image.url);
  }

  async function handleFileChange(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    await addImageFile(files);
  }

  return {
    pendingImage,
    addImageFile,
    clearPendingImage,
    sendPendingImage,
    handleFileChange,
  };
}

import { useRef, useState } from 'react';
import { Keyboard } from 'react-native';
import { useTranslation } from 'react-i18next';
import { launchCamera, launchImageLibrary, type Asset } from 'react-native-image-picker';
import { imageUploadErrorText } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { NativeUploadFile } from '@ola/shared/types';
import type { PendingComposerImage } from '@components/chat/composerTypes';
import { compressImageForUpload } from '@lib/compressImage';
import { pastedImageFile, uploadFileFromAsset } from '@lib/imagePicker';

interface PendingChatImagesOptions {
  sendImage: (file: NativeUploadFile) => Promise<unknown>;
  onBeforeQueue: () => void;
  onBeforeSend: () => void;
  refocusComposer: () => void;
}

export function usePendingChatImages({
  sendImage,
  onBeforeQueue,
  onBeforeSend,
  refocusComposer,
}: PendingChatImagesOptions) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [pendingImages, setPendingImages] = useState<PendingComposerImage[]>([]);
  const imageIdRef = useRef(0);

  async function compressAndSend(file: NativeUploadFile) {
    try {
      const prepared = await compressImageForUpload(file);
      await sendImage(prepared);
    } catch (err) {
      push('error', imageUploadErrorText(t, err, t('chat.imageError')));
    }
  }

  function queuePickedAssets(assets: Asset[]) {
    if (assets.length === 0) return;
    onBeforeQueue();
    setPendingImages((current) => {
      const next = [...current];
      for (const asset of assets) {
        if (asset.uri == null) continue;
        imageIdRef.current += 1;
        next.push({
          id: String(imageIdRef.current),
          uri: asset.uri,
          file: uploadFileFromAsset({ ...asset, uri: asset.uri }),
        });
      }
      return next;
    });
  }

  function queuePastedImage(uri: string) {
    onBeforeQueue();
    imageIdRef.current += 1;
    const id = String(imageIdRef.current);
    setPendingImages((current) => [...current, { id, uri, file: pastedImageFile(uri) }]);
  }

  function removePendingImage(id: string) {
    setPendingImages((current) => current.filter((image) => image.id !== id));
  }

  function clearPendingImages() {
    setPendingImages([]);
  }

  async function sendPendingImages() {
    const images = pendingImages;
    if (images.length === 0) return;
    setPendingImages([]);
    onBeforeSend();
    for (const image of images) {
      await compressAndSend(image.file);
    }
  }

  async function pickImages() {
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: 0,
    });
    if (keyboardWasVisible) requestAnimationFrame(refocusComposer);
    if (result.didCancel) return;
    queuePickedAssets(result.assets ?? []);
  }

  async function capturePhoto() {
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchCamera({
      mediaType: 'photo',
      saveToPhotos: false,
    });
    if (keyboardWasVisible) requestAnimationFrame(refocusComposer);
    if (result.didCancel) return;
    if (result.errorCode != null) {
      push('error', t('chat.imageError'));
      return;
    }
    queuePickedAssets(result.assets ?? []);
  }

  return {
    pendingImages,
    queuePastedImage,
    removePendingImage,
    clearPendingImages,
    sendPendingImages,
    pickImages,
    capturePhoto,
  };
}

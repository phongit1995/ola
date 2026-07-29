import { useCallback, useEffect, useState } from 'react';
import { ImageCropOverlay } from './ImageCropOverlay';
import { ImagePreviewOverlay } from './ImagePreviewOverlay';

interface ImageCropEditorProps {
  src: string;
  aspect: number;
  busy?: boolean;
  onCancel: () => void;
  onApply: (file: File) => void | Promise<void>;
}

export function ImageCropEditor({
  src,
  aspect,
  busy,
  onCancel,
  onApply,
}: ImageCropEditorProps) {
  const [cropped, setCropped] = useState<{ url: string; file: File } | null>(
    null
  );

  const clearCropped = useCallback(() => {
    setCropped((prev) => {
      if (prev) URL.revokeObjectURL(prev.url);
      return null;
    });
  }, []);

  useEffect(() => clearCropped, [clearCropped]);

  if (cropped) {
    return (
      <ImagePreviewOverlay
        url={cropped.url}
        uploading={busy ?? false}
        onCancel={clearCropped}
        onConfirm={() => onApply(cropped.file)}
      />
    );
  }

  return (
    <ImageCropOverlay
      src={src}
      aspect={aspect}
      onCancel={onCancel}
      onApply={(file) => setCropped({ url: URL.createObjectURL(file), file })}
    />
  );
}

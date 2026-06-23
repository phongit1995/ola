import { useCallback, useEffect, useState } from 'react';
import { CoverCropOverlay } from './CoverCropOverlay';
import { CoverPreviewOverlay } from './CoverPreviewOverlay';

interface CoverImageEditorProps {
  src: string;
  aspect: number;
  busy?: boolean;
  onCancel: () => void;
  onApply: (file: File) => void | Promise<void>;
}

export function CoverImageEditor({ src, aspect, busy, onCancel, onApply }: CoverImageEditorProps) {
  const [cropped, setCropped] = useState<{ url: string; file: File } | null>(null);

  const clearCropped = useCallback(() => {
    setCropped((prev) => {
      if (prev) URL.revokeObjectURL(prev.url);
      return null;
    });
  }, []);

  useEffect(() => clearCropped, [clearCropped]);

  if (cropped) {
    return (
      <CoverPreviewOverlay
        url={cropped.url}
        uploading={busy ?? false}
        onCancel={clearCropped}
        onConfirm={() => onApply(cropped.file)}
      />
    );
  }

  return (
    <CoverCropOverlay
      src={src}
      aspect={aspect}
      onCancel={onCancel}
      onApply={(file) => setCropped({ url: URL.createObjectURL(file), file })}
    />
  );
}

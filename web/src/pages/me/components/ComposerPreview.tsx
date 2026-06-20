import { useTranslation } from 'react-i18next';
import { stickerImage } from '../stickers';
import checkInIcon from '@/assets/icons/me/ic_check_in.png';
import type { ComposedCheckIn } from './ComposerCheckInPanel';

interface ComposerPreviewProps {
  sticker: string | null;
  checkIn: ComposedCheckIn | null;
  photos: { url: string }[];
  maxReached: boolean;
  onRemoveSticker: () => void;
  onRemoveCheckIn: () => void;
  onRemovePhoto: (url: string) => void;
}

export function ComposerPreview({
  sticker,
  checkIn,
  photos,
  maxReached,
  onRemoveSticker,
  onRemoveCheckIn,
  onRemovePhoto,
}: ComposerPreviewProps) {
  const { t } = useTranslation();

  return (
    <>
      {sticker != null && stickerImage(sticker) != null && (
        <div className="relative mt-2 rounded-md border border-black/12 p-2 pr-20">
          <img src={stickerImage(sticker) ?? ''} alt="" className="h-16 w-16 object-contain" />
          <button
            type="button"
            onClick={onRemoveSticker}
            className="absolute right-1 top-1/2 -translate-y-1/2 text-xs text-ola-error"
          >
            {t('me.removeSticker')}
          </button>
        </div>
      )}

      {checkIn != null && (
        <div className="relative mt-2 rounded-md border border-black/12 p-2 pr-20 text-sm text-black/54">
          <div className="flex items-center gap-2">
            <img src={checkInIcon} alt="" className="h-7 w-7 shrink-0 object-contain" />
            <span className="min-w-0 flex-1">
              {(checkIn.action ?? '') !== '' && (
                <span className="block truncate text-black/87">
                  {checkIn.actionIcon} {checkIn.action}
                </span>
              )}
              <span className="block truncate text-xs text-black/40">{checkIn.name}</span>
            </span>
          </div>
          <button
            type="button"
            onClick={onRemoveCheckIn}
            className="absolute right-1 top-1/2 -translate-y-1/2 text-xs text-ola-error"
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
                onClick={() => onRemovePhoto(photo.url)}
                className="absolute right-1 top-1 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-sm leading-none text-white"
              >
                ×
              </button>
            </div>
          ))}
        </div>
      )}

      {maxReached && <p className="mt-1 text-xs text-black/40">{t('me.maxImages')}</p>}
    </>
  );
}

import { useTranslation } from 'react-i18next';

interface ProfileMediaStoreProps {
  media: string[];
}

export function ProfileMediaStore({ media }: ProfileMediaStoreProps) {
  const { t } = useTranslation();
  return (
    <div className="mb-2 bg-white pb-3 shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <h3 className="mx-4 py-2 text-base text-black/54">{t('profile.mediaStore')}</h3>
      <div className="grid grid-cols-3 gap-1 px-2">
        {media.map((color, index) => (
          <span
            key={index}
            className="aspect-square w-full"
            style={{ backgroundColor: color }}
          />
        ))}
      </div>
      <button type="button" className="mt-3 block w-full text-center text-sm text-black/54">
        {t('profile.viewAllPhotos')}
      </button>
    </div>
  );
}

import { useTranslation } from 'react-i18next';
import { GeoService } from '@services';
import type { MeCheckIn } from '../types';

interface CheckInCardProps {
  checkIn: MeCheckIn;
  label: string;
}

export function CheckInCard({ checkIn, label }: CheckInCardProps) {
  const { t } = useTranslation();
  const cover =
    checkIn.lat != null && checkIn.lng != null ? GeoService.staticMap(checkIn.lat, checkIn.lng) : '';

  return (
    <div className="mx-4 mt-3 overflow-hidden rounded">
      <div className="relative h-32 bg-gradient-to-br from-ola-primary to-ola-primary-darker">
        {cover !== '' && <img src={cover} alt="" className="h-full w-full object-cover" />}
        <div className="absolute inset-x-0 bottom-0 flex items-center gap-2 bg-black/50 px-3 py-2 text-white">
          <span className="text-lg leading-none">📍</span>
          <span className="min-w-0 flex-1">
            <span className="block text-xs text-white/80">{t('me.checkInAction')}</span>
            <span className="block truncate text-sm">{checkIn.name}</span>
          </span>
          <span aria-label={label} className="text-base text-white/80">
            ›
          </span>
        </div>
      </div>
    </div>
  );
}

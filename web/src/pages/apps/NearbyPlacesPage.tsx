import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';
import { MOCK_VENUES } from './constants';

export interface Venue {
  id: string;
  name: string;
  distance: string;
  visits: number;
  address: string;
  cover: string;
}

function ArrowIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-6 w-6 text-black/30"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
    </svg>
  );
}

export function NearbyPlacesPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();

  function comingSoon() {
    toast.info(t('nearby.comingSoon'));
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('nearby.title')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-white">
        <ul>
          {MOCK_VENUES.map((venue) => (
            <li key={venue.id} className="border-b border-[#e6e6e6]">
              <button
                type="button"
                onClick={comingSoon}
                className="flex w-full items-stretch p-4 text-left active:bg-black/5"
              >
                <span
                  className="h-16 w-16 shrink-0 self-center rounded-sm shadow"
                  style={{ background: venue.cover }}
                />
                <span className="ml-2 flex min-w-0 flex-1 flex-col justify-between">
                  <span className="truncate text-base font-bold text-black/87">
                    {venue.name}
                  </span>
                  <span className="flex items-center gap-1 text-sm">
                    <span className="text-[#7a7a7a]">
                      {t('nearby.distance')}
                    </span>
                    <span className="text-[#5b9bd5]">{venue.distance}</span>
                    <span className="truncate text-black/54">
                      · {t('nearby.checkedIn', { count: venue.visits })}
                    </span>
                  </span>
                  <span className="truncate text-xs italic text-black/54">
                    {venue.address}
                  </span>
                </span>
                <span className="flex shrink-0 items-center">
                  <ArrowIcon />
                </span>
              </button>
            </li>
          ))}
        </ul>
      </div>
    </FullScreenOverlay>
  );
}

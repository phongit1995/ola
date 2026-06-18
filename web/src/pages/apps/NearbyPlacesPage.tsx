import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';

interface Venue {
  id: string;
  name: string;
  distance: string;
  visits: number;
  address: string;
  cover: string;
}

const MOCK_VENUES: Venue[] = [
  { id: '1', name: 'Highlands Coffee', distance: '120 m', visits: 342, address: '12 Nguyễn Huệ, Q.1', cover: 'linear-gradient(135deg,#8d6e63,#4e342e)' },
  { id: '2', name: 'Vincom Center', distance: '450 m', visits: 1280, address: '72 Lê Thánh Tôn, Q.1', cover: 'linear-gradient(135deg,#90a4ae,#37474f)' },
  { id: '3', name: 'Công viên 23/9', distance: '1,2 km', visits: 560, address: 'Phạm Ngũ Lão, Q.1', cover: 'linear-gradient(135deg,#aed581,#558b2f)' },
  { id: '4', name: 'Nhà thờ Đức Bà', distance: '1,5 km', visits: 2104, address: '1 Công xã Paris, Q.1', cover: 'linear-gradient(135deg,#ffb74d,#e65100)' },
  { id: '5', name: 'Phố đi bộ Bùi Viện', distance: '1,8 km', visits: 980, address: 'Bùi Viện, Q.1', cover: 'linear-gradient(135deg,#ba68c8,#6a1b9a)' },
];

function ArrowIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-6 w-6 text-black/30" fill="currentColor" aria-hidden="true">
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
    </svg>
  );
}

export function NearbyPlacesPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  function comingSoon() {
    toast.info(t('nearby.comingSoon'));
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('nearby.title')} onBack={() => navigate(ROUTES.home)} />

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
                  <span className="truncate text-base font-bold text-black/87">{venue.name}</span>
                  <span className="flex items-center gap-1 text-sm">
                    <span className="text-[#7a7a7a]">{t('nearby.distance')}</span>
                    <span className="text-[#5b9bd5]">{venue.distance}</span>
                    <span className="truncate text-black/54">
                      · {t('nearby.checkedIn', { count: venue.visits })}
                    </span>
                  </span>
                  <span className="truncate text-xs italic text-black/54">{venue.address}</span>
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

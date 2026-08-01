import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { CheckInAction, GeoVenue } from '@ola/shared/types';
import { GeoService } from '@services';
import { toast } from '@lib';
import checkInIcon from '@/assets/icons/me/ic_check_in.png';
import { CHECK_IN_ACTIONS } from '../checkInActions';

export type ComposedCheckIn = GeoVenue & {
  action?: string;
  actionIcon?: string;
};

interface ComposerCheckInPanelProps {
  onSelect: (checkIn: ComposedCheckIn) => void;
}

export function ComposerCheckInPanel({ onSelect }: ComposerCheckInPanelProps) {
  const { t } = useTranslation();
  const [action, setAction] = useState<CheckInAction | null>(null);
  const [nearby, setNearby] = useState<GeoVenue[]>([]);
  const [current, setCurrent] = useState<GeoVenue | null>(null);
  const [locating, setLocating] = useState(false);
  const [locateError, setLocateError] = useState(false);
  const hasLocated = useRef(false);

  function chooseAction(item: CheckInAction) {
    setAction(item);
    if (!hasLocated.current) {
      hasLocated.current = true;
      locate();
    }
  }

  function locate() {
    if (!GeoService.enabled || !('geolocation' in navigator)) {
      setLocateError(true);
      toast.error(t('me.checkInError'));
      return;
    }
    setLocating(true);
    setLocateError(false);
    navigator.geolocation.getCurrentPosition(
      async (pos) => {
        const { latitude, longitude } = pos.coords;
        try {
          const [venues, here] = await Promise.all([
            GeoService.nearby(latitude, longitude),
            GeoService.reverse(latitude, longitude).catch(() => null),
          ]);
          setNearby(venues);
          setCurrent(
            here ?? {
              name: t('me.checkInCurrent'),
              address: '',
              lat: latitude,
              lng: longitude,
            }
          );
        } catch {
          setLocateError(true);
          toast.error(t('me.checkInError'));
        } finally {
          setLocating(false);
        }
      },
      () => {
        setLocating(false);
        setLocateError(true);
        toast.error(t('me.checkInError'));
      },
      { enableHighAccuracy: true, timeout: 10000 }
    );
  }

  function pick(venue: GeoVenue) {
    if (action == null) return;
    onSelect({ ...venue, action: action.text, actionIcon: action.icon });
  }

  return (
    <div className="mt-2 overflow-hidden rounded-md border border-black/12">
      <div className="border-b border-black/12 p-2">
        <p className="text-sm font-medium text-black/87">
          {t('me.checkInWhat')}
        </p>
        <div className="mt-2 flex flex-wrap gap-1">
          {CHECK_IN_ACTIONS.map((item) => (
            <button
              key={item.text}
              type="button"
              onClick={() => chooseAction(item)}
              className={`flex items-center gap-1 rounded-full border px-2 py-1 text-xs ${
                action?.text === item.text
                  ? 'border-ola-primary bg-ola-primary-light text-ola-primary'
                  : 'border-black/12 text-black/54'
              }`}
            >
              <span>{item.icon}</span>
              {item.text}
            </button>
          ))}
        </div>
        {action == null && (
          <p className="mt-2 text-xs text-black/40">
            {t('me.checkInPickActionFirst')}
          </p>
        )}
      </div>
      {action != null && (
        <>
          <button
            type="button"
            onClick={locate}
            disabled={locating}
            className="flex w-full items-center gap-2 border-b border-black/12 px-3 py-2 text-left text-sm text-ola-primary disabled:opacity-50"
          >
            <span>📡</span>
            {locating ? t('me.checkInLocating') : t('me.checkInLocate')}
          </button>
          {current != null && (
            <button
              type="button"
              onClick={() => pick(current)}
              className="flex w-full items-center gap-2 border-b border-black/12 px-3 py-2 text-left text-sm text-black/87 hover:bg-ola-primary-light"
            >
              <img
                src={checkInIcon}
                alt=""
                className="h-6 w-6 shrink-0 object-contain"
              />
              <span className="min-w-0 flex-1">
                <span className="block truncate text-ola-primary">
                  {t('me.checkInCurrent')}
                </span>
                {(current.name !== '' || current.address !== '') && (
                  <span className="block truncate text-xs text-black/40">
                    {current.name !== '' ? current.name : current.address}
                  </span>
                )}
              </span>
            </button>
          )}
          {locateError && (
            <p className="px-3 py-2 text-xs text-ola-error">
              {t('me.checkInError')}
            </p>
          )}
          {!locating && !locateError && nearby.length === 0 && (
            <p className="px-3 py-2 text-xs text-black/40">
              {t('me.checkInNoVenues')}
            </p>
          )}
          <div className="max-h-44 overflow-y-auto">
            {nearby.map((venue) => (
              <button
                key={`${venue.name}-${venue.lat}-${venue.lng}`}
                type="button"
                onClick={() => pick(venue)}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm text-black/87 hover:bg-ola-primary-light"
              >
                <span>📍</span>
                <span className="min-w-0 flex-1">
                  <span className="block truncate">{venue.name}</span>
                  {venue.address !== '' && (
                    <span className="block truncate text-xs text-black/40">
                      {venue.address}
                    </span>
                  )}
                </span>
              </button>
            ))}
          </div>
        </>
      )}
    </div>
  );
}

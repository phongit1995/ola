import { GeoService } from '@services';
import checkInIcon from '@/assets/icons/me/ic_check_in.png';
import type { MeCheckIn } from '../types';

interface CheckInCardProps {
  checkIn: MeCheckIn;
  label: string;
}

export function CheckInCard({ checkIn, label }: CheckInCardProps) {
  const address = checkIn.address?.trim() ?? '';
  const action = checkIn.action?.trim() ?? '';
  const hasAction = action !== '';
  const actionIcon = checkIn.actionIcon?.trim() ?? '';
  const hasCoords = checkIn.lat != null && checkIn.lng != null;
  const mapLink = hasCoords
    ? GeoService.mapLink(checkIn.lat!, checkIn.lng!)
    : '';

  const primary = hasAction ? `${actionIcon} ${action}`.trim() : checkIn.name;
  const secondary = hasAction ? checkIn.name : address;

  const inner = (
    <>
      <img
        src={checkInIcon}
        alt=""
        className="h-7 w-7 shrink-0 object-contain"
      />
      <span className="min-w-0 flex-1">
        <span className="block truncate text-sm text-black/87">{primary}</span>
        {secondary !== '' && (
          <span className="block truncate text-xs text-black/54">
            {secondary}
          </span>
        )}
      </span>
      {hasCoords && <span className="shrink-0 text-lg text-black/40">›</span>}
    </>
  );

  const className =
    'mx-4 mt-3 flex items-center gap-3 rounded border border-black/10 bg-white px-3 py-2.5';

  if (!hasCoords) {
    return <div className={className}>{inner}</div>;
  }

  return (
    <a
      href={mapLink}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      className={`${className} transition hover:bg-black/[0.03]`}
    >
      {inner}
    </a>
  );
}

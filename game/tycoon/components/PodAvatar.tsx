import { avatarIconUrl, seatColor } from '../helpers/player';

export function PodAvatar({ vipType, src, seat, size = 36 }: { vipType?: string | null; src?: string; seat?: number; size?: number }) {
  const ring = seat != null ? seatColor(seat) : 'var(--ty-navy)';
  return (
    <div className="ty-pod-avatar" style={{ width: size, height: size, boxShadow: `0 0 0 2px ${ring}` }}>
      <img className="ty-pod-avatar-img" src={src ?? avatarIconUrl(vipType)} alt="" draggable={false} />
    </div>
  );
}

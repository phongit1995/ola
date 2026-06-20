import { vipIconUrl } from '@lib';

interface VipIconProps {
  typeId?: number | null;
  src?: string;
  className?: string;
}

export function VipIcon({ typeId, src, className = 'h-4 w-4' }: VipIconProps) {
  const url = src ?? (typeId != null ? vipIconUrl(typeId) : '');
  if (url === '') return null;
  return <img src={url} alt="" className={`${className} shrink-0 object-contain`} />;
}

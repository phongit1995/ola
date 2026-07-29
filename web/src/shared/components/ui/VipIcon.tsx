import { vipIconUrl } from '@lib';

interface VipIconProps {
  typeId?: number | null;
  src?: string;
  className?: string;
  size?: number;
  rounded?: boolean;
  alt?: string;
}

export function VipIcon({
  typeId,
  src,
  className = 'h-4 w-4',
  size,
  rounded = false,
  alt = '',
}: VipIconProps) {
  const url = src ?? (typeId != null ? vipIconUrl(typeId) : '');
  if (url === '') return null;
  const shape = rounded ? 'rounded ' : '';
  if (size != null) {
    return (
      <img
        src={url}
        alt={alt}
        width={size}
        height={size}
        className={`${shape}shrink-0 object-contain`}
        style={{ width: size, height: size }}
      />
    );
  }
  return (
    <img
      src={url}
      alt={alt}
      className={`${shape}${className} shrink-0 object-contain`}
    />
  );
}

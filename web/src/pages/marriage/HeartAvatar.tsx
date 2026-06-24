const HEART_PATH =
  'M16 29 C16 29 1 18.5 1 8.6 C1 4.2 4.5 1 8.5 1 C11.6 1 14.4 3 16 5.7 C17.6 3 20.4 1 23.5 1 C27.5 1 31 4.2 31 8.6 C31 18.5 16 29 16 29 Z';

interface HeartAvatarProps {
  name: string;
  color: string;
  size: number;
  idKey: string;
  src?: string;
}

export function HeartAvatar({ name, color, size, idKey, src }: HeartAvatarProps) {
  const clipId = `heart-clip-${idKey}`;
  const height = (size * 29.6) / 32;
  return (
    <svg width={size} height={height} viewBox="0 0 32 29.6" className="shrink-0">
      <defs>
        <clipPath id={clipId}>
          <path d={HEART_PATH} />
        </clipPath>
      </defs>
      {src != null && src !== '' ? (
        <image
          href={src}
          width="32"
          height="29.6"
          preserveAspectRatio="xMidYMid slice"
          clipPath={`url(#${clipId})`}
        />
      ) : (
        <g clipPath={`url(#${clipId})`}>
          <rect width="32" height="29.6" fill={color} />
          <text x="16" y="18" textAnchor="middle" fontSize="13" fontWeight="600" fill="#ffffff">
            {name.charAt(0).toUpperCase()}
          </text>
        </g>
      )}
      <path d={HEART_PATH} fill="none" stroke="#ff4d7d" strokeWidth="1.2" />
    </svg>
  );
}

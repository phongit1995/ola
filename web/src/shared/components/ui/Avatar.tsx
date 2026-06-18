interface AvatarProps {
  name: string;
  color: string;
  size?: number;
  src?: string;
  rounded?: boolean;
}

export function Avatar({ name, color, size = 40, src, rounded = true }: AvatarProps) {
  const shape = rounded ? 'rounded-full' : 'rounded-none';
  if (src != null && src !== '') {
    return (
      <img
        src={src}
        alt=""
        className={`shrink-0 object-cover ${shape}`}
        style={{ width: size, height: size }}
      />
    );
  }
  return (
    <span
      className={`flex shrink-0 items-center justify-center font-medium text-white ${shape}`}
      style={{
        backgroundColor: color,
        width: size,
        height: size,
        fontSize: size * 0.45,
      }}
    >
      {name.charAt(0).toUpperCase()}
    </span>
  );
}

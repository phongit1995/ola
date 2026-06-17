interface AvatarProps {
  name: string;
  color: string;
  size?: number;
  src?: string;
}

export function Avatar({ name, color, size = 40, src }: AvatarProps) {
  if (src != null && src !== '') {
    return (
      <img
        src={src}
        alt=""
        className="shrink-0 rounded-full object-cover"
        style={{ width: size, height: size }}
      />
    );
  }
  return (
    <span
      className="flex shrink-0 items-center justify-center rounded-full font-medium text-white"
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

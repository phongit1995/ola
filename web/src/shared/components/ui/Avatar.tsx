interface AvatarProps {
  name: string;
  color: string;
  size?: number;
}

export function Avatar({ name, color, size = 40 }: AvatarProps) {
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

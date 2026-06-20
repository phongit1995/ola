interface UserNameProps {
  name: string;
  fullName?: string;
  className?: string;
  fullNameClassName?: string;
}

export function UserName({
  name,
  fullName,
  className = 'truncate text-base text-black/87',
  fullNameClassName = 'text-black/45',
}: UserNameProps) {
  return (
    <span className={className}>
      {name}
      {fullName != null && fullName !== '' && (
        <span className={fullNameClassName}> · {fullName}</span>
      )}
    </span>
  );
}

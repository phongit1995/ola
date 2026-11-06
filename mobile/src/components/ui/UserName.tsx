import { Text, type StyleProp, type TextStyle } from 'react-native';

interface UserNameProps {
  name: string;
  fullName?: string | null;
  className?: string;
  fullNameClassName?: string;
  style?: StyleProp<TextStyle>;
  fullNameStyle?: StyleProp<TextStyle>;
}

export function UserName({
  name,
  fullName,
  className = 'text-base text-ola-ink',
  fullNameClassName = 'text-ola-ink-soft',
  style,
  fullNameStyle,
}: UserNameProps) {
  return (
    <Text numberOfLines={1} className={className} style={style}>
      {name}
      {fullName != null && fullName !== '' && (
        <Text className={fullNameClassName} style={fullNameStyle}>
          {` · ${fullName}`}
        </Text>
      )}
    </Text>
  );
}

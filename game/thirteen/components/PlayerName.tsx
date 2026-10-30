import crownIcon from '../assets/icons/ic-crown.svg';
import { atName, nameColor } from '../helpers/name';

export function PlayerName({
  name,
  self = false,
  owner = false,
}: {
  name: string;
  self?: boolean;
  owner?: boolean;
}) {
  return (
    <span className="tl-player-name" style={self ? undefined : { color: nameColor(name) }}>
      {owner && <img className="tl-name-crown" src={crownIcon} alt="Chủ bàn" />}
      {self ? 'Bạn' : atName(name)}
    </span>
  );
}

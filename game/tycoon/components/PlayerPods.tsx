import { useShallow } from 'zustand/react/shallow';
import { formatDelta, formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { PodAvatar } from './PodAvatar';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

export function PlayerPods() {
  const { players, view, cash, you, moneyFloats, replaying, result, openSheet, tiles } = useTycoon(
    useShallow((s) => ({
      players: s.players,
      view: s.view,
      cash: s.cash,
      you: s.you,
      moneyFloats: s.moneyFloats,
      replaying: s.replaying,
      result: s.result,
      openSheet: s.openSheet,
      tiles: s.tiles,
    })),
  );
  if (!view) return null;
  return (
    <div className={`ty-pods ty-pods-${players.length}`}>
      {players.map((info, seat) => {
        const player = view.players[seat];
        if (!player) return null;
        const active = view.turn === seat && !result;
        const debtor = view.phase === 'debt' && view.debt?.by === seat;
        const owned = tiles.filter((t) => t.owner === seat).length;
        const floats = moneyFloats.filter((f) => f.seat === seat);
        return (
          <button
            key={info.id}
            type="button"
            className={['ty-pod', active ? 'ty-pod-active' : '', player.bankrupt ? 'ty-pod-bankrupt' : '', debtor ? 'ty-pod-debt' : '', seat === you ? 'ty-pod-mine' : ''].join(' ')}
            style={{ '--seat': seatColor(seat) } as React.CSSProperties}
            onClick={() => openSheet({ kind: 'assets', seat })}
            aria-label={`${seat === you ? 'Bạn' : info.name}, ${formatMoney(cash[seat] ?? player.cash)}${player.bankrupt ? ', phá sản' : ''}`}
          >
            <div className="ty-pod-top">
              <PodAvatar src={info.avatar} seat={seat} size={players.length === 4 ? 22 : 28} />
              <span className="ty-pod-name">{seat === you ? 'Bạn' : info.name}</span>
            </div>
            <div className="ty-pod-cash">{player.bankrupt ? 'Phá sản' : formatMoney(cash[seat] ?? player.cash)}</div>
            <div className="ty-pod-chips" aria-hidden="true">
              <span className="ty-pod-chip">
                <TyIcon name="deed" size={12} />
                {owned}
              </span>
              {player.jailCards > 0 ? (
                <span className="ty-pod-chip ty-pod-chip-gold">
                  <TyIcon name="key" size={12} />
                </span>
              ) : null}
              {player.inJail ? (
                <span className="ty-pod-chip ty-pod-chip-jail">
                  <TyIcon name="jail-bars" size={12} />
                </span>
              ) : null}
            </div>
            {active && replaying ? <span className="ty-pod-busy" aria-hidden="true" /> : null}
            {floats.map((f) => (
              <span key={f.seq} className={`ty-money-float ${f.amount > 0 ? 'ty-money-up' : 'ty-money-down'}`}>
                {formatDelta(f.amount)}
              </span>
            ))}
          </button>
        );
      })}
    </div>
  );
}

import { useShallow } from 'zustand/react/shallow';
import { MAX_HOUSES } from '../logic/constants';
import { worthOf } from '../logic/rules-hint';
import { formatDelta, formatMoney } from '../helpers/format';
import { SEAT_SOFT_COLORS, seatColor } from '../helpers/player';
import { PodAvatar } from './PodAvatar';
import { TileGlyph } from './TileGlyph';
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
  const worths = players.map((_, seat) => worthOf(view, seat));
  const maxWorth = Math.max(1, ...worths);
  const leaders = worths.filter((w) => w === maxWorth).length;
  return (
    <div className={`ty-pods ty-pods-${players.length}`}>
      {players.map((info, seat) => {
        const player = view.players[seat];
        if (!player) return null;
        const active = view.turn === seat && !result;
        const debtor = view.phase === 'debt' && view.debt?.by === seat;
        const owned = tiles.filter((t) => t.owner === seat);
        const houses = owned.reduce((sum, t) => sum + (t.houses >= MAX_HOUSES ? 0 : t.houses), 0);
        const hotels = owned.filter((t) => t.houses >= MAX_HOUSES).length;
        const floats = moneyFloats.filter((f) => f.seat === seat);
        const leader = !player.bankrupt && worths[seat] === maxWorth && leaders === 1 && view.moveCount > 0;
        const name = seat === you ? 'Bạn' : info.name;
        return (
          <button
            key={info.id}
            type="button"
            className={['ty-pod', active ? 'ty-pod-active' : '', player.bankrupt ? 'ty-pod-bankrupt' : '', debtor ? 'ty-pod-debt' : '', seat === you ? 'ty-pod-mine' : ''].join(' ')}
            style={{ '--seat': seatColor(seat), '--seat-soft': SEAT_SOFT_COLORS[seat] } as React.CSSProperties}
            onClick={() => openSheet({ kind: 'assets', seat })}
            aria-label={`${name}, tiền mặt ${formatMoney(cash[seat] ?? player.cash)}, tổng tài sản ${formatMoney(worths[seat])}${player.bankrupt ? ', phá sản' : ''}`}
          >
            <span className="ty-pod-head">
              <span className="ty-pod-avatar-wrap">
                <PodAvatar src={info.avatar} seat={seat} size={players.length === 4 ? 22 : 26} />
                {leader ? (
                  <span className="ty-pod-crown" aria-hidden="true">
                    <TileGlyph name="crown" size={13} />
                  </span>
                ) : null}
              </span>
              <span className="ty-pod-name">{name}</span>
            </span>
            <span className="ty-pod-cash">{player.bankrupt ? 'Phá sản' : formatMoney(cash[seat] ?? player.cash)}</span>
            <span className="ty-pod-meta" aria-hidden="true">
              <span className="ty-pod-stat">
                <TyIcon name="deed" size={11} />
                {owned.length}
              </span>
              {houses + hotels > 0 ? (
                <span className="ty-pod-stat ty-pod-stat-jade">
                  <TyIcon name="house" size={11} />
                  {hotels > 0 ? `${hotels} KS${houses > 0 ? `+${houses}` : ''}` : houses}
                </span>
              ) : null}
              {player.jailCards.length > 0 ? (
                <span className="ty-pod-stat ty-pod-stat-gold">
                  <TyIcon name="key" size={11} />
                </span>
              ) : null}
              {player.inJail ? (
                <span className="ty-pod-stat ty-pod-stat-jail">
                  <TyIcon name="jail-bars" size={11} />
                </span>
              ) : null}
            </span>
            <span className="ty-pod-worth" aria-hidden="true">
              <i style={{ width: `${player.bankrupt ? 0 : Math.max(6, (worths[seat] / maxWorth) * 100)}%` }} />
            </span>
            {active ? <span className="ty-pod-turn">{replaying ? 'Đang đi' : seat === you ? 'Lượt bạn' : 'Đang nghĩ'}</span> : null}
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

import type { CSSProperties } from 'react';
import crownIcon from '../../assets/icons/ic-crown.svg';
import { placeLabel } from '../../helpers/seats';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import { PlayerName } from '../../components/PlayerName';
import { useThirteen } from '../../store/useThirteen';

const INSTANT_WIN_LABEL: Record<string, string> = {
  fourTwos: 'Tứ quý heo — tới trắng!',
  dragonStraight: 'Sảnh rồng — tới trắng!',
  fourPairRun: '4 đôi thông — tới trắng!',
  sixPairs: '6 đôi — tới trắng!',
};

const REASON_NOTE: Record<string, string> = {
  disconnect: 'Ván kết thúc do mất kết nối',
  forfeit: 'Ván kết thúc do có người rời bàn',
};

type Tone = 'win' | 'mid' | 'lose' | 'neutral';

const TONE_SUBTITLE: Record<Tone, string> = {
  win: 'Quá đỉnh, ván này là của bạn!',
  mid: 'Ván sau lên Nhất nhé!',
  lose: 'Ván sau gỡ lại nhé!',
  neutral: 'Ván đấu đã kết thúc',
};

const CONFETTI_COLORS = ['#ffc83d', '#ff6f61', '#4fd1c7', '#6988f5', '#ffd867'];
const CONFETTI = Array.from({ length: 22 }, (_, i) => ({
  left: (i * 41 + 7) % 100,
  delay: (i * 97) % 1100,
  duration: 2200 + ((i * 173) % 1200),
  drift: ((i * 29) % 60) - 30,
  spin: 360 + ((i * 83) % 360),
  color: CONFETTI_COLORS[i % CONFETTI_COLORS.length],
  wide: i % 3 === 0,
}));

function medalTone(place: number, total: number): string {
  if (place === 1) return 'gold';
  if (place === total) return 'last';
  if (place === 2) return 'silver';
  if (place === 3) return 'bronze';
  return 'plain';
}

function Confetti() {
  return (
    <div className="tl-result-confetti" aria-hidden="true">
      {CONFETTI.map((piece, i) => (
        <i
          key={i}
          className={piece.wide ? 'wide' : undefined}
          style={
            {
              left: `${piece.left}%`,
              background: piece.color,
              animationDelay: `${piece.delay}ms`,
              animationDuration: `${piece.duration}ms`,
              '--drift': `${piece.drift}px`,
              '--spin': `${piece.spin}deg`,
            } as CSSProperties
          }
        />
      ))}
    </div>
  );
}

export function ResultScreen() {
  const result = useThirteen((s) => s.result);
  const players = useThirteen((s) => s.players);
  const user = useThirteen((s) => s.user);
  const room = useThirteen((s) => s.room);
  const practice = useThirteen((s) => s.practice != null);
  const closeResult = useThirteen((s) => s.closeResult);

  if (!result) return null;
  const total = players.length;
  const rankings =
    result.rankings.length > 0
      ? result.rankings
      : result.winnerId
        ? [{ userId: result.winnerId, place: 1 }]
        : [];
  const nameOf = (userId: string): string => players.find((p) => p.id === userId)?.name ?? 'Người chơi';
  const vipTypeOf = (userId: string) =>
    players.find((p) => p.id === userId)?.vipType ?? (userId === user?.id ? user.vipType : null);
  const expOf = (userId: string) => result.expGains?.find((gain) => gain.userId === userId)?.exp ?? 0;

  const myPlace = rankings.find((entry) => entry.userId === user?.id)?.place;
  const tone: Tone = myPlace == null ? 'neutral' : myPlace === 1 ? 'win' : myPlace === total ? 'lose' : 'mid';
  const title = myPlace == null ? 'Kết quả ván' : `Bạn về ${placeLabel(myPlace, total)}${myPlace === 1 ? '!' : ''}`;
  const instantWin = result.instantWin ? (INSTANT_WIN_LABEL[result.instantWin] ?? result.instantWin) : null;
  const reasonNote = REASON_NOTE[result.reason];

  return (
    <div className="tl-modal-backdrop tl-result-backdrop">
      {tone === 'win' && <Confetti />}
      <div
        className={`tl-result-card tone-${tone}`}
        role="dialog"
        aria-modal="true"
        aria-labelledby="tl-result-title"
      >
        <div className="tl-result-emblem" aria-hidden="true">
          {tone === 'win' && <span className="tl-result-rays" />}
          <span className={'tl-result-emblem-disc' + (myPlace == null ? '' : ` ${medalTone(myPlace, total)}`)}>
            {myPlace == null || myPlace === 1 ? <img src={crownIcon} alt="" /> : myPlace}
          </span>
        </div>
        <div className="tl-result-head">
          <span className="tl-result-kicker">{practice ? 'Ván tập' : 'Kết quả ván'}</span>
          <h2 id="tl-result-title" className="tl-result-title">
            {title}
          </h2>
          {instantWin ? (
            <span className="tl-result-instant">{instantWin}</span>
          ) : (
            <span className="tl-result-subtitle">{reasonNote ?? TONE_SUBTITLE[tone]}</span>
          )}
          {instantWin && reasonNote && <span className="tl-result-subtitle">{reasonNote}</span>}
        </div>
        <ol className="tl-result-rows">
          {rankings.map((entry, index) => {
            const me = entry.userId === user?.id;
            const exp = expOf(entry.userId);
            return (
              <li
                key={entry.userId}
                className={'tl-result-row' + (entry.place === 1 ? ' first' : '') + (me ? ' me' : '')}
                style={{ '--i': index } as CSSProperties}
              >
                <span className={`tl-result-medal ${medalTone(entry.place, total)}`}>{entry.place}</span>
                <PlayerAvatar name={nameOf(entry.userId)} vipType={vipTypeOf(entry.userId)} />
                <span className="tl-result-who">
                  <span className="tl-result-name">
                    <PlayerName name={nameOf(entry.userId)} self={me} />
                  </span>
                  <span className="tl-result-label">{placeLabel(entry.place, total)}</span>
                </span>
                {exp > 0 && <span className="tl-result-exp">+{exp} EXP</span>}
              </li>
            );
          })}
          {rankings.length === 0 && <li className="tl-result-empty">Ván đấu không có kết quả</li>}
        </ol>
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={() => closeResult(false)}>
            {practice ? 'Về sảnh' : 'Rời bàn'}
          </button>
          <button type="button" className="tl-btn tl-btn-gold" onClick={() => closeResult(true)}>
            {practice ? 'Chơi lại' : room ? 'Chơi tiếp' : 'Về sảnh'}
          </button>
        </div>
      </div>
    </div>
  );
}

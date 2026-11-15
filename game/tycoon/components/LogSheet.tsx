import type { CSSProperties, ReactNode } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { useTycoon, type LogKind, type LogLine } from '../store/useTycoon';
import { BottomSheet } from './BottomSheet';
import { TyIcon, type TyIconName } from './TyIcon';
import { levelArt } from './art';
import lanternUrl from '../assets/pixel/fx-lantern.webp';
import airportUrl from '../assets/art/card-airport.webp';
import cardUrl from '../assets/art/card-move.webp';

const KIND_ICON: Partial<Record<LogKind, TyIconName>> = {
  dice: 'dice',
  pay: 'coins',
  buy: 'flag',
  group: 'flag',
  jail: 'jail-bars',
  debt: 'warning',
  bankrupt: 'warning',
  info: 'info',
};

const KIND_ART: Partial<Record<LogKind, string>> = {
  festival: lanternUrl,
  travel: airportUrl,
  card: cardUrl,
};

function LogIcon({ line }: { line: LogLine }) {
  const kind = line.kind ?? 'info';
  let body: ReactNode;
  if ((kind === 'build' || kind === 'sell' || kind === 'takeover') && line.level != null) body = <img src={levelArt(line.level)} alt="" draggable={false} />;
  else if (KIND_ART[kind]) body = <img src={KIND_ART[kind]} alt="" draggable={false} />;
  else body = <TyIcon name={KIND_ICON[kind] ?? 'info'} size={16} />;
  return <span className={`ty-logx-ic ty-logx-ic-${kind}`}>{body}</span>;
}

function LogRow({ line, you }: { line: LogLine; you: number }) {
  const who = line.who && line.text.startsWith(line.who) ? line.who : null;
  const rest = who ? line.text.slice(who.length) : line.text;
  return (
    <li className={`ty-logx-row ${line.seat === you ? 'ty-logx-row-me' : ''}`} style={{ '--seat': line.seat != null ? seatColor(line.seat) : 'var(--ty-navy)' } as CSSProperties}>
      <LogIcon line={line} />
      <span className="ty-logx-text">
        {who ? <b>{who}</b> : null}
        {rest}
      </span>
      {line.money ? <span className={`ty-logx-money ${line.money > 0 ? 'ty-logx-money-up' : 'ty-logx-money-down'}`}>{`${line.money > 0 ? '+' : '−'}${formatMoney(Math.abs(line.money))}`}</span> : null}
    </li>
  );
}

export function LogSheet() {
  const { log, you, closeSheet } = useTycoon(useShallow((s) => ({ log: s.log, you: s.you, closeSheet: s.closeSheet })));
  const rows: ReactNode[] = [];
  let round: number | undefined;
  [...log].reverse().filter((line) => line.kind !== 'round').forEach((line, i) => {
    if (line.round != null && (i === 0 || line.round !== round)) {
      round = line.round;
      rows.push(
        <li key={`r${line.seq}`} className="ty-logx-round">
          <span>Vòng {line.round}</span>
        </li>,
      );
    }
    rows.push(<LogRow key={line.seq} line={line} you={you} />);
  });
  return (
    <BottomSheet title="Diễn biến ván chơi" onClose={closeSheet} tall>
      <h2 className="ui-title ty-sheet-head">Diễn biến</h2>
      {log.length === 0 ? <p className="ty-sheet-desc">Chưa có gì xảy ra.</p> : <ol className="ty-logx">{rows}</ol>}
    </BottomSheet>
  );
}

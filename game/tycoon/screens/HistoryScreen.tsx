import { useEffect, useId, useLayoutEffect, useMemo, useRef, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import botUrl from '../assets/lobby/ill-bot.webp';
import historyUrl from '../assets/lobby/ill-history.webp';
import chevronUrl from '../assets/room-list/chevron-left.svg';
import { RankMedal } from '../components/RankMedal';
import { RoomIcon } from '../components/RoomIcon';
import { ScrollRows } from '../components/ScrollRows';
import { TyIcon } from '../components/TyIcon';
import { botLevelLabel } from '../helpers/bot';
import { formatHistoryTime, formatKen } from '../helpers/format';
import {
  HISTORY_LIMIT,
  HISTORY_OFFLINE,
  HISTORY_ONLINE_ERROR,
  exitLabel,
  formatKenDelta,
  formatSummaryKen,
  historyReason,
  historyTitle,
  kenTone,
  mergeHistory,
  summarize,
  type HistoryEntry,
} from '../helpers/history';
import { avatarIconUrl } from '../helpers/player';
import { useHistory } from '../store/useHistory';
import { useTycoon } from '../store/useTycoon';

const SKELETON_ROWS = Array.from({ length: 6 }, (_, index) => index);
const LOADING_ROWS = SKELETON_ROWS.slice(0, 2);

function spokenKen(entry: HistoryEntry): string {
  if (entry.source === 'bot') return 'chơi với máy';
  if (entry.bet <= 0) return 'bàn giao lưu';
  if (entry.kenDelta === 0) return 'không đổi KEN';
  return `${entry.kenDelta > 0 ? 'cộng' : 'trừ'} ${formatKen(Math.abs(entry.kenDelta))} KEN`;
}

function Detail({ entry, id, myId }: { entry: HistoryEntry; id: string; myId: string | undefined }) {
  return (
    <ul className="ty-hist-detail" id={id} aria-label="Xếp hạng ván">
      {entry.players.map((player) => {
        const out = exitLabel(player.exitReason);
        return (
          <li key={player.userId} className={player.userId === myId ? 'ty-hist-player ty-hist-player-me' : 'ty-hist-player'}>
            <span className="ty-hist-player-rank">{player.place}</span>
            <img className="ty-hist-player-avatar" src={avatarIconUrl(player.vipType)} alt="" draggable={false} />
            <span className="ty-hist-player-who">
              <span className="ty-hist-player-name">{player.bot ? player.username : `@${player.username}`}</span>
              {player.bot && player.level ? <span className="ty-hist-chip">{botLevelLabel(player.level)}</span> : null}
              {out ? <span className="ty-hist-chip ty-hist-chip-out">{out}</span> : null}
            </span>
            <span className={`ty-hist-ken ty-hist-ken-${kenTone(player.kenDelta, entry.bet)}`}>{formatKenDelta(player.kenDelta, entry.bet)}</span>
          </li>
        );
      })}
    </ul>
  );
}

function MatchRow({ entry, expanded, baseId, myId, onToggle }: { entry: HistoryEntry; expanded: boolean; baseId: string; myId: string | undefined; onToggle: () => void }) {
  const title = historyTitle(entry);
  const reason = historyReason(entry);
  const time = formatHistoryTime(entry.playedAt);
  const detailId = `${baseId}-${entry.id}`;
  return (
    <li className={entry.place === 1 ? 'ty-hist-item ty-hist-item-win' : 'ty-hist-item'}>
      <button
        type="button"
        className="ty-hist-row"
        aria-expanded={expanded}
        aria-controls={expanded ? detailId : undefined}
        aria-label={`${title}, hạng ${entry.place} trên ${entry.playerCount} người, ${reason}, ${spokenKen(entry)}, ${time}`}
        onClick={onToggle}
      >
        <span className="ty-hist-rank" aria-hidden="true">
          <RankMedal rank={entry.place} className="ty-hist-rank-num" />
        </span>
        <span className="ty-hist-main" aria-hidden="true">
          <span className={entry.exitReason ? 'ty-hist-title ty-hist-title-out' : 'ty-hist-title'}>{title}</span>
          <span className="ty-hist-sub">
            <span className="ty-hist-reason">{reason}</span>
            {entry.source === 'bot' ? <span className="ty-hist-chip">Máy</span> : null}
          </span>
        </span>
        <span className="ty-hist-side" aria-hidden="true">
          <span className={`ty-hist-ken ty-hist-ken-${kenTone(entry.kenDelta, entry.bet)}`}>{formatKenDelta(entry.kenDelta, entry.bet)}</span>
          <span className="ty-hist-time">{time}</span>
        </span>
        {expanded ? <img className="ty-hist-chevron" src={chevronUrl} alt="" aria-hidden="true" draggable={false} /> : null}
      </button>
      {expanded ? <Detail entry={entry} id={detailId} myId={myId} /> : null}
    </li>
  );
}

function SkeletonRow() {
  return (
    <li className="ty-hist-item ty-lboard-skel" aria-hidden="true">
      <span className="ty-hist-row">
        <i className="ty-lboard-skel-dot" />
        <span className="ty-hist-main">
          <i className="ty-lboard-skel-bar" />
          <i className="ty-lboard-skel-bar ty-hist-skel-sub" />
        </span>
        <i className="ty-lboard-skel-bar ty-lboard-skel-short" />
      </span>
    </li>
  );
}

export function HistoryScreen() {
  const { myId, setHistoryOpen, setSetupOpen } = useTycoon(
    useShallow((s) => ({ myId: s.profile?.id, setHistoryOpen: s.setHistoryOpen, setSetupOpen: s.setSetupOpen })),
  );
  const { status, online, bot, expandedId, open, load, toggle } = useHistory(
    useShallow((s) => ({ status: s.status, online: s.online, bot: s.bot, expandedId: s.expandedId, open: s.open, load: s.load, toggle: s.toggle })),
  );
  const baseId = useId();
  const backRef = useRef<HTMLButtonElement>(null);
  const entries = useMemo(() => mergeHistory(online, bot), [online, bot]);
  const summary = summarize(entries);
  const pending = status === 'loading' && entries.length === 0;
  const failed = status === 'error' || status === 'offline';
  const back = () => setHistoryOpen(false);

  useLayoutEffect(() => {
    open(myId);
  }, [open, myId]);

  useEffect(() => {
    backRef.current?.focus();
    const onKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') setHistoryOpen(false);
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [setHistoryOpen]);

  const playBot = () => {
    setHistoryOpen(false);
    setSetupOpen(true);
  };

  const tiles: Array<[string, string, string]> = [
    [pending ? '—' : String(summary.played), 'Đã chơi', ''],
    [pending ? '—' : String(summary.firstPlaces), 'Hạng 1', ''],
    [pending ? '—' : formatSummaryKen(summary.ken), 'KEN', pending ? '' : `ty-hist-ken-${summary.ken > 0 ? 'plus' : summary.ken < 0 ? 'minus' : 'none'}`],
  ];

  let body;
  if (entries.length === 0 && pending) {
    body = (
      <>
        <p className="ty-visually-hidden" role="status">
          Đang tải lịch sử…
        </p>
        <ul className="ty-hist-rows" aria-hidden="true">
          {SKELETON_ROWS.map((index) => (
            <SkeletonRow key={index} />
          ))}
        </ul>
      </>
    );
  } else if (entries.length === 0 && failed) {
    body = (
      <div className="ty-lboard-state" role="alert">
        <TyIcon name={status === 'offline' ? 'wifi-off' : 'warning'} size={32} />
        <p className="ty-lboard-state-title">{status === 'offline' ? 'Đang offline' : 'Không tải được lịch sử'}</p>
        <button type="button" className="ty-btn ty-btn-paper ty-btn-small" onClick={() => void load()}>
          Thử lại
        </button>
      </div>
    );
  } else if (entries.length === 0) {
    body = (
      <div className="ty-lboard-state">
        <img className="ty-lboard-state-art" src={historyUrl} alt="" draggable={false} />
        <p className="ty-lboard-state-title">Chưa có ván nào</p>
        <p className="ty-lboard-state-hint">Chơi một ván online hoặc với máy để xem lại ở đây.</p>
        <button type="button" className="ty-lb-btn ty-lb-btn-mint ty-hist-cta" onClick={playBot}>
          <img src={botUrl} alt="" draggable={false} />
          <span>Chơi với máy</span>
        </button>
      </div>
    );
  } else {
    body = (
      <>
        {failed ? (
          <div className="ty-hist-banner" role="alert">
            <span>{status === 'offline' ? HISTORY_OFFLINE : HISTORY_ONLINE_ERROR}</span>
            <button type="button" className="ty-btn ty-btn-paper ty-btn-small" onClick={() => void load()}>
              Thử lại
            </button>
          </div>
        ) : null}
        {status === 'loading' ? (
          <p className="ty-visually-hidden" role="status">
            Đang tải ván online…
          </p>
        ) : null}
        <ScrollRows className="ty-hist-rows" label={`${entries.length} ván gần nhất`} count={entries.length + (expandedId ? 1 : 0)}>
          {status === 'loading' ? LOADING_ROWS.map((index) => <SkeletonRow key={`skel-${index}`} />) : null}
          {entries.map((entry) => (
            <MatchRow key={entry.id} entry={entry} expanded={entry.id === expandedId} baseId={baseId} myId={myId} onToggle={() => toggle(entry.id)} />
          ))}
        </ScrollRows>
      </>
    );
  }

  return (
    <div className="ty-lobby ty-lboard ty-hist" style={{ '--ty-lb-bg': `url(${bgUrl})` } as CSSProperties}>
      <header className="ty-lboard-top">
        <button ref={backRef} type="button" className="ty-rooms-round" aria-label="Quay lại" onClick={back}>
          <RoomIcon name="chevron-left" />
        </button>
        <h1 className="ty-lboard-title">
          <img src={historyUrl} alt="" draggable={false} />
          <span>Lịch sử</span>
        </h1>
      </header>

      <section className="ty-lboard-panel ty-hist-panel" aria-busy={status === 'loading' || undefined}>
        <p className="ty-hist-hint">
          {HISTORY_LIMIT} ván gần nhất{bot.length ? ' · ván với máy chỉ lưu trên máy này' : ''}
        </p>
        <dl className="ty-hist-summary">
          {tiles.map(([value, label, tone]) => (
            <div key={label} className="ty-hist-tile">
              <dt>{label}</dt>
              <dd className={tone ? `ty-hist-tile-value ${tone}` : 'ty-hist-tile-value'}>{value}</dd>
            </div>
          ))}
        </dl>
        <div className="ty-hist-sheet">{body}</div>
      </section>
    </div>
  );
}

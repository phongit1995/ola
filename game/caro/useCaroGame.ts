import { useCallback, useEffect, useRef, useState } from 'react';
import {
  bridge,
  joinGame,
  type GameSession,
  type MatchFoundData,
  type PlayerInfo,
  type UserInfoData,
} from '../src/sdk';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import { BOARD_ASSETS, VIP_DEFAULT_ICON } from './assets';
import { createBotSession, type BotLevel } from './bot';
import { SIZE, emptyState, type CaroMove, type CaroState } from './types';

export type OverlayAction = 'again' | 'cancel' | 'lobby';

export interface OverlayState {
  title: string;
  sub: string;
  kind?: 'win' | 'lose' | 'draw';
  actions: OverlayAction[];
}

export interface PlayerDisplay {
  name: string;
  vip: string;
  mark: 'x' | 'o';
  active: boolean;
}

const BOT_VIP_ID: Record<BotLevel, number> = { easy: 1, normal: 2, hard: 3 };

function avatarIconSrc(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id != null ? vipIconUrl(id) : VIP_DEFAULT_ICON;
}

function opponentOf(players: PlayerInfo[], you: number): PlayerInfo {
  return players[1 - you];
}

function formatClock(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
}

export interface CaroGame {
  lobbyVisible: boolean;
  lobbyPhase: 'loading' | 'connecting' | 'error' | 'ready';
  lobbyAnimKey: number;
  userInfo: UserInfoData | null;
  ken: number;

  rankedVisible: boolean;

  board: number[];
  lastIdx: number;
  status: string;
  myTurn: boolean;
  showTimer: boolean;
  timerText: string;
  timerUrgent: boolean;
  turnArrowSrc: string | null;
  me: PlayerDisplay;
  op: PlayerDisplay;
  overlay: OverlayState | null;
  replayVisible: boolean;
  forfeitDisabled: boolean;

  result: { win: boolean; kenDelta: number | null } | null;
  toast: string | null;
  matchSeq: number;

  playBot(level: BotLevel): void;
  playRanked(): void;
  retry(): void;
  exitApp(): void;
  placeMove(x: number, y: number): void;
  again(): void;
  replay(): void;
  cancelSearch(): void;
  toLobby(): void;
  forfeit(): void;
  exitMatch(): void;
  closeResult(): void;
  showToast(message: string): void;
}

const EMPTY_PLAYER: PlayerDisplay = { name: '---', vip: VIP_DEFAULT_ICON, mark: 'x', active: false };

export function useCaroGame(ready: boolean): CaroGame {
  const [lobbyVisible, setLobbyVisible] = useState(true);
  const [lobbyPhase, setLobbyPhase] = useState<CaroGame['lobbyPhase']>('loading');
  const [lobbyAnimKey, setLobbyAnimKey] = useState(0);
  const [userInfo, setUserInfo] = useState<UserInfoData | null>(null);
  const [ken, setKen] = useState(0);

  const [rankedVisible, setRankedVisible] = useState(false);

  const [board, setBoard] = useState<number[]>(() => emptyState().board);
  const [lastIdx, setLastIdx] = useState(-1);
  const [status, setStatus] = useState('Sẵn sàng');
  const [myTurn, setMyTurn] = useState(false);
  const [showTimer, setShowTimer] = useState(false);
  const [timerText, setTimerText] = useState('00:45');
  const [timerUrgent, setTimerUrgent] = useState(false);
  const [turnArrowSrc, setTurnArrowSrc] = useState<string | null>(null);
  const [me, setMe] = useState<PlayerDisplay>(EMPTY_PLAYER);
  const [op, setOp] = useState<PlayerDisplay>({ ...EMPTY_PLAYER, mark: 'o' });
  const [overlay, setOverlay] = useState<OverlayState | null>(null);
  const [replayVisible, setReplayVisible] = useState(false);
  const [forfeitDisabled, setForfeitDisabled] = useState(true);
  const [result, setResult] = useState<CaroGame['result']>(null);
  const [matchSeq, setMatchSeq] = useState(0);
  const [toast, setToast] = useState<string | null>(null);

  const onlineRef = useRef<GameSession<CaroState, CaroMove> | null>(null);
  const botRef = useRef<GameSession<CaroState, CaroMove> | null>(null);
  const botLevelRef = useRef<BotLevel | null>(null);
  const sessionRef = useRef<GameSession<CaroState, CaroMove> | null>(null);
  const matchRef = useRef<MatchFoundData<CaroState> | null>(null);
  const matchBetRef = useRef(0);
  const userRef = useRef<UserInfoData | null>(null);
  const connectingRef = useRef(false);
  const myTurnRef = useRef(false);
  const deadlineRef = useRef(0);
  const timerRef = useRef<number | undefined>(undefined);
  const toastTimerRef = useRef<number | undefined>(undefined);
  const kenRafRef = useRef<number | undefined>(undefined);

  const showToast = useCallback((message: string) => {
    setToast(message);
    window.clearTimeout(toastTimerRef.current);
    toastTimerRef.current = window.setTimeout(() => setToast(null), 2200);
  }, []);

  const animateKen = useCallback((target: number) => {
    if (kenRafRef.current) cancelAnimationFrame(kenRafRef.current);
    const from = ken;
    const start = performance.now();
    const duration = from === target ? 0 : 700;
    const step = (now: number): void => {
      const t = duration === 0 ? 1 : Math.min(1, (now - start) / duration);
      const eased = 1 - (1 - t) * (1 - t);
      setKen(from + (target - from) * eased);
      if (t < 1) kenRafRef.current = requestAnimationFrame(step);
    };
    kenRafRef.current = requestAnimationFrame(step);
  }, [ken]);

  const stopTimer = useCallback(() => {
    if (timerRef.current) window.clearInterval(timerRef.current);
    timerRef.current = undefined;
  }, []);

  const clearMatchUi = useCallback(() => {
    stopTimer();
    setForfeitDisabled(true);
    setMyTurn(false);
    myTurnRef.current = false;
    setMe((p) => ({ ...p, active: false }));
    setOp((p) => ({ ...p, active: false }));
    setShowTimer(false);
    setTimerUrgent(false);
    setTurnArrowSrc(null);
  }, [stopTimer]);

  const applyTurn = useCallback((turn: number, deadlineMs: number) => {
    const match = matchRef.current;
    if (!match) return;
    const mine = turn === match.you;
    myTurnRef.current = mine;
    deadlineRef.current = deadlineMs;
    setMyTurn(mine);
    setStatus(mine ? 'Lượt của bạn' : 'Đợi đối thủ...');
    setMe((p) => ({ ...p, active: mine }));
    setOp((p) => ({ ...p, active: !mine }));
    setShowTimer(true);
    setTurnArrowSrc(mine ? BOARD_ASSETS.boardTurnLeft : BOARD_ASSETS.boardTurnRight);
    bridge.turnChanged({ yourTurn: mine, deadline: deadlineMs });
    stopTimer();
    const tick = (): void => {
      const left = Math.max(0, Math.ceil((deadlineRef.current - Date.now()) / 1000));
      setTimerText(formatClock(left));
      setTimerUrgent(left <= 10);
      if (left === 0) stopTimer();
    };
    tick();
    timerRef.current = window.setInterval(tick, 250);
  }, [stopTimer]);

  const renderState = useCallback((s: CaroState) => {
    setBoard([...s.board]);
    setLastIdx(s.lastX >= 0 ? s.lastY * SIZE + s.lastX : -1);
  }, []);

  const wireSession = useCallback(
    (target: GameSession<CaroState, CaroMove>) => {
      target.onUserInfo((info) => {
        userRef.current = info;
        setUserInfo(info);
        setLobbyPhase('ready');
        setLobbyAnimKey((k) => k + 1);
        animateKen(info.ken ?? 0);
      });

      target.onConnectionChange((connected) => {
        if (sessionRef.current === target && !connected) {
          setStatus('Mất kết nối, đang thử lại...');
        }
      });

      target.onQueueWaiting(() => {
        if (sessionRef.current !== target) return;
        setLobbyVisible(false);
        setOverlay({ title: 'Đang tìm trận...', sub: 'Đợi người chơi khác vào hàng chờ', actions: ['cancel'] });
        setStatus('Đang tìm trận');
      });

      target.onMatchFound((data) => {
        if (sessionRef.current !== target) return;
        matchRef.current = data;
        setMatchSeq((n) => n + 1);
        setLobbyVisible(false);
        setRankedVisible(false);
        setOverlay(null);
        setResult(null);

        const user = userRef.current;
        const meMark: 'x' | 'o' = data.you === 0 ? 'x' : 'o';
        const isBot = target === botRef.current && botLevelRef.current != null;
        const botVip = isBot ? vipIconUrl(BOT_VIP_ID[botLevelRef.current as BotLevel]) : VIP_DEFAULT_ICON;
        setMe({
          name: user ? `@${user.username}` : data.players[data.you].name,
          vip: user ? avatarIconSrc(user.vipType) : VIP_DEFAULT_ICON,
          mark: meMark,
          active: false,
        });
        setOp({
          name: opponentOf(data.players, data.you).name,
          vip: botVip,
          mark: meMark === 'x' ? 'o' : 'x',
          active: false,
        });
        setForfeitDisabled(false);
        setReplayVisible(target === botRef.current);
        renderState(data.state);
        applyTurn(data.turn, data.deadline);
        if (data.resumed) setStatus('Đã vào lại trận đấu');
      });

      target.onState((data) => {
        if (sessionRef.current !== target) return;
        renderState(data.state);
        applyTurn(data.turn, data.deadline);
      });

      target.onMatchOver((data) => {
        if (sessionRef.current !== target) return;
        clearMatchUi();
        renderState(data.state);
        const match = matchRef.current;
        const won = match != null && data.winnerId === match.players[match.you].id;
        const draw = data.winnerId == null || data.winnerId === '';
        if (draw) {
          setOverlay({ title: 'Hòa!', sub: '', kind: 'draw', actions: ['again', 'lobby'] });
          setStatus('Chơi ván mới?');
        } else {
          const bet = matchBetRef.current;
          setResult({ win: won, kenDelta: bet > 0 ? (won ? bet : -bet) : null });
        }
        bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
        matchRef.current = null;
      });

      target.onError((err) => {
        if (sessionRef.current === target) setStatus(err.message);
      });
    },
    [animateKen, applyTurn, clearMatchUi, renderState],
  );

  const connectToServer = useCallback(async () => {
    if (connectingRef.current) return;
    connectingRef.current = true;
    setLobbyPhase('connecting');
    try {
      if (!onlineRef.current) {
        onlineRef.current = await joinGame<CaroState, CaroMove>('caro');
        wireSession(onlineRef.current);
      }
      await new Promise<void>((resolve, reject) => {
        const off = onlineRef.current!.onUserInfo(() => {
          off();
          clearTimeout(timer);
          resolve();
        });
        const timer = setTimeout(() => {
          off();
          reject(new Error('connect timeout'));
        }, 8000);
      });
    } catch {
      onlineRef.current?.disconnect();
      onlineRef.current = null;
      userRef.current = null;
      setUserInfo(null);
      setLobbyPhase('error');
    } finally {
      connectingRef.current = false;
    }
  }, [wireSession]);

  const toLobby = useCallback(() => {
    setOverlay(null);
    setResult(null);
    setRankedVisible(false);
    setLobbyVisible(true);
    setLobbyAnimKey((k) => k + 1);
    if (!userRef.current && !connectingRef.current) void connectToServer();
  }, [connectToServer]);

  const playBot = useCallback(
    (level: BotLevel) => {
      if (!botRef.current || botLevelRef.current !== level) {
        botRef.current?.disconnect();
        botRef.current = createBotSession(level);
        botLevelRef.current = level;
        wireSession(botRef.current);
      }
      matchBetRef.current = 0;
      sessionRef.current = botRef.current;
      sessionRef.current.joinQueue();
    },
    [wireSession],
  );

  const playRanked = useCallback(() => {
    setLobbyVisible(false);
    setRankedVisible(true);
  }, []);

  const placeMove = useCallback((x: number, y: number) => {
    if (!matchRef.current || !myTurnRef.current) return;
    sessionRef.current?.sendMove({ x, y });
  }, []);

  const again = useCallback(() => sessionRef.current?.joinQueue(), []);

  const replay = useCallback(() => {
    if (matchRef.current && !window.confirm('Chơi lại ván mới?')) return;
    sessionRef.current?.joinQueue();
  }, []);

  const cancelSearch = useCallback(() => {
    sessionRef.current?.leaveQueue();
    toLobby();
  }, [toLobby]);

  const forfeit = useCallback(() => {
    if (matchRef.current && window.confirm('Bỏ cuộc trận này?')) sessionRef.current?.forfeit();
  }, []);

  const exitMatch = useCallback(() => {
    if (matchRef.current) {
      if (!window.confirm('Thoát sẽ bị xử thua trận này, thoát chứ?')) return;
      sessionRef.current?.forfeit();
    }
    matchRef.current = null;
    clearMatchUi();
    toLobby();
  }, [clearMatchUi, toLobby]);

  const closeResult = useCallback(() => {
    setResult(null);
    toLobby();
  }, [toLobby]);

  const retry = useCallback(() => void connectToServer(), [connectToServer]);
  const exitApp = useCallback(() => bridge.exit(), []);

  useEffect(() => {
    if (!ready) return;
    setLobbyPhase((p) => (p === 'loading' ? 'connecting' : p));
    void connectToServer();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [ready]);

  useEffect(() => {
    return () => {
      stopTimer();
      window.clearTimeout(toastTimerRef.current);
      if (kenRafRef.current) cancelAnimationFrame(kenRafRef.current);
    };
  }, [stopTimer]);

  return {
    lobbyVisible,
    lobbyPhase,
    lobbyAnimKey,
    userInfo,
    ken,
    rankedVisible,
    board,
    lastIdx,
    status,
    myTurn,
    showTimer,
    timerText,
    timerUrgent,
    turnArrowSrc,
    me,
    op,
    overlay,
    replayVisible,
    forfeitDisabled,
    result,
    toast,
    matchSeq,
    playBot,
    playRanked,
    retry,
    exitApp,
    placeMove,
    again,
    replay,
    cancelSearch,
    toLobby,
    forfeit,
    exitMatch,
    closeResult,
    showToast,
  };
}

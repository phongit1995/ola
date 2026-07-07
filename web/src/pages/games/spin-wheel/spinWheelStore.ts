import { create } from 'zustand';
import {
  SEGMENT_ANGLE,
  SPIN_SEGMENTS,
  SPIN_TURNS,
  type SpinSegment,
} from './spinWheel.constants';

interface SpinWheelState {
  ken: number;
  turnsLeft: number;
  muted: boolean;
  rotation: number;
  spinning: boolean;
  pendingIndex: number | null;
  result: SpinSegment | null;
  history: SpinSegment[];
  reset: (ken: number, turns: number) => void;
  syncKen: (ken: number) => void;
  spin: (targetIndex?: number) => void;
  settle: () => void;
  closeResult: () => void;
  toggleMute: () => void;
}

const initialState = {
  ken: 0,
  turnsLeft: 0,
  muted: false,
  rotation: 0,
  spinning: false,
  pendingIndex: null as number | null,
  result: null as SpinSegment | null,
  history: [] as SpinSegment[],
};

function pickWinningIndex(): number {
  const total = SPIN_SEGMENTS.reduce((sum, segment) => sum + segment.weight, 0);
  let threshold = Math.random() * total;
  for (let index = 0; index < SPIN_SEGMENTS.length; index += 1) {
    threshold -= SPIN_SEGMENTS[index]!.weight;
    if (threshold < 0) return index;
  }
  return SPIN_SEGMENTS.length - 1;
}

function rotationForIndex(current: number, index: number): number {
  const landing = (360 - index * SEGMENT_ANGLE) % 360;
  const currentAngle = ((current % 360) + 360) % 360;
  const delta = (landing - currentAngle + 360) % 360;
  return current + SPIN_TURNS * 360 + delta;
}

export const useSpinWheelStore = create<SpinWheelState>((set, get) => ({
  ...initialState,
  reset: (ken, turns) => set({ ...initialState, ken, turnsLeft: turns }),
  syncKen: (ken) => set((state) => (state.spinning ? state : { ken })),
  spin: (targetIndex) => {
    const state = get();
    if (state.spinning || state.turnsLeft <= 0) return;
    const index =
      typeof targetIndex === 'number' && targetIndex >= 0 ? targetIndex : pickWinningIndex();
    set({
      spinning: true,
      pendingIndex: index,
      rotation: rotationForIndex(state.rotation, index),
      turnsLeft: state.turnsLeft - 1,
    });
  },
  settle: () => {
    const state = get();
    if (state.pendingIndex == null) return;
    const segment = SPIN_SEGMENTS[state.pendingIndex]!;
    set({
      spinning: false,
      pendingIndex: null,
      result: segment,
      ken: segment.kind === 'ken' ? state.ken + (segment.kenAmount ?? 0) : state.ken,
      history: [segment, ...state.history].slice(0, 50),
    });
  },
  closeResult: () => set({ result: null }),
  toggleMute: () => set((state) => ({ muted: !state.muted })),
}));

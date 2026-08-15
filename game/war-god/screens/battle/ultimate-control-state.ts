export interface UltimateControlInput {
  mana: number;
  cost: number;
  inGame: boolean;
  roomPregame: boolean;
  over: boolean;
  myTurn: boolean;
  busy: boolean;
  disconnected?: boolean;
}

export interface UltimateControlState {
  visible: boolean;
  charge: number;
  chargePct: number;
  charged: boolean;
  canCast: boolean;
}

export function deriveUltimateControlState(input: UltimateControlInput): UltimateControlState {
  const mana = Number.isFinite(input.mana) ? Math.max(0, input.mana) : 0;
  const validCost = Number.isFinite(input.cost) && input.cost > 0;
  const charge = validCost ? Math.max(0, Math.min(1, mana / input.cost)) : 0;
  const charged = validCost && mana >= input.cost;
  const chargePct = charged ? 100 : Math.min(99, Math.round(charge * 100));
  const visible = input.inGame && !input.roomPregame && !input.over;
  const canCast =
    visible && input.myTurn && !input.busy && !input.disconnected && charged;

  return { visible, charge, chargePct, charged, canCast };
}

import { afterEach, describe, expect, it, vi } from 'vitest';
import type { RoomStateData } from '../../src/sdk';

vi.mock('../../src/sdk', () => ({
  bridge: {},
  joinGame: vi.fn(),
}));

import { useThirteen } from './useThirteen';

const originalState = useThirteen.getState();

const waitingRoom: RoomStateData = {
  roomId: 'room-1',
  ownerId: 'me',
  youId: 'me',
  bet: 0,
  locked: false,
  maxPlayers: 4,
  members: [{ id: 'me', name: 'Bạn', owner: true, ready: true }],
};

afterEach(() => {
  useThirteen.setState(originalState, true);
});

describe('Thirteen result navigation', () => {
  it('clears the waiting room when the player leaves after a match', () => {
    useThirteen.setState({ phase: 'table', room: waitingRoom, matchId: 'match-1', result: { rankings: [], reason: 'win' } });

    useThirteen.getState().closeResult(false);

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', room: null, matchId: '', result: null });
  });

  it('returns room players to the waiting room for another round', () => {
    useThirteen.setState({ phase: 'table', room: waitingRoom, matchId: 'match-1', result: { rankings: [], reason: 'win' } });

    useThirteen.getState().closeResult(true);

    expect(useThirteen.getState()).toMatchObject({ phase: 'room', room: waitingRoom, matchId: '', result: null });
  });
});

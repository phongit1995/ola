export interface LobbyProfile {
  id: string;
  username: string;
  vipType: string | null;
  ken: number;
  maxBet: number | null;
}

export const GUEST_PROFILE: LobbyProfile = {
  id: 'guest',
  username: 'ban',
  vipType: null,
  ken: 0,
  maxBet: null,
};

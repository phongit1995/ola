export interface LobbyProfile {
  id: string;
  username: string;
  vipType: string | null;
  ken: number;
  maxBet: number | null;
}

export const MOCK_PROFILE: LobbyProfile = {
  id: 'u-minhanh',
  username: 'minhanh',
  vipType: '3',
  ken: 12_500,
  maxBet: 100_000,
};

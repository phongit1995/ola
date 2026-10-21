import { version } from '../../package.json';

export interface LobbyProfile {
  username: string;
  vipType: string | null;
  ken: number;
}

export const MOCK_PROFILE: LobbyProfile = {
  username: 'minhanh',
  vipType: '3',
  ken: 12_500,
};

export const GAME_VERSION = `v${version}`;

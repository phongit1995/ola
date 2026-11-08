import { DEFAULT_GIFT_SETTINGS } from '@ola/shared/constants';
import { configureKeyValueStorage } from '@ola/shared/platform';
import { GiftService } from '@ola/shared/services/gift.service';
import { SettingsService } from '@ola/shared/services/settings.service';
import { useAppConfigStore } from '@ola/shared/stores/appConfigStore';
import { useGiftCatalogStore } from '@ola/shared/stores/gift/giftCatalogStore';
import {
  selectMegaphoneEnabled,
  useMegaphoneConfigStore,
} from '@ola/shared/stores/megaphone/megaphoneConfigStore';
import { useMegaphoneStore } from '@ola/shared/stores/megaphone/megaphoneStore';
import type { Megaphone } from '@ola/shared/types';

jest.mock('@ola/shared/services/settings.service', () => ({
  SettingsService: { appConfig: jest.fn() },
}));

jest.mock('@ola/shared/services/gift.service', () => ({
  GiftService: { catalog: jest.fn() },
}));

jest.mock('@ola/shared/stores/auth/authStore', () => ({
  registerOnLogout: jest.fn(),
}));

jest.mock('@ola/shared/stores/room/roomFilterStore', () => ({
  useRoomFilterStore: { getState: () => ({ blockedUserIds: [] }) },
}));

const appConfig = SettingsService.appConfig as jest.Mock;
const catalog = GiftService.catalog as jest.Mock;

const giftOff = { ...DEFAULT_GIFT_SETTINGS, enabled: false };
const megaphoneOff = {
  enabled: false,
  kenPrice: 7000,
  maxLength: 80,
  displaySeconds: 12,
  liveMinutes: 30,
  cooldownSeconds: 60,
  dailyLimit: 20,
};
const megaphone = { id: 'm1', sender: { id: 'u1' }, expiresAt: '2099-01-01T00:00:00Z' } as unknown as Megaphone;

describe('gift and megaphone app config', () => {
  beforeAll(() => {
    configureKeyValueStorage({ getItem: () => null, setItem: () => undefined, removeItem: () => undefined });
  });

  beforeEach(() => {
    appConfig.mockReset();
    catalog.mockReset();
    useAppConfigStore.setState({ configs: {}, version: null, loadedAt: 0, error: null });
    useGiftCatalogStore.getState().reset();
    useMegaphoneConfigStore.setState({ config: null });
    useMegaphoneStore.setState({ current: null, removedIds: {}, seenIds: {} });
  });

  it('reads the gift switch from /settings/app without loading the catalog', async () => {
    appConfig.mockResolvedValue({ version: 'v1', configs: { gift: giftOff } });
    await useGiftCatalogStore.getState().loadSettings();
    expect(useGiftCatalogStore.getState().settings.enabled).toBe(false);
    expect(catalog).not.toHaveBeenCalled();
  });

  it('keeps the current gift settings when the server has no gift key yet', async () => {
    appConfig.mockResolvedValue({ version: 'v1', configs: {} });
    await useGiftCatalogStore.getState().loadSettings();
    expect(useGiftCatalogStore.getState().settings.enabled).toBe(true);
  });

  it('prefers /settings/app over the catalog settings', async () => {
    appConfig.mockResolvedValue({ version: 'v1', configs: { gift: giftOff } });
    catalog.mockResolvedValue({ items: [], settings: DEFAULT_GIFT_SETTINGS });
    await useGiftCatalogStore.getState().load(true);
    expect(useGiftCatalogStore.getState().settings.enabled).toBe(false);
  });

  it('falls back to the catalog settings when /settings/app has no gift key', async () => {
    appConfig.mockResolvedValue({ version: 'v1', configs: {} });
    catalog.mockResolvedValue({ items: [], settings: giftOff });
    await useGiftCatalogStore.getState().load(true);
    expect(useGiftCatalogStore.getState().settings.enabled).toBe(false);
  });

  it('does not play a megaphone on a platform where it is off', async () => {
    appConfig.mockResolvedValue({ version: 'v1', configs: { megaphone: megaphoneOff } });
    await useMegaphoneConfigStore.getState().load();
    expect(selectMegaphoneEnabled(useMegaphoneConfigStore.getState())).toBe(false);
    useMegaphoneStore.getState().play(megaphone);
    expect(useMegaphoneStore.getState().current).toBeNull();
  });

  it('plays a megaphone before the config arrives', () => {
    useMegaphoneStore.getState().play(megaphone);
    expect(useMegaphoneStore.getState().current?.id).toBe('m1');
  });
});

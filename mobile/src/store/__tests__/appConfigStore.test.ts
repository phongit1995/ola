import { SettingsService } from '@ola/shared/services/settings.service';
import {
  loadAppConfig,
  requireAppConfig,
  useAppConfigStore,
} from '@ola/shared/stores/appConfigStore';

jest.mock('@ola/shared/services/settings.service', () => ({
  SettingsService: { appConfig: jest.fn() },
}));

const appConfig = SettingsService.appConfig as jest.Mock;

const fullResponse = {
  version: 'v1',
  configs: {
    story: { enabled: true },
    wordChain: { enabled: false, hintPrice: 500, guessPrice: 100, vipRequiredToView: false, vipRequiredToPlay: false },
  },
};

describe('appConfigStore', () => {
  beforeEach(() => {
    appConfig.mockReset();
    useAppConfigStore.setState({ configs: {}, version: null, loadedAt: 0, error: null });
  });

  it('shares one request between screens that load at the same time', async () => {
    appConfig.mockResolvedValue(fullResponse);
    const [story, wordChain] = await Promise.all([loadAppConfig('story'), loadAppConfig('wordChain')]);
    expect(appConfig).toHaveBeenCalledTimes(1);
    expect(story).toEqual({ enabled: true });
    expect(wordChain?.enabled).toBe(false);
  });

  it('skips the network when the config was loaded a moment ago', async () => {
    appConfig.mockResolvedValue(fullResponse);
    await loadAppConfig('story');
    await loadAppConfig('story');
    expect(appConfig).toHaveBeenCalledTimes(1);
  });

  it('sends the known version and keeps the configs on notModified', async () => {
    appConfig.mockResolvedValueOnce(fullResponse).mockResolvedValueOnce({ version: 'v1', notModified: true });
    await useAppConfigStore.getState().load();
    await useAppConfigStore.getState().load({ force: true });
    expect(appConfig).toHaveBeenLastCalledWith('v1');
    expect(useAppConfigStore.getState().configs.story).toEqual({ enabled: true });
  });

  it('keeps the last configs when a reload fails', async () => {
    appConfig.mockResolvedValueOnce(fullResponse).mockRejectedValueOnce(new Error('offline'));
    await useAppConfigStore.getState().load();
    const ok = await useAppConfigStore.getState().load({ force: true });
    expect(ok).toBe(false);
    expect(useAppConfigStore.getState().configs.story).toEqual({ enabled: true });
  });

  it('requireAppConfig rejects when the key is missing', async () => {
    appConfig.mockResolvedValue({ version: 'v2', configs: { story: { enabled: true } } });
    await expect(requireAppConfig('usernameChange')).rejects.toThrow('usernameChange');
    await expect(requireAppConfig('story')).resolves.toEqual({ enabled: true });
  });
});

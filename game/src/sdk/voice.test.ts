import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

import { VOICE_ERROR, type VoiceTokenData, type VoiceTokenRequest } from './protocol';
import { createVoiceClient } from './voice';

function fakeSession() {
  const requests: VoiceTokenRequest[] = [];
  let tokenHandler: ((data: VoiceTokenData) => void) | null = null;
  let connectionHandler: ((connected: boolean) => void) | null = null;
  return {
    requests,
    reply: (data: VoiceTokenData) => tokenHandler?.(data),
    connection: (connected: boolean) => connectionHandler?.(connected),
    session: {
      requestVoiceToken: (request: VoiceTokenRequest) => requests.push(request),
      onVoiceToken: (handler: (data: VoiceTokenData) => void) => {
        tokenHandler = handler;
        return () => (tokenHandler = null);
      },
      onConnectionChange: (handler: (connected: boolean) => void) => {
        connectionHandler = handler;
        return () => (connectionHandler = null);
      },
    },
  };
}

const unavailable: VoiceTokenData = { roomId: 'r1', canSpeak: false, error: VOICE_ERROR.unavailable };

describe('voice client reconnect', () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.stubGlobal('RTCPeerConnection', class {});
  });

  afterEach(() => {
    vi.useRealTimers();
    vi.unstubAllGlobals();
  });

  function failCompletely(fake: ReturnType<typeof fakeSession>) {
    const client = createVoiceClient(fake.session);
    client.join({ roomId: 'r1', speak: true });
    fake.reply(unavailable);
    for (const delay of [1_000, 3_000, 8_000]) {
      vi.advanceTimersByTime(delay);
      fake.reply(unavailable);
    }
    return client;
  }

  it('gives up quickly but keeps retrying in the background', () => {
    const fake = fakeSession();
    const client = failCompletely(fake);
    expect(client.getState().status).toBe('failed');
    expect(fake.requests).toHaveLength(4);
    vi.advanceTimersByTime(30_000);
    expect(fake.requests).toHaveLength(5);
    expect(client.getState().status).toBe('failed');
    client.destroy();
  });

  it('retries right away when asked', () => {
    const fake = fakeSession();
    const client = failCompletely(fake);
    client.retry();
    expect(client.getState().status).toBe('reconnecting');
    expect(fake.requests).toHaveLength(5);
    expect(fake.requests.at(-1)).toEqual({ roomId: 'r1' });
    client.destroy();
  });

  it('retries when the game connection comes back', () => {
    const fake = fakeSession();
    const client = failCompletely(fake);
    fake.connection(false);
    expect(fake.requests).toHaveLength(4);
    fake.connection(true);
    expect(client.getState().status).toBe('reconnecting');
    expect(fake.requests).toHaveLength(5);
    client.destroy();
  });

  it('does not retry while healthy or after leaving', () => {
    const fake = fakeSession();
    const client = createVoiceClient(fake.session);
    client.join({ roomId: 'r1', speak: true });
    client.retry();
    fake.connection(true);
    expect(fake.requests).toHaveLength(1);
    client.leave();
    fake.connection(true);
    vi.advanceTimersByTime(60_000);
    expect(fake.requests).toHaveLength(1);
    client.destroy();
  });
});

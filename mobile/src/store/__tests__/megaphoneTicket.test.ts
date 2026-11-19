import { giftCodeRewardText, megaphoneTicketSourceText } from '@ola/shared/lib';
import { MegaphoneService } from '@ola/shared/services/megaphone.service';
import {
  selectMegaphoneTicketCount,
  useMegaphoneTicketStore,
} from '@ola/shared/stores/megaphone/megaphoneTicketStore';

jest.mock('@ola/shared/services/megaphone.service', () => ({
  MegaphoneService: { tickets: jest.fn() },
}));

jest.mock('@ola/shared/stores/auth/authStore', () => ({
  registerOnLogout: jest.fn(),
}));

const tickets = MegaphoneService.tickets as jest.Mock;
const t = ((key: string, options?: Record<string, number>) => `${key}:${JSON.stringify(options ?? {})}`) as never;

describe('megaphone tickets', () => {
  beforeEach(() => {
    useMegaphoneTicketStore.getState().reset();
    tickets.mockReset();
  });

  it('keeps server order and exposes count + next expiry', async () => {
    tickets.mockResolvedValue({
      items: [
        { id: 'a', source: 'admin', expiresAt: '2026-11-21T00:00:00Z', createdAt: '2026-11-19T00:00:00Z' },
        { id: 'b', source: 'gift_code', expiresAt: null, createdAt: '2026-11-18T00:00:00Z' },
      ],
    });
    await useMegaphoneTicketStore.getState().load();
    const state = useMegaphoneTicketStore.getState();
    expect(state.loaded).toBe(true);
    expect(state.tickets.map((ticket) => ticket.id)).toEqual(['a', 'b']);
    expect(selectMegaphoneTicketCount(state)).toBe(2);
  });

  it('keeps old tickets when loading fails', async () => {
    tickets.mockResolvedValueOnce({
      items: [{ id: 'a', source: 'admin', expiresAt: null, createdAt: '2026-11-18T00:00:00Z' }],
    });
    await useMegaphoneTicketStore.getState().load();
    tickets.mockRejectedValueOnce(new Error('offline'));
    await useMegaphoneTicketStore.getState().load();
    expect(selectMegaphoneTicketCount(useMegaphoneTicketStore.getState())).toBe(1);
  });

  it('labels ticket sources', () => {
    expect(megaphoneTicketSourceText(t, 'admin')).toBe('megaphone.ticket.sourceAdmin:{}');
    expect(megaphoneTicketSourceText(t, 'gift_code')).toBe('megaphone.ticket.sourceGiftCode:{}');
    expect(megaphoneTicketSourceText(t, 'checkin')).toBe('megaphone.ticket.sourceOther:{}');
  });

  it('describes gift code ticket rewards with and without expiry', () => {
    expect(giftCodeRewardText(t, { type: 'megaphone_ticket', count: 3 })).toBe('giftCode.rewardMegaphoneTicket:{"count":3}');
    expect(giftCodeRewardText(t, { type: 'megaphone_ticket', count: 2, expiresInDays: 7 })).toBe(
      'giftCode.rewardMegaphoneTicket:{"count":2} giftCode.rewardForDays:{"count":7}'
    );
  });
});

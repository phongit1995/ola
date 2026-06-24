import { create } from 'zustand';
import { colorForName } from '@lib';
import {
  MarriageService,
  type DiaryEntryResult,
  type MarriageUserBrief,
  type ProposalItem,
} from '@services';
import { useAuthStore } from '@/store/authStore';
import type {
  DiaryEntry,
  MarriageStatus,
  PendingProposal,
  SentProposal,
  Spouse,
} from './marriage.types';

interface MarriageState {
  loading: boolean;
  loaded: boolean;
  status: MarriageStatus;
  spouse: Spouse | null;
  marriedSince: number | null;
  diary: DiaryEntry[];
  pendingProposals: PendingProposal[];
  sentProposals: SentProposal[];
  load: () => Promise<void>;
  propose: (addresseeId: string, message: string) => Promise<void>;
  cancelSent: (id: string) => Promise<void>;
  acceptProposal: (id: string) => Promise<void>;
  denyProposal: (id: string) => Promise<void>;
  divorce: () => Promise<void>;
  writeBox: (content: string) => Promise<void>;
}

function mapSpouse(s: MarriageUserBrief): Spouse {
  return {
    nick: s.username,
    name: s.fullName && s.fullName !== '' ? s.fullName : s.username,
    avatarColor: colorForName(s.username),
    avatarUrl: s.avatar,
  };
}

function mapDiary(items: DiaryEntryResult[], myId: string | undefined): DiaryEntry[] {
  return items.map((e) => ({
    id: e.id,
    author: e.author?.id === myId ? 'me' : 'spouse',
    content: e.content,
    createdAt: Date.parse(e.createdAt),
  }));
}

function mapIncoming(items: ProposalItem[]): PendingProposal[] {
  return items.flatMap((p) => {
    if (p.status !== 'pending' || !p.proposer) return [];
    return [
      {
        id: p.id,
        fromNick: p.proposer.username,
        fromName: p.proposer.fullName && p.proposer.fullName !== '' ? p.proposer.fullName : p.proposer.username,
        avatarColor: colorForName(p.proposer.username),
        message: p.message ?? '',
      },
    ];
  });
}

function mapOutgoing(items: ProposalItem[]): SentProposal[] {
  return items.flatMap((p) => {
    if (p.status !== 'pending' || !p.addressee) return [];
    return [
      {
        id: p.id,
        toNick: p.addressee.username,
        message: p.message ?? '',
        createdAt: Date.parse(p.createdAt),
      },
    ];
  });
}

export const useMarriageStore = create<MarriageState>((set, get) => ({
  loading: false,
  loaded: false,
  status: 'single',
  spouse: null,
  marriedSince: null,
  diary: [],
  pendingProposals: [],
  sentProposals: [],

  load: async () => {
    set({ loading: true });
    try {
      const status = await MarriageService.status();
      if (status.spouse) {
        const diaryRes = await MarriageService.diary();
        const myId = useAuthStore.getState().user?.id;
        set({
          loading: false,
          loaded: true,
          status: 'married',
          spouse: mapSpouse(status.spouse),
          marriedSince: status.marriedAt ? Date.parse(status.marriedAt) : null,
          diary: mapDiary(diaryRes.items, myId),
          pendingProposals: [],
          sentProposals: [],
        });
      } else {
        const [incoming, outgoing] = await Promise.all([
          MarriageService.proposals('incoming'),
          MarriageService.proposals('outgoing'),
        ]);
        set({
          loading: false,
          loaded: true,
          status: 'single',
          spouse: null,
          marriedSince: null,
          diary: [],
          pendingProposals: mapIncoming(incoming.items),
          sentProposals: mapOutgoing(outgoing.items),
        });
      }
    } catch (error) {
      set({ loading: false, loaded: true });
      throw error;
    }
  },

  propose: async (addresseeId, message) => {
    await MarriageService.propose(addresseeId, message);
    const outgoing = await MarriageService.proposals('outgoing');
    set({ sentProposals: mapOutgoing(outgoing.items) });
  },

  cancelSent: async (id) => {
    await MarriageService.cancel(id);
    set((state) => ({ sentProposals: state.sentProposals.filter((item) => item.id !== id) }));
  },

  acceptProposal: async (id) => {
    await MarriageService.accept(id);
    await get().load();
  },

  denyProposal: async (id) => {
    await MarriageService.reject(id);
    set((state) => ({ pendingProposals: state.pendingProposals.filter((item) => item.id !== id) }));
  },

  divorce: async () => {
    await MarriageService.divorce();
    await get().load();
  },

  writeBox: async (content) => {
    const entry = await MarriageService.writeDiary(content);
    const myId = useAuthStore.getState().user?.id;
    set((state) => ({ diary: [...mapDiary([entry], myId), ...state.diary] }));
  },
}));

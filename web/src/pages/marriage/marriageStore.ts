import { create } from 'zustand';
import type {
  DiaryEntry,
  MarriageStatus,
  PendingProposal,
  SentProposal,
  Spouse,
} from './marriage.types';

const DAY_MS = 86_400_000;

interface MarriageState {
  status: MarriageStatus;
  spouse: Spouse | null;
  marriedSince: number | null;
  diary: DiaryEntry[];
  pendingProposals: PendingProposal[];
  sentProposals: SentProposal[];
  propose: (nick: string, message: string) => void;
  cancelSent: (id: string) => void;
  acceptProposal: (id: string) => void;
  denyProposal: (id: string) => void;
  divorce: () => void;
  writeBox: (content: string) => void;
  toggleLike: (id: string) => void;
}

const SEED_SPOUSE: Spouse = { nick: 'lan_xinh', name: 'Lan', avatarColor: '#ec407a' };

const SEED_DIARY: DiaryEntry[] = [
  {
    id: 'seed-1',
    author: 'spouse',
    content: 'Cảm ơn anh vì hôm nay đã nấu cơm cho em 🥰',
    createdAt: Date.now() - 2 * 3_600_000,
    likes: 12,
    liked: true,
  },
  {
    id: 'seed-2',
    author: 'me',
    content: 'Kỷ niệm 1 năm mình về chung một nhà ❤️',
    createdAt: Date.now() - 26 * 3_600_000,
    likes: 34,
    liked: false,
  },
];

const SEED_PENDING: PendingProposal[] = [
  {
    id: 'pending-1',
    fromNick: 'hoa_2k',
    fromName: 'Hoa',
    avatarColor: '#7e57c2',
    message: 'Anh muốn cùng em viết tiếp câu chuyện của hai đứa mình 💍',
  },
];

const SEED_SENT: SentProposal[] = [
  {
    id: 'sent-1',
    toNick: 'mai_anh',
    message: 'Làm vợ anh nhé, mình cùng nhau viết Box - Kết Hôn 💖',
    createdAt: Date.now() - 5 * 3_600_000,
  },
];

export const useMarriageStore = create<MarriageState>((set) => ({
  status: 'married',
  spouse: SEED_SPOUSE,
  marriedSince: Date.now() - 378 * DAY_MS,
  diary: SEED_DIARY,
  pendingProposals: SEED_PENDING,
  sentProposals: SEED_SENT,
  propose: (nick, message) =>
    set((state) => ({
      sentProposals: [
        { id: crypto.randomUUID(), toNick: nick, message, createdAt: Date.now() },
        ...state.sentProposals,
      ],
    })),
  cancelSent: (id) =>
    set((state) => ({
      sentProposals: state.sentProposals.filter((item) => item.id !== id),
    })),
  acceptProposal: (id) =>
    set((state) => {
      const proposal = state.pendingProposals.find((item) => item.id === id);
      if (!proposal) return state;
      return {
        status: 'married',
        spouse: {
          nick: proposal.fromNick,
          name: proposal.fromName,
          avatarColor: proposal.avatarColor,
        },
        marriedSince: Date.now(),
        diary: [],
        pendingProposals: [],
        sentProposals: [],
      };
    }),
  denyProposal: (id) =>
    set((state) => ({
      pendingProposals: state.pendingProposals.filter((item) => item.id !== id),
    })),
  divorce: () =>
    set({ status: 'single', spouse: null, marriedSince: null, diary: [] }),
  writeBox: (content) =>
    set((state) => ({
      diary: [
        {
          id: crypto.randomUUID(),
          author: 'me',
          content,
          createdAt: Date.now(),
          likes: 0,
          liked: false,
        },
        ...state.diary,
      ],
    })),
  toggleLike: (id) =>
    set((state) => ({
      diary: state.diary.map((entry) =>
        entry.id === id
          ? { ...entry, liked: !entry.liked, likes: entry.likes + (entry.liked ? -1 : 1) }
          : entry
      ),
    })),
}));

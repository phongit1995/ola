import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentViewerGroups } from '@ola/shared/stores/moment/useMomentViewerGroups';
import type { Moment, MomentTrayGroup } from '@ola/shared/types';

jest.mock('@ola/shared/services/moment.service', () => ({ MomentService: {} }));
jest.mock('@ola/shared/services/user.service', () => ({ UserService: {} }));

const HOUR_MS = 60 * 60 * 1000;

function group(authorId: string, momentIds: string[] = [`${authorId}-1`]): MomentTrayGroup {
  const author = { id: authorId, username: authorId, fullName: authorId, avatar: null };
  const moments = momentIds.map(
    (id) => ({ id, author, expiresAt: new Date(Date.now() + HOUR_MS).toISOString() }) as unknown as Moment
  );
  return { author, moments } as MomentTrayGroup;
}

function authors(groups: MomentTrayGroup[]): string[] {
  return groups.map((item) => item.author.id);
}

let current: MomentTrayGroup[] = [];

function Harness({ base, index, extend }: { base: MomentTrayGroup[]; index: number; extend: boolean }) {
  current = useMomentViewerGroups(base, index, extend);
  return null;
}

describe('useMomentViewerGroups', () => {
  const loadMore = jest.fn(() => Promise.resolve());
  let renderer: ReactTestRenderer | null = null;

  beforeEach(() => {
    loadMore.mockClear();
    useMomentStore.setState({
      groups: [],
      nextCursor: 'next',
      loadingMore: false,
      refreshing: false,
      seenIds: new Set(),
      loadMore,
    });
  });

  afterEach(() => {
    act(() => renderer?.unmount());
    renderer = null;
  });

  function render(base: MomentTrayGroup[], index: number, extend = true) {
    act(() => {
      renderer = create(<Harness base={base} index={index} extend={extend} />);
    });
  }

  it('loads the next tray page when the viewer reaches the last groups', () => {
    const base = ['a', 'b', 'c', 'd', 'e'].map((id) => group(id));
    render(base, 1);
    expect(loadMore).not.toHaveBeenCalled();
    act(() => renderer?.update(<Harness base={base} index={2} extend />));
    expect(loadMore).toHaveBeenCalledTimes(1);
  });

  it('does not load more while busy, when nothing is left, or for own moments', () => {
    const base = [group('a')];
    useMomentStore.setState({ loadingMore: true });
    render(base, 0);
    act(() => useMomentStore.setState({ loadingMore: false, nextCursor: null }));
    act(() => renderer?.unmount());
    useMomentStore.setState({ nextCursor: 'next' });
    render(base, 0, false);
    expect(loadMore).not.toHaveBeenCalled();
  });

  it('appends newly loaded authors after the session groups, skipping known ones but keeping seen ones', () => {
    const base = [group('a'), group('b')];
    render(base, 0);
    act(() =>
      useMomentStore.setState({
        groups: [group('a'), group('c'), group('d', ['d-1']), group('e')],
        seenIds: new Set(['d-1']),
      })
    );
    expect(authors(current)).toEqual(['a', 'b', 'c', 'd', 'e']);
    expect(current[0]).toBe(base[0]);
  });

  it('keeps appended groups in place after they are seen', () => {
    const base = [group('a')];
    render(base, 0);
    act(() => useMomentStore.setState({ groups: [group('b'), group('c')] }));
    act(() => useMomentStore.setState({ seenIds: new Set(['b-1']) }));
    act(() => useMomentStore.setState({ groups: [group('b'), group('c'), group('d')] }));
    expect(authors(current)).toEqual(['a', 'b', 'c', 'd']);
  });

  it('leaves the groups untouched when extending is off', () => {
    const base = [group('a')];
    render(base, 0, false);
    act(() => useMomentStore.setState({ groups: [group('b')] }));
    expect(current).toBe(base);
  });
});

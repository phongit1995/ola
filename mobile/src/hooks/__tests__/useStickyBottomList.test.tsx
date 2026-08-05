import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import type {
  LayoutChangeEvent,
  NativeScrollEvent,
  NativeSyntheticEvent,
} from 'react-native';
import { useStickyBottomList } from '../useStickyBottomList';

interface Item {
  id: string;
}

type StickyBottomList = ReturnType<typeof useStickyBottomList<Item>>;

let currentHook: StickyBottomList | null = null;

function Harness() {
  currentHook = useStickyBottomList<Item>();
  return null;
}

function result(): StickyBottomList {
  if (currentHook == null) throw new Error('Hook was not rendered');
  return currentHook;
}

function layoutEvent(height: number): LayoutChangeEvent {
  return {
    nativeEvent: {
      layout: { x: 0, y: 0, width: 320, height },
    },
  } as LayoutChangeEvent;
}

function scrollEvent({
  offset,
  contentHeight,
  viewportHeight,
}: {
  offset: number;
  contentHeight: number;
  viewportHeight: number;
}): NativeSyntheticEvent<NativeScrollEvent> {
  return {
    nativeEvent: {
      contentOffset: { x: 0, y: offset },
      contentSize: { width: 320, height: contentHeight },
      layoutMeasurement: { width: 320, height: viewportHeight },
    },
  } as NativeSyntheticEvent<NativeScrollEvent>;
}

describe('useStickyBottomList viewport changes', () => {
  let renderer: ReactTestRenderer;
  let scrollToEnd: jest.Mock;

  beforeEach(() => {
    currentHook = null;
    scrollToEnd = jest.fn();
    act(() => {
      renderer = create(<Harness />);
    });
    result().listRef.current = {
      scrollToEnd,
    } as unknown as NonNullable<StickyBottomList['listRef']['current']>;

    result().onContentSizeChange(320, 1200);
    scrollToEnd.mockClear();
  });

  afterEach(() => {
    act(() => renderer.unmount());
    currentHook = null;
  });

  it('pins on initial layout and when the viewport shrinks', () => {
    result().onListLayout(layoutEvent(600));
    expect(scrollToEnd).toHaveBeenCalledTimes(1);

    scrollToEnd.mockClear();
    result().onListLayout(layoutEvent(320));
    expect(scrollToEnd).toHaveBeenCalledTimes(1);
  });

  it('does not issue a delayed pin when the viewport grows', () => {
    result().onListLayout(layoutEvent(320));
    scrollToEnd.mockClear();

    result().onListLayout(layoutEvent(600));
    expect(scrollToEnd).not.toHaveBeenCalled();
  });

  it('ignores hidden layouts and pins when the list becomes visible again', () => {
    result().onListLayout(layoutEvent(600));
    scrollToEnd.mockClear();

    result().onListLayout(layoutEvent(0));
    expect(scrollToEnd).not.toHaveBeenCalled();

    result().onListLayout(layoutEvent(600));
    expect(scrollToEnd).toHaveBeenCalledTimes(1);
  });

  it('does not pin a viewport resize after the user scrolls away from bottom', () => {
    result().onListLayout(layoutEvent(600));
    scrollToEnd.mockClear();

    result().onScrollBeginDrag();
    result().onScroll(
      scrollEvent({
        offset: 200,
        contentHeight: 1200,
        viewportHeight: 600,
      }),
    );
    result().onScrollEndDrag();
    result().onListLayout(layoutEvent(320));

    expect(scrollToEnd).not.toHaveBeenCalled();
  });

  it('keeps following new content while the list is pinned', () => {
    result().onListLayout(layoutEvent(600));
    scrollToEnd.mockClear();

    result().onContentSizeChange(320, 1300);

    expect(scrollToEnd).toHaveBeenCalledTimes(1);
  });

  it('does not jump to bottom when older content is prepended', () => {
    result().onListLayout(layoutEvent(600));
    scrollToEnd.mockClear();

    result().unstick();
    result().onContentSizeChange(320, 1500);

    expect(scrollToEnd).not.toHaveBeenCalled();
  });

  it('pins the next content update after sending a message', () => {
    result().onListLayout(layoutEvent(600));
    result().unstick();
    scrollToEnd.mockClear();

    result().pinOnNextContent();
    result().onContentSizeChange(320, 1300);

    expect(scrollToEnd).toHaveBeenCalledTimes(1);
  });
});

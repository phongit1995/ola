import { create, act, type ReactTestInstance, type ReactTestRenderer } from 'react-test-renderer';
import { Pressable, ScrollView, Text } from 'react-native';
import { Dialog } from '../Dialog';

jest.mock('../../KeyboardView', () => ({
  KeyboardView: require('react-native').View,
}));

describe('Dialog', () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
  });

  it('does not put a press responder above scrollable content', () => {
    let renderer: ReactTestRenderer | undefined;

    act(() => {
      renderer = create(
        <Dialog visible avoidKeyboard={false} onClose={jest.fn()} title="History">
          <ScrollView testID="dialog-scroll">
            <Text>Scrollable content</Text>
          </ScrollView>
        </Dialog>,
      );
      jest.runAllTimers();
    });

    const scrollView = renderer!.root.findByProps({ testID: 'dialog-scroll' });
    const ancestors: ReactTestInstance[] = [];
    let parent = scrollView.parent;
    while (parent != null) {
      ancestors.push(parent);
      parent = parent.parent;
    }

    expect(ancestors.some((ancestor) => ancestor.type === Pressable)).toBe(false);

    act(() => {
      renderer!.unmount();
    });
  });
});

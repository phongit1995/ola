import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import { View } from 'react-native';
import {
  ChatKeyboardArea,
  resolveChatKeyboardVerticalOffset,
} from '../ChatKeyboardArea';

jest.mock('react-native-keyboard-controller', () => ({
  KeyboardAvoidingView: require('react-native').View,
}));

function renderArea(bottomInset?: number): ReactTestRenderer {
  let renderer: ReactTestRenderer | undefined;
  act(() => {
    renderer = create(
      <ChatKeyboardArea bottomInset={bottomInset}>
        <View />
      </ChatKeyboardArea>,
    );
  });
  return renderer!;
}

function keyboardAvoidingView(renderer: ReactTestRenderer) {
  return renderer.root.findByProps({ behavior: 'translate-with-padding' });
}

describe('ChatKeyboardArea', () => {
  it('passes the fixed bottom inset to the keyboard offset', () => {
    const renderer = renderArea(34);

    expect(keyboardAvoidingView(renderer).props.keyboardVerticalOffset).toBe(
      -34,
    );

    act(() => renderer.unmount());
  });

  it.each([
    ['Android', true, 0, 34, -34],
    ['iOS', false, 96, 34, 62],
  ])(
    'combines offsets correctly on %s',
    (_platform, isAndroid, iosOffsetY, bottomInset, expected) => {
      expect(
        resolveChatKeyboardVerticalOffset(isAndroid, iosOffsetY, bottomInset),
      ).toBe(expected);
    },
  );
});

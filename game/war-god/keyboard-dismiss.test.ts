import { describe, expect, it, vi } from 'vitest';
import { isKeyboardEditor, shouldDismissKeyboard } from './keyboard-dismiss';

function element(tagName: string, type = ''): { tagName: string; type: string; blur: ReturnType<typeof vi.fn> } {
  return { tagName, type, blur: vi.fn() };
}

describe('War God keyboard dismissal', () => {
  it('dismisses a focused text input when the player presses the game canvas', () => {
    const input = element('INPUT', 'text');
    const canvas = element('CANVAS');
    expect(shouldDismissKeyboard(input, [canvas])).toBe(true);
  });

  it('keeps the keyboard open while pressing the focused field or another editor', () => {
    const input = element('INPUT', 'password');
    const otherInput = element('INPUT', 'text');
    expect(shouldDismissKeyboard(input, [input])).toBe(false);
    expect(shouldDismissKeyboard(input, [otherInput])).toBe(false);
  });

  it('ignores controls that never summon the software keyboard', () => {
    expect(isKeyboardEditor(element('INPUT', 'checkbox'))).toBe(false);
    expect(shouldDismissKeyboard(element('BUTTON'), [])).toBe(false);
  });
});

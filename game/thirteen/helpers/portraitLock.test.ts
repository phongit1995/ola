import { describe, expect, it } from 'vitest';
import { isPhoneScreen, portraitLockRotation } from './portraitLock';

describe('portraitLockRotation', () => {
  it('turns the game against the device rotation on phones', () => {
    expect(portraitLockRotation(90, true)).toBe(-90);
    expect(portraitLockRotation(270, true)).toBe(90);
    expect(portraitLockRotation(-90, true)).toBe(90);
  });

  it('keeps the game upright in portrait, on non-phones and without a reading', () => {
    expect(portraitLockRotation(0, true)).toBe(0);
    expect(portraitLockRotation(180, true)).toBe(0);
    expect(portraitLockRotation(90, false)).toBe(0);
    expect(portraitLockRotation(undefined, true)).toBe(0);
  });
});

describe('isPhoneScreen', () => {
  it('only treats small touch screens as phones', () => {
    expect(isPhoneScreen(true, 390, 844)).toBe(true);
    expect(isPhoneScreen(true, 844, 390)).toBe(true);
    expect(isPhoneScreen(true, 768, 1024)).toBe(false);
    expect(isPhoneScreen(false, 900, 480)).toBe(false);
  });
});

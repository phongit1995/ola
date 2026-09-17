import { sha256Hex } from '../sha256';
import {
  hashPin,
  isValidPin,
  lockoutDurationMs,
  normalizeBiometricOutcome,
  normalizeBiometryType,
  pinMatches,
  remainingAttempts,
  shouldLockAfterBackground,
} from '../appLock';

describe('sha256Hex', () => {
  it('matches known vectors', () => {
    expect(sha256Hex('')).toBe(
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    );
    expect(sha256Hex('abc')).toBe(
      'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
    );
    expect(
      sha256Hex('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq')
    ).toBe('248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1');
  });

  it('hashes multi-byte text as UTF-8', () => {
    expect(sha256Hex('Khoá ứng dụng')).toHaveLength(64);
    expect(sha256Hex('Khoá ứng dụng')).not.toBe(sha256Hex('Khoa ung dung'));
  });
});

describe('pin helpers', () => {
  it('validates PIN shape', () => {
    expect(isValidPin('1234')).toBe(true);
    expect(isValidPin('12a4')).toBe(false);
    expect(isValidPin('123')).toBe(false);
  });

  it('matches only the right PIN with the same salt', () => {
    const hash = hashPin('1234', 'salt');
    expect(pinMatches('1234', 'salt', hash)).toBe(true);
    expect(pinMatches('1235', 'salt', hash)).toBe(false);
    expect(pinMatches('1234', 'other', hash)).toBe(false);
    expect(pinMatches('1234', 'salt', '')).toBe(false);
  });

  it('escalates lockout after the attempt limit', () => {
    expect(lockoutDurationMs(4)).toBe(0);
    expect(lockoutDurationMs(5)).toBe(30_000);
    expect(lockoutDurationMs(6)).toBe(60_000);
    expect(lockoutDurationMs(20)).toBe(300_000);
    expect(remainingAttempts(3)).toBe(2);
    expect(remainingAttempts(9)).toBe(0);
  });

  it('locks based on background duration', () => {
    expect(shouldLockAfterBackground(null, 1000, 0)).toBe(false);
    expect(shouldLockAfterBackground(1000, 1000, 0)).toBe(true);
    expect(shouldLockAfterBackground(1000, 30_000, 60)).toBe(false);
    expect(shouldLockAfterBackground(1000, 61_000, 60)).toBe(true);
  });

  it('normalizes native strings', () => {
    expect(normalizeBiometryType('faceId')).toBe('faceId');
    expect(normalizeBiometryType('weird')).toBe('');
    expect(normalizeBiometricOutcome('cancel')).toBe('cancel');
    expect(normalizeBiometricOutcome(undefined)).toBe('failed');
  });
});

import type { STRINGS_VI } from './Strings.vi.constants';

/** Languages the farm ships. Vietnamese is the source language and the fallback. */
export type Locale = 'vi' | 'en';

/** Every player-facing sentence has a key in the Vietnamese table; other languages must cover the same keys. */
export type StringKey = keyof typeof STRINGS_VI;

/** Values for `{name}` placeholders; numbers are inserted as given, so format them first when needed. */
export type StringParams = Readonly<Record<string, string | number>>;

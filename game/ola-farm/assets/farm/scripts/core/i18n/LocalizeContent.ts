import { CONTENT_NAMES_EN, CONTENT_PATTERNS_EN } from './ContentNames.en.constants';
import { currentLocale } from './I18n';

/** The display name of one content entry in the current language; unknown names stay as written in the JSON. */
export function contentName(name: string): string {
  if (currentLocale() !== 'en') return name;
  const direct = CONTENT_NAMES_EN[name];
  if (direct) return direct;
  for (const [pattern, replacement] of CONTENT_PATTERNS_EN)
    if (pattern.test(name)) return name.replace(pattern, replacement);
  return name;
}

/**
 * A copy of the loaded catalog with every `name` and `label` shown to players renamed for the current language.
 * Vietnamese returns the catalog itself. Saves only store ids and keys, so renaming never touches them.
 */
export function localizeContent<T>(catalog: T): T {
  if (currentLocale() === 'vi') return catalog;
  const rename = (value: unknown, key?: string): unknown => {
    if (typeof value === 'string') return key === 'name' || key === 'label' ? contentName(value) : value;
    if (Array.isArray(value)) return value.map(entry => rename(entry, key));
    if (value && typeof value === 'object' && Object.getPrototypeOf(value) === Object.prototype)
      return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, rename(v, k)]));
    return value;
  };
  return rename(catalog) as T;
}

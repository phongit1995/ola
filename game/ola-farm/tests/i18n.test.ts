import assert from 'node:assert/strict';
import { afterEach, test } from 'node:test';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { format } from '../assets/farm/scripts/core/Format';
import { penNames } from '../assets/farm/scripts/core/constants/HusbandryDefaults';
import { FARM_LAYOUT } from '../assets/farm/scripts/core/generated/FarmLayoutManifest';
import { currentLocale, parseLocale, setLocale, t } from '../assets/farm/scripts/core/i18n/I18n';
import { contentName, localizeContent } from '../assets/farm/scripts/core/i18n/LocalizeContent';
import { STRINGS_VI } from '../assets/farm/scripts/core/i18n/Strings.vi.constants';
import { STRINGS_EN } from '../assets/farm/scripts/core/i18n/Strings.en.constants';
import { CONTENT_NAMES_EN, CONTENT_PATTERNS_EN } from '../assets/farm/scripts/core/i18n/ContentNames.en.constants';

const VIETNAMESE = /[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]/i;
const placeholders = (text: string) => [...new Set(text.match(/\{\w+\}/g) ?? [])].sort();

/** Every `name` and `label` string in a loaded catalog or layout, the values players read. */
function displayNames(value: unknown, key?: string, found = new Set<string>()): Set<string> {
  if (typeof value === 'string') {
    if (key === 'name' || key === 'label') found.add(value);
  } else if (Array.isArray(value)) for (const entry of value) displayNames(entry, key, found);
  else if (value && typeof value === 'object') for (const [k, v] of Object.entries(value)) displayNames(v, k, found);
  return found;
}

afterEach(() => setLocale('vi'));

test('the English table has exactly the Vietnamese keys, with the same placeholders and no Vietnamese left', () => {
  assert.deepEqual(Object.keys(STRINGS_EN).sort(), Object.keys(STRINGS_VI).sort());
  for (const [key, vi] of Object.entries(STRINGS_VI)) {
    const en = STRINGS_EN[key as keyof typeof STRINGS_VI];
    assert.ok(en.trim() || !vi.trim(), `${key} is empty in English`);
    assert.deepEqual(placeholders(en), placeholders(vi), `${key} placeholders`);
    assert.doesNotMatch(en, VIETNAMESE, `${key} still reads Vietnamese: ${en}`);
  }
});

test('the language comes from a tag; Vietnamese is the default and fills placeholders the same way', () => {
  assert.equal(parseLocale('en-US'), 'en');
  assert.equal(parseLocale(' VI '), 'vi');
  for (const other of ['fr', '', null, undefined, 3]) assert.equal(parseLocale(other), null);
  assert.equal(currentLocale(), 'vi');
  assert.equal(t('common.needLevel', { level: 7 }), 'Cần level 7');
  setLocale('en');
  assert.equal(t('common.needLevel', { level: 7 }), 'Needs level 7');
  assert.equal(t('common.coins', {}), '{coins} coins', 'a missing parameter stays visible instead of vanishing');
});

test('numbers group the way each language writes them', () => {
  assert.equal(format(12345), '12.345');
  setLocale('en');
  assert.equal(format(12345), '12,345');
});

test('every content name players can see has an English name', () => {
  const names = new Set([
    ...displayNames(loadFarmCatalog()),
    ...displayNames(FARM_LAYOUT),
    ...Object.values(penNames),
    'Sữa bò',
  ]);
  const missing = [...names].filter(
    name => !(name in CONTENT_NAMES_EN) && !CONTENT_PATTERNS_EN.some(([pattern]) => pattern.test(name))
  );
  assert.deepEqual(missing, []);
  setLocale('en');
  for (const name of names) assert.doesNotMatch(contentName(name), VIETNAMESE, name);
  assert.equal(contentName('Ruộng 12'), 'Field 12');
});

test('an English catalog only renames what players read; ids, keys and saves are untouched', () => {
  const catalog = loadFarmCatalog();
  assert.equal(localizeContent(catalog), catalog, 'Vietnamese keeps the catalog as loaded');
  setLocale('en');
  const english = localizeContent(catalog);
  assert.notEqual(english, catalog);
  assert.equal(english.farm.find(crop => crop.id === 1)?.name, 'Wheat');
  assert.equal(catalog.farm.find(crop => crop.id === 1)?.name, 'Lúa mì', 'the loaded catalog is not changed');
  const strip = (value: unknown): unknown =>
    JSON.parse(JSON.stringify(value, (k, v) => (k === 'name' || k === 'label' ? '' : v)));
  assert.deepEqual(strip(english), strip(catalog));

  const vi = new FarmGame(catalog),
    en = new FarmGame(english, structuredClone(vi.state));
  assert.deepEqual(en.state, vi.state, 'the same save opens in either language');
  const plot = en.state.plots.find(p => p.group === 'crop' && p.unlocked && p.crop === null)!;
  assert.equal(en.plant(plot.id, 1).message, 'Planted wheat');
});

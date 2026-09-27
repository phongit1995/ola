import type { StringKey } from '../../core/i18n/I18n.types';

/** Shorter shop card titles for machines whose full names do not fit, by machine type id. */
export const SHORT_MACHINE_NAMES: Readonly<Record<number, StringKey>> = {
  1071: 'shop.shortSugarMill',
  1019: 'shop.shortPieOven',
  1020: 'shop.shortPopcorn',
};

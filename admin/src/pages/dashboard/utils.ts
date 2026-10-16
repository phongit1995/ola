import { KEN_TYPE_LABEL } from './constants'

export function kenTypeLabel(type: string) {
  return KEN_TYPE_LABEL[type] ?? type
}

import type { MegaphoneSetting } from '@/types'
import { MEGAPHONE_GIFT_WAIT_SHARE, MEGAPHONE_WAIT_SHARE_OF_LIVE } from './constants'

export function megaphoneQueueLimits(setting: Pick<MegaphoneSetting, 'liveMinutes' | 'displaySeconds' | 'gapSeconds'>) {
  const slot = setting.displaySeconds + setting.gapSeconds
  if (!(setting.liveMinutes > 0) || !(slot > 0)) return null
  const liveSeconds = setting.liveMinutes * 60
  const message = Math.max(1, Math.floor(liveSeconds / MEGAPHONE_WAIT_SHARE_OF_LIVE / slot))
  return {
    turns: Math.floor(liveSeconds / slot),
    message,
    gift: Math.max(1, Math.floor(message / MEGAPHONE_GIFT_WAIT_SHARE)),
  }
}

export function parseBannedWords(text: string): string[] {
  const seen = new Set<string>()
  const words: string[] = []
  for (const line of text.split('\n')) {
    const word = line.trim().replace(/\s+/g, ' ')
    const key = word.toLocaleLowerCase('vi')
    if (word === '' || seen.has(key)) continue
    seen.add(key)
    words.push(word)
  }
  return words
}

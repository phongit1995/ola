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

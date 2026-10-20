const HIDDEN_PEER_CARDS_KEY = 'ola.hiddenPeerCards';

function readHiddenPeerIds(): string[] {
  const raw = localStorage.getItem(HIDDEN_PEER_CARDS_KEY);
  if (raw == null || raw === '') return [];
  return raw.split(',');
}

export function isPeerCardHidden(peerId: string): boolean {
  if (peerId === '') return false;
  return readHiddenPeerIds().includes(peerId);
}

export function hidePeerCard(peerId: string): void {
  if (peerId === '') return;
  const ids = readHiddenPeerIds();
  if (ids.includes(peerId)) return;
  ids.push(peerId);
  localStorage.setItem(HIDDEN_PEER_CARDS_KEY, ids.join(','));
}

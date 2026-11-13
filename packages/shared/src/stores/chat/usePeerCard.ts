import { useState } from 'react';
import { RELATIONSHIP_STATUS } from '../../constants/relationship';
import type { RelationshipStatus } from '../../types/api/user.type';

const STRANGER_STATUSES: RelationshipStatus[] = [
  RELATIONSHIP_STATUS.none,
  RELATIONSHIP_STATUS.pendingOutgoing,
  RELATIONSHIP_STATUS.pendingIncoming,
];

const PEER_CARD_MAX_MESSAGES = 10;

export interface PeerCardHiddenStorage {
  isHidden: (peerId: string) => boolean;
  hide: (peerId: string) => void;
}

interface UsePeerCardArgs {
  peerId: string;
  hasProfile: boolean;
  blocked: boolean;
  blockStatus: RelationshipStatus | null | undefined;
  hasMore: boolean;
  messageCount: number;
  messagesReady: boolean;
  peerCardRoll: boolean;
  lastMessageId: string | undefined;
  hiddenStorage: PeerCardHiddenStorage;
}

function initialHiddenFor(peerId: string, hiddenStorage: PeerCardHiddenStorage): string {
  return peerId !== '' && hiddenStorage.isHidden(peerId) ? peerId : '';
}

export function usePeerCard({
  peerId,
  hasProfile,
  blocked,
  blockStatus,
  hasMore,
  messageCount,
  messagesReady,
  peerCardRoll,
  lastMessageId,
  hiddenStorage,
}: UsePeerCardArgs) {
  const [hiddenFor, setHiddenFor] = useState(() => initialHiddenFor(peerId, hiddenStorage));
  const [trackedPeerId, setTrackedPeerId] = useState(peerId);
  const [anchor, setAnchor] = useState<{ peerId: string; id: string } | null>(null);

  if (trackedPeerId !== peerId) {
    setTrackedPeerId(peerId);
    setHiddenFor(initialHiddenFor(peerId, hiddenStorage));
    setAnchor(null);
  }

  const hidden = peerId !== '' && hiddenFor === peerId;
  const isStranger =
    hasProfile &&
    !blocked &&
    !hidden &&
    blockStatus != null &&
    STRANGER_STATUSES.includes(blockStatus);
  const sizeAllowsCard = (!hasMore && messageCount < PEER_CARD_MAX_MESSAGES) || peerCardRoll;

  if (
    isStranger &&
    sizeAllowsCard &&
    messagesReady &&
    (anchor == null || anchor.peerId !== peerId)
  ) {
    setAnchor({ peerId, id: lastMessageId ?? '' });
  }

  const anchorId = anchor?.peerId === peerId ? anchor.id : null;

  return {
    anchorId,
    visible: isStranger && anchorId != null,
    hide: () => {
      if (peerId === '') return;
      hiddenStorage.hide(peerId);
      setHiddenFor(peerId);
    },
  };
}

import { useState } from 'react';
import type { RelationshipStatus } from '@ola/shared/types';
import { hidePeerCard, isPeerCardHidden } from '../../store/chatLocalStore';

const STRANGER_STATUSES: RelationshipStatus[] = ['none', 'pending_outgoing', 'pending_incoming'];

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
}

function initialHiddenFor(peerId: string): string {
  return peerId !== '' && isPeerCardHidden(peerId) ? peerId : '';
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
}: UsePeerCardArgs) {
  const [hiddenFor, setHiddenFor] = useState(() => initialHiddenFor(peerId));
  const [trackedPeerId, setTrackedPeerId] = useState(peerId);
  const [anchor, setAnchor] = useState<{ peerId: string; id: string } | null>(null);

  if (trackedPeerId !== peerId) {
    setTrackedPeerId(peerId);
    setHiddenFor(initialHiddenFor(peerId));
    setAnchor(null);
  }

  const hidden = peerId !== '' && hiddenFor === peerId;
  const isStranger =
    hasProfile && !blocked && !hidden && blockStatus != null && STRANGER_STATUSES.includes(blockStatus);
  const sizeAllowsCard = (!hasMore && messageCount < 10) || peerCardRoll;

  if (isStranger && sizeAllowsCard && messagesReady && (anchor == null || anchor.peerId !== peerId)) {
    setAnchor({ peerId, id: lastMessageId ?? '' });
  }

  const anchorId = anchor?.peerId === peerId ? anchor.id : null;

  return {
    anchorId,
    visible: isStranger && anchorId != null,
    hide: () => {
      if (peerId === '') return;
      hidePeerCard(peerId);
      setHiddenFor(peerId);
    },
  };
}

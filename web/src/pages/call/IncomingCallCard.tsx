import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { CALL_TYPE } from '@constants';
import { callPeerNameView, colorForName, peerDisplayName } from '@lib';
import { useCallStore } from '@/store/callStore';
import { EndCallIcon, PhoneIcon } from './icons';
import {
  useCallDraggable,
  type CallDraggableInitial,
} from './hooks/useCallDraggable';
import { useRingtone } from './hooks/useRingtone';
import { ensureCallPermissions } from './lib/callPermissionGuard';

export function IncomingCallCard() {
  const { t } = useTranslation();
  const incoming = useCallStore((s) => s.incoming);
  const incomingPos = useCallStore((s) => s.incomingPos);
  const setIncomingPos = useCallStore((s) => s.setIncomingPos);
  const answerIncoming = useCallStore((s) => s.answerIncoming);
  const declineIncoming = useCallStore((s) => s.declineIncoming);
  const pendingAction = useCallStore((s) => s.pendingAction);

  const initialPosition = useCallback<CallDraggableInitial>(
    (bounds, element) => ({ x: (bounds.width - element.width) / 2, y: 24 }),
    []
  );

  const drag = useCallDraggable<HTMLDivElement>({
    position: incomingPos,
    onChange: setIncomingPos,
    initial: initialPosition,
  });

  useRingtone(incoming != null);

  if (incoming == null) return null;

  const name = peerDisplayName(incoming.caller, t('call.unknownUser'));
  const nameView = callPeerNameView(incoming.caller, t('call.unknownUser'));
  const title =
    incoming.callType === CALL_TYPE.video
      ? t('call.incomingVideoCall')
      : t('call.incomingVoiceCall');

  const busy = pendingAction != null;

  const handleAccept = async () => {
    if (busy) return;
    const allowed = await ensureCallPermissions(incoming.callType, t);
    if (!allowed) return;
    await answerIncoming();
  };

  const stop = (event: React.PointerEvent) => event.stopPropagation();

  return (
    <div
      {...drag}
      className="absolute left-0 top-0 z-[126] w-[300px] max-w-[92%] touch-none rounded-2xl bg-ola-call-bg/95 p-4 text-white shadow-2xl backdrop-blur"
    >
      <div className="flex items-center gap-3">
        <Avatar
          name={name}
          color={colorForName(name)}
          src={incoming.caller.avatar}
          size={52}
        />
        <div className="min-w-0 flex-1">
          <p className="truncate text-base font-semibold">{nameView.title}</p>
          {nameView.subtitle != null && (
            <p className="truncate text-xs text-white/80">{nameView.subtitle}</p>
          )}
          <p className="truncate text-xs text-white/70">{title}</p>
        </div>
      </div>

      <div className="mt-4 flex items-center justify-center gap-6">
        <button
          type="button"
          aria-label={t('call.decline')}
          disabled={busy}
          onPointerDown={stop}
          onClick={declineIncoming}
          className="flex h-12 w-12 items-center justify-center rounded-full bg-ola-error text-white hover:brightness-110 disabled:opacity-50"
        >
          <EndCallIcon className="h-6 w-6" />
        </button>
        <button
          type="button"
          aria-label={t('call.accept')}
          disabled={busy}
          onPointerDown={stop}
          onClick={() => void handleAccept()}
          className="flex h-12 w-12 items-center justify-center rounded-full bg-ola-button text-ola-primary-darker hover:brightness-110 disabled:opacity-50"
        >
          <PhoneIcon className="h-6 w-6" />
        </button>
      </div>
    </div>
  );
}

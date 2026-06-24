import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { toast } from '@lib';
import { useMarriageStore } from './marriageStore';

interface ProposeComposerProps {
  onClose: () => void;
}

export function ProposeComposer({ onClose }: ProposeComposerProps) {
  const { t } = useTranslation();
  const propose = useMarriageStore((s) => s.propose);
  const [receiver, setReceiver] = useState('');
  const [message, setMessage] = useState('');

  function send() {
    const nick = receiver.trim().replace(/^@/, '');
    if (nick.length === 0) {
      toast.info(t('marriage.needReceiver'));
      return;
    }
    const body = message.trim();
    if (body.length === 0) {
      toast.info(t('marriage.needMessage'));
      return;
    }
    propose(nick, body);
    toast.success(t('marriage.sent', { nick }));
    onClose();
  }

  return (
    <FullScreenOverlay z={50}>
      <div className="flex h-full w-full flex-col items-center bg-[#fff0f4]">
        <div className="flex h-full w-full max-w-[645px] flex-col overflow-hidden bg-[#fff0f4]">
          <ScreenHeader title={t('marriage.composeTitle')} onBack={onClose}>
            <button
              type="button"
              onClick={send}
              className="rounded-full px-3 py-1.5 text-sm font-bold hover:bg-white/15"
            >
              {t('marriage.send')}
            </button>
          </ScreenHeader>
          <div className="flex flex-col gap-3 p-3">
            <input
              value={receiver}
              onChange={(event) => setReceiver(event.target.value)}
              placeholder={t('marriage.receiverHint')}
              className="rounded-lg border border-black/10 bg-white px-3 py-2.5 text-sm outline-none focus:border-[#ff4d7d]"
            />
            <textarea
              value={message}
              onChange={(event) => setMessage(event.target.value)}
              rows={6}
              placeholder={t('marriage.messageHint')}
              className="w-full resize-none rounded-lg border border-black/10 bg-white p-3 text-sm shadow-sm outline-none focus:border-[#ff4d7d]"
            />
          </div>
        </div>
      </div>
    </FullScreenOverlay>
  );
}

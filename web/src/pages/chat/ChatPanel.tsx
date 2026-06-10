import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { Placeholder } from '@components/Placeholder';
import { ConversationList } from './components/ConversationList';
import { ComposeButton } from './components/ComposeButton';

type ChatSub = 'messages' | 'contacts';

export function ChatPanel() {
  const { t } = useTranslation();
  const [sub, setSub] = useState<ChatSub>('messages');

  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center">
          <button
            type="button"
            onClick={() => setSub('messages')}
            className={`flex-1 self-stretch text-base font-medium ${
              sub === 'messages'
                ? 'border-b-2 border-white text-white'
                : 'text-white/70'
            }`}
          >
            {t('home.subMessages')}
          </button>
          <button
            type="button"
            onClick={() => setSub('contacts')}
            className={`flex-1 self-stretch text-base font-medium ${
              sub === 'contacts'
                ? 'border-b-2 border-white text-white'
                : 'text-white/70'
            }`}
          >
            {t('home.subContacts')}
          </button>
          <button type="button" aria-label="Menu" className="px-3 text-xl">
            ⋮
          </button>
        </div>
      </HomeHeader>

      <main className="relative flex-1 overflow-y-auto">
        {sub === 'messages' ? (
          <div className="relative h-full bg-[#f3f3f3]">
            <ConversationList />
            <ComposeButton />
          </div>
        ) : (
          <Placeholder text={t('home.contactsEmpty')} />
        )}
      </main>
    </>
  );
}

import { useTranslation } from 'react-i18next';
import { colorForName, SmileyText } from '@lib';
import {
  friendContentLabel,
  friendContentName,
  useFriendContentNotice,
  useFriendContentStore,
} from '@ola/shared/stores/friendContent';
import { AvatarWithFrame } from './ui/AvatarWithFrame';

export function FriendContentBanner() {
  const { t } = useTranslation();
  const notice = useFriendContentNotice();
  if (notice == null) return null;
  const name = friendContentName(notice);
  const { open, dismiss } = useFriendContentStore.getState();

  return (
    <div className="pointer-events-none absolute inset-x-0 top-0 z-50 flex justify-center px-3 pt-3">
      <div className="animate-ola-drop-in pointer-events-auto flex w-full items-center rounded-2xl bg-white shadow-xl ring-1 ring-black/10">
        <button
          type="button"
          onClick={open}
          className="flex min-w-0 flex-1 items-center gap-3 p-3 text-left"
        >
          <AvatarWithFrame
            name={name}
            src={notice.author.avatar}
            color={colorForName(notice.author.username)}
            frameId={notice.author.avatarFrameId}
            size={40}
          />
          <div className="min-w-0 flex-1">
            <p className="line-clamp-2 text-sm leading-snug text-black/87">
              <span className="font-bold">{name}</span> {friendContentLabel(notice.kind)}
            </p>
            {notice.preview != null && notice.preview !== '' && (
              <p className="mt-0.5 truncate text-sm text-black/54">
                <SmileyText text={notice.preview} />
              </p>
            )}
          </div>
        </button>
        <button
          type="button"
          onClick={dismiss}
          aria-label={t('dialog.close')}
          className="mr-2 flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-xl leading-none text-black/45 active:bg-black/5"
        >
          ×
        </button>
      </div>
    </div>
  );
}

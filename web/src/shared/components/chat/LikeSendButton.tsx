import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { useLongPress } from '@hooks';
import { cn } from '@lib';
import likeIcon from '@/assets/icons/chat/smiley_35.png';

const LIKE_CODE = '(y)';
const BIG_LIKE_CODE = '(Y)';

interface LikeSendButtonProps {
  onSend: (code: string) => void;
  disabled?: boolean;
  className?: string;
}

export function LikeSendButton({
  onSend,
  disabled,
  className,
}: LikeSendButtonProps) {
  const { t } = useTranslation();
  const suppressClick = useRef(false);
  const longPress = useLongPress(() => {
    suppressClick.current = true;
    onSend(BIG_LIKE_CODE);
  });

  return (
    <button
      type="button"
      aria-label={t('chat.like')}
      disabled={disabled}
      {...longPress}
      onPointerDown={(event) => {
        suppressClick.current = false;
        longPress.onPointerDown(event);
      }}
      onClick={() => {
        if (suppressClick.current) {
          suppressClick.current = false;
          return;
        }
        onSend(LIKE_CODE);
      }}
      className={cn(
        'flex h-9 w-9 select-none items-center justify-center',
        className
      )}
    >
      <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
    </button>
  );
}

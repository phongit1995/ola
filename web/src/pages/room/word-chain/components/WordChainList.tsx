import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Spinner } from '@components';
import { colorForName } from '@lib';

export function WordChainUserRow({
  name,
  avatar,
  highlighted,
  leading,
  trailing,
  children,
}: {
  name: string;
  avatar?: string;
  highlighted: boolean;
  leading?: ReactNode;
  trailing: ReactNode;
  children: ReactNode;
}) {
  return (
    <li
      className={`flex items-center gap-2 px-3 py-2 ${
        highlighted ? 'bg-ola-primary-light' : ''
      }`}
    >
      {leading}
      <Avatar name={name} color={colorForName(name)} src={avatar} size={36} />
      <span className="flex min-w-0 flex-1 flex-col">{children}</span>
      {trailing}
    </li>
  );
}

export function WordChainListStatus({
  loading,
  failed,
  emptyText,
  errorText,
  onRetry,
}: {
  loading: boolean;
  failed: boolean;
  emptyText: string;
  errorText: string;
  onRetry: () => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex min-h-0 flex-1 flex-col items-center justify-center gap-2 text-center text-sm text-black/54">
      {loading ? (
        <Spinner size={28} />
      ) : failed ? (
        <>
          <p>{errorText}</p>
          <button
            type="button"
            onClick={onRetry}
            className="rounded-full px-4 py-1.5 font-medium text-ola-primary-ink hover:bg-black/5"
          >
            {t('wordChain.retry')}
          </button>
        </>
      ) : (
        emptyText
      )}
    </div>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';

function isValidImageUrl(value: string): boolean {
  try {
    const parsed = new URL(value);
    return parsed.protocol === 'http:' || parsed.protocol === 'https:';
  } catch {
    return false;
  }
}

interface ComposerCloudPanelProps {
  canAdd: boolean;
  onAdd: (url: string) => void;
}

export function ComposerCloudPanel({ canAdd, onAdd }: ComposerCloudPanelProps) {
  const { t } = useTranslation();
  const [url, setUrl] = useState('');
  const [checking, setChecking] = useState(false);
  const [error, setError] = useState<'invalid' | 'load' | null>(null);

  function add() {
    const value = url.trim();
    if (!isValidImageUrl(value)) {
      setError('invalid');
      return;
    }
    if (!canAdd) return;
    setChecking(true);
    setError(null);
    const probe = new Image();
    probe.onload = () => {
      setChecking(false);
      setUrl('');
      onAdd(value);
    };
    probe.onerror = () => {
      setChecking(false);
      setError('load');
    };
    probe.src = value;
  }

  return (
    <div className="mt-2 rounded-md border border-black/12 p-2">
      <div className="flex gap-2">
        <input
          type="url"
          value={url}
          onChange={(event) => {
            setUrl(event.target.value);
            setError(null);
          }}
          onKeyDown={(event) => {
            if (event.key === 'Enter') {
              event.preventDefault();
              add();
            }
          }}
          placeholder={t('me.cloudUrlHint')}
          disabled={!canAdd}
          className="min-w-0 flex-1 rounded border border-black/12 px-2 py-1 text-sm text-black/87 outline-none focus:border-ola-primary disabled:opacity-50"
        />
        <button
          type="button"
          onClick={add}
          disabled={checking || !canAdd}
          className="shrink-0 rounded bg-ola-primary px-3 py-1 text-sm text-white disabled:opacity-50"
        >
          {checking ? t('me.cloudChecking') : t('me.cloudAdd')}
        </button>
      </div>
      {error === 'invalid' && <p className="mt-1 text-xs text-ola-error">{t('me.cloudInvalid')}</p>}
      {error === 'load' && <p className="mt-1 text-xs text-ola-error">{t('me.cloudLoadError')}</p>}
      {!canAdd && <p className="mt-1 text-xs text-black/40">{t('me.maxImages')}</p>}
    </div>
  );
}

import { useTranslation } from 'react-i18next';
import { SUPPORTED_LANGUAGES, type Language } from '@/i18n';

const LABELS: Record<Language, string> = { vi: 'VI', en: 'EN' };

interface LanguageSwitcherProps {
  tone?: 'light' | 'dark';
  className?: string;
}

export function LanguageSwitcher({
  tone = 'light',
  className = '',
}: LanguageSwitcherProps) {
  const { i18n } = useTranslation();
  const current = i18n.resolvedLanguage;

  return (
    <div className={`flex items-center gap-1 text-xs ${className}`}>
      {SUPPORTED_LANGUAGES.map((lng) => {
        const isActive = current === lng;
        const activeClass =
          tone === 'light'
            ? 'bg-white/30 font-semibold text-white'
            : 'bg-ola-primary font-semibold text-ola-on-primary';
        const idleClass = tone === 'light' ? 'text-white/70' : 'text-gray-500';
        return (
          <button
            key={lng}
            type="button"
            onClick={() => i18n.changeLanguage(lng)}
            className={`rounded px-2 py-0.5 ${
              isActive ? activeClass : idleClass
            }`}
          >
            {LABELS[lng]}
          </button>
        );
      })}
    </div>
  );
}

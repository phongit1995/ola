import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ChevronIcon } from './platformIcons';

interface FaqItem {
  question: string;
  answer: string;
}

export function DownloadFaq() {
  const { t } = useTranslation();
  const items = t('download.faq', {
    returnObjects: true,
  }) as unknown as FaqItem[];
  const [openQuestion, setOpenQuestion] = useState<string | null>(null);

  return (
    <section className="overflow-hidden rounded-2xl bg-white shadow-sm ring-1 ring-black/5">
      <header className="border-b border-black/6 px-4 py-3">
        <h2 className="text-base font-bold text-black/85">
          {t('download.faqTitle')}
        </h2>
      </header>
      {items.map((item) => {
        const open = openQuestion === item.question;
        return (
          <div
            key={item.question}
            className="border-b border-black/6 last:border-b-0"
          >
            <button
              type="button"
              onClick={() => setOpenQuestion(open ? null : item.question)}
              aria-expanded={open}
              className="flex w-full items-center gap-2 px-4 py-3 text-left"
            >
              <span className="min-w-0 flex-1 text-[13px] font-semibold text-black/80">
                {item.question}
              </span>
              <ChevronIcon
                className={`h-4.5 w-4.5 shrink-0 text-black/35 transition-transform ${
                  open ? 'rotate-90' : ''
                }`}
              />
            </button>
            {open && (
              <p className="px-4 pb-3.5 text-[13px] leading-relaxed text-black/65">
                {item.answer}
              </p>
            )}
          </div>
        );
      })}
    </section>
  );
}

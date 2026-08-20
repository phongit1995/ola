import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

type LegalBlock = { type: 'p'; text: string } | { type: 'ul'; items: string[] };

interface LegalSection {
  title: string;
  blocks: LegalBlock[];
}

export type LegalNamespace = 'terms' | 'privacyPolicy';

export function LegalDocument({ namespace }: { namespace: LegalNamespace }) {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const sections = t(`${namespace}.sections`, {
    returnObjects: true,
  }) as unknown as LegalSection[];

  return (
    <div className="h-full overflow-y-auto bg-[#f0f7f0] font-sans text-gray-800">
      <header className="bg-gradient-to-br from-ola-primary-dark to-ola-primary pt-4 pb-6">
        <div className="mx-auto max-w-2xl px-4">
          <button
            type="button"
            onClick={() => navigate(-1)}
            className="text-sm text-white/90"
          >
            {t(`${namespace}.back`)}
          </button>

          <div className="mt-3 text-center">
            <img
              src="/favicon.png"
              alt="Ola"
              className="mx-auto mb-3 h-16 w-16 rounded-2xl shadow-lg"
            />
            <h1 className="text-xl font-bold tracking-wide text-white">
              {t(`${namespace}.title`)}
            </h1>
            <p className="mt-1.5 text-[13px] text-white/85">
              {t(`${namespace}.subtitle`)}
            </p>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 pt-6 pb-14">
        <p className="mb-4 text-center text-xs text-[#5a7a5d]">
          {t(`${namespace}.updated`)}
        </p>

        {sections.map((section) => (
          <section
            key={section.title}
            className="mb-4 rounded-xl bg-white px-4 py-5 shadow-[0_2px_10px_rgba(0,0,0,.06)] [&_li]:mb-2 [&_li]:text-sm [&_p]:mb-2 [&_p]:text-sm [&_ul]:list-disc [&_ul]:pl-5"
          >
            <h2 className="mb-2.5 text-base font-extrabold tracking-wide text-ola-primary-dark">
              {section.title}
            </h2>
            {section.blocks.map((block, index) =>
              block.type === 'ul' ? (
                <ul key={index}>
                  {block.items.map((item, itemIndex) => (
                    <li key={itemIndex}>{item}</li>
                  ))}
                </ul>
              ) : (
                <p key={index}>{block.text}</p>
              )
            )}
          </section>
        ))}
      </main>

      <footer className="px-4 pb-5 text-center text-xs text-[#7a9a7d]">
        {t(`${namespace}.footer`)}
      </footer>
    </div>
  );
}

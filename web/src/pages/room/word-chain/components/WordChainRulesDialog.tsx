import { useTranslation } from 'react-i18next';
import { Dialog } from '@components';

const RULE_KEYS = [
  'wordChain.rule1',
  'wordChain.rule2',
  'wordChain.rule3',
  'wordChain.rule4',
  'wordChain.rule5',
  'wordChain.rule6',
  'wordChain.rule7',
] as const;

interface WordChainRulesDialogProps {
  open: boolean;
  onClose: () => void;
}

export function WordChainRulesDialog({
  open,
  onClose,
}: WordChainRulesDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wordChain.rulesTitle')}
      showClose
    >
      <ol className="flex list-decimal flex-col gap-1.5 py-1 pl-5 text-sm text-black/80">
        {RULE_KEYS.map((key) => (
          <li key={key}>{t(key)}</li>
        ))}
      </ol>
    </Dialog>
  );
}

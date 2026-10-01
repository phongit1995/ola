import { useTranslation } from 'react-i18next';
import { ScrollView, Text, View } from 'react-native';
import { Dialog } from '@components/ui/Dialog';

const RULE_KEYS = [
  'wordChain.rule1',
  'wordChain.rule2',
  'wordChain.rule3',
  'wordChain.rule4',
  'wordChain.rule5',
  'wordChain.rule6',
  'wordChain.rule7',
] as const;

export function WordChainRulesDialog({
  visible,
  onClose,
}: {
  visible: boolean;
  onClose: () => void;
}) {
  const { t } = useTranslation();
  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('wordChain.rulesTitle')}
      showClose
      avoidKeyboard={false}
    >
      <ScrollView>
        <View className="py-1" style={{ gap: 6 }}>
          {RULE_KEYS.map((key, index) => (
            <View key={key} className="flex-row" style={{ gap: 6 }}>
              <Text className="text-sm" style={{ width: 18, color: 'rgba(0,0,0,0.8)' }}>
                {index + 1}.
              </Text>
              <Text className="flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
                {t(key)}
              </Text>
            </View>
          ))}
        </View>
      </ScrollView>
    </Dialog>
  );
}

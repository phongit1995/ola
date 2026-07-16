import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Modal, ScrollView, Text, View } from 'react-native';
import { useMarriageStore } from '@ola/shared/stores/marriageStore';
import { MarriageBoxView } from './MarriageBoxView';
import { MarriageLockedView } from './MarriageLockedView';
import { ProposeComposer } from './ProposeComposer';
import { ScreenHeader } from '@components/ScreenHeader';

interface MarriageScreenProps {
  onClose: () => void;
}

export function MarriageScreen({ onClose }: MarriageScreenProps) {
  const { t } = useTranslation();
  const status = useMarriageStore((s) => s.status);
  const loading = useMarriageStore((s) => s.loading);
  const loaded = useMarriageStore((s) => s.loaded);
  const load = useMarriageStore((s) => s.load);
  const [composeOpen, setComposeOpen] = useState(false);

  useEffect(() => {
    void load().catch(() => undefined);
  }, [load]);

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      {composeOpen ? (
        <ProposeComposer onClose={() => setComposeOpen(false)} />
      ) : (
        <View className="flex-1 bg-white">
          <ScreenHeader title={t('marriage.title')} centerTitle onBack={onClose} />

          {!loaded && loading ? (
            <View className="flex-1 items-center justify-center">
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.5)' }}>
                {t('common.loading')}
              </Text>
              <ActivityIndicator className="mt-2" color="#ff4d7d" />
            </View>
          ) : (
            <ScrollView className="flex-1 bg-white" keyboardShouldPersistTaps="handled">
              {status === 'married' ? (
                <MarriageBoxView />
              ) : (
                <MarriageLockedView onPropose={() => setComposeOpen(true)} />
              )}
            </ScrollView>
          )}
        </View>
      )}
    </Modal>
  );
}

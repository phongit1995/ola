import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, ScrollView, Text, View } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { useMarriageStore } from '@ola/shared/stores/marriageStore';
import { MarriageBoxView } from './MarriageBoxView';
import { MarriageLockedView } from './MarriageLockedView';
import { ProposeComposer } from './ProposeComposer';
import { ScreenHeader } from '@components/ui/ScreenHeader';

export function MarriageScreen() {
  const { t } = useTranslation();
  const navigation = useNavigation();
  const status = useMarriageStore((s) => s.status);
  const loading = useMarriageStore((s) => s.loading);
  const loaded = useMarriageStore((s) => s.loaded);
  const load = useMarriageStore((s) => s.load);
  const [composeOpen, setComposeOpen] = useState(false);

  useEffect(() => {
    void load().catch(() => undefined);
  }, [load]);

  if (composeOpen) {
    return <ProposeComposer onClose={() => setComposeOpen(false)} />;
  }

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('marriage.title')} centerTitle onBack={() => navigation.goBack()} />

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
  );
}

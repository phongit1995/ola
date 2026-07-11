import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import { usePenHistoryStore, type PenHistorySection as SectionRole } from '@ola/shared/stores/penHistoryStore';
import { penHistoryAssets, penShootAssets } from './penAssets';
import { PenBg, PenPanel, penTextShadow } from './penUi';
import { PenHistorySection } from './PenHistorySection';
import { PenAllHistorySection } from './PenAllHistorySection';

interface PenHistoryModalProps {
  userId?: string;
  onClose: () => void;
}

export function PenHistoryModal({ userId, onClose }: PenHistoryModalProps) {
  const { t } = useTranslation();
  const reset = usePenHistoryStore((s) => s.reset);
  const [tab, setTab] = useState<SectionRole>('shoot');

  useEffect(() => reset, [reset]);

  const tabs: { key: SectionRole; label: string }[] = [
    { key: 'shoot', label: t('penGame.hist.tabShot') },
    { key: 'catch', label: t('penGame.hist.tabCatch') },
    { key: 'all', label: t('penGame.hist.tabAll') },
  ];
  const opponentLabel = tab === 'shoot' ? t('penGame.hist.colCatcher') : t('penGame.hist.colShooter');

  return (
    <Pressable
      onPress={onClose}
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        zIndex: 40,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: 'rgba(0,0,0,0.55)',
        paddingHorizontal: 8,
      }}
    >
      <Pressable onPress={() => {}} style={{ width: '100%', maxHeight: '92%' }}>
        <PenPanel style={{ maxHeight: '100%' }}>
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 8,
              paddingHorizontal: 48,
              paddingTop: 16,
              paddingBottom: 8,
            }}
          >
            <Image
              source={penHistoryAssets.clock}
              style={{ width: 28, height: 28 }}
              resizeMode="contain"
            />
            <Text
              style={[
                {
                  color: '#ffffff',
                  fontSize: 30,
                  fontWeight: '800',
                  fontStyle: 'italic',
                  letterSpacing: 1,
                },
                penTextShadow,
              ]}
            >
              {t('penGame.history')}
            </Text>
          </View>

          <Pressable
            accessibilityLabel={t('penGame.close')}
            onPress={onClose}
            style={{
              position: 'absolute',
              right: '4%',
              top: '3.5%',
              width: 36,
              height: 36,
              alignItems: 'center',
              justifyContent: 'center',
              zIndex: 1,
            }}
          >
            <PenBg source={penShootAssets.closeBtn} />
            <Image
              source={penShootAssets.closeIcon}
              style={{ width: 16, height: 16 }}
              resizeMode="contain"
            />
          </Pressable>

          <View
            style={{
              flexDirection: 'row',
              gap: 8,
              paddingHorizontal: 12,
              paddingTop: 8,
              paddingBottom: 8,
            }}
          >
            {tabs.map((item) => {
              const active = item.key === tab;
              return (
                <Pressable
                  key={item.key}
                  onPress={() => setTab(item.key)}
                  style={{
                    flex: 1,
                    alignItems: 'center',
                    paddingVertical: 10,
                    opacity: active ? 1 : 0.4,
                  }}
                >
                  <PenBg source={penHistoryAssets.tab} />
                  <Text
                    numberOfLines={1}
                    style={[
                      { color: '#ffffff', fontSize: 14, fontWeight: '800', letterSpacing: 0.5 },
                      penTextShadow,
                    ]}
                  >
                    {item.label}
                  </Text>
                </Pressable>
              );
            })}
          </View>

          <ScrollView
            style={{ flexShrink: 1, minHeight: 0 }}
            contentContainerStyle={{ paddingHorizontal: 8, paddingBottom: 16 }}
          >
            {tab === 'all' ? (
              <PenAllHistorySection />
            ) : (
              <PenHistorySection section={tab} opponentLabel={opponentLabel} userId={userId} />
            )}
          </ScrollView>
        </PenPanel>
      </Pressable>
    </Pressable>
  );
}

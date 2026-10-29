import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { SvgXml, type Svg } from 'react-native-svg';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { DIVIDER, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { savePngBase64ToGallery } from '@lib/saveImage';
import { recordAppError } from '@lib/telemetry';
import { QR_SIZE } from '../constants';

const QR_SAVE_SIZE = 540;

interface LoadedQr {
  uri: string;
  xml: string | null;
}

export function TopupQrCode({ uri }: { uri: string }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const svgRef = useRef<Svg>(null);
  const [loaded, setLoaded] = useState<LoadedQr | null>(null);
  const [saving, setSaving] = useState(false);
  const current = loaded?.uri === uri ? loaded : null;
  const xml = current?.xml ?? null;

  useEffect(() => {
    let cancelled = false;
    fetch(uri)
      .then((response) => {
        if (!response.ok) throw new Error(`QR download failed with HTTP ${response.status}`);
        return response.text();
      })
      .then((text) => {
        if (!cancelled) setLoaded({ uri, xml: text });
      })
      .catch(() => {
        if (!cancelled) setLoaded({ uri, xml: null });
      });
    return () => {
      cancelled = true;
    };
  }, [uri]);

  function finishSave(ok: boolean) {
    push(ok ? 'success' : 'error', t(ok ? 'ken.buy.qrSaved' : 'ken.buy.qrSaveFailed'));
    setSaving(false);
  }

  function saveQr() {
    const svg = svgRef.current;
    if (svg == null || saving) return;
    setSaving(true);
    svg.toDataURL(
      (base64) => {
        if (!base64) {
          finishSave(false);
          return;
        }
        savePngBase64ToGallery(base64)
          .then(finishSave)
          .catch((error) => {
            recordAppError(error, 'saveTopupQr');
            finishSave(false);
          });
      },
      { width: QR_SAVE_SIZE, height: QR_SAVE_SIZE },
    );
  }

  const saveDisabled = xml == null || saving;

  return (
    <View className="mt-3 items-center">
      <View
        className="rounded p-2"
        style={{ borderWidth: 1, borderColor: DIVIDER, backgroundColor: '#ffffff' }}
      >
        <View
          className="items-center justify-center"
          style={{ width: QR_SIZE, height: QR_SIZE }}
        >
          {xml != null ? (
            <SvgXml xml={xml} override={{ ref: svgRef, width: QR_SIZE, height: QR_SIZE }} />
          ) : current == null ? (
            <ActivityIndicator color={colors.primary} />
          ) : (
            <Text className="px-4 text-center text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('common.error')}
            </Text>
          )}
        </View>
      </View>
      <Pressable
        onPress={saveQr}
        disabled={saveDisabled}
        className="mt-2 rounded px-3 py-1.5 active:bg-black/5"
        style={{ borderWidth: 1, borderColor: DIVIDER, opacity: saveDisabled ? 0.5 : 1 }}
      >
        <Text className="text-xs font-medium" style={{ color: colors.primary }}>
          {t('ken.buy.saveQr')}
        </Text>
      </Pressable>
    </View>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';
import { REPORT_REASONS, type ReportReason } from '@ola/shared/constants';
import type { ReportTarget } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { Dialog, DialogButton } from './Dialog';

interface ReportDialogProps {
  target: ReportTarget;
  onClose: () => void;
}

export function ReportDialog({ onClose }: ReportDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const [reason, setReason] = useState<ReportReason | null>(null);
  const [note, setNote] = useState('');

  function submit() {
    if (reason == null) return;
    push('success', t('report.sent'));
    onClose();
  }

  return (
    <Dialog
      visible
      onClose={onClose}
      title={t('report.title')}
      footer={
        <>
          <DialogButton onPress={onClose}>{t('dialog.cancel')}</DialogButton>
          <DialogButton variant="green" disabled={reason == null} onPress={submit}>
            {t('report.send')}
          </DialogButton>
        </>
      }
    >
      <View>
        {REPORT_REASONS.map((item, index) => {
          const selected = reason === item.value;
          return (
            <Pressable
              key={item.value}
              onPress={() => setReason(item.value)}
              className="flex-row items-center gap-2 px-1 py-2.5 active:bg-black/5"
              style={
                index > 0
                  ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' }
                  : null
              }
            >
              <View
                className="items-center justify-center rounded-full"
                style={{
                  width: 18,
                  height: 18,
                  borderWidth: 2,
                  borderColor: selected ? colors.primary : 'rgba(0,0,0,0.3)',
                }}
              >
                {selected && (
                  <View
                    className="rounded-full"
                    style={{ width: 10, height: 10, backgroundColor: colors.primary }}
                  />
                )}
              </View>
              <Text className="flex-1 text-sm text-ola-ink">
                {t(item.labelKey)}
              </Text>
            </Pressable>
          );
        })}
        <TextInput
          multiline
          value={note}
          onChangeText={setNote}
          placeholder={t('report.notePlaceholder')}
          placeholderTextColor="rgba(0,0,0,0.38)"
          maxLength={500}
          className="mt-2 rounded-sm bg-white p-2 text-sm"
          style={{
            minHeight: 72,
            textAlignVertical: 'top',
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.12)',
            color: 'rgba(0,0,0,0.87)',
          }}
        />
      </View>
    </Dialog>
  );
}

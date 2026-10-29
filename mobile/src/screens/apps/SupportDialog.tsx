import { useCallback, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Linking, Platform, Pressable, Text, View } from 'react-native';
import { SUPPORT_ACCOUNT_USERNAME, SUPPORT_EMAIL } from '@ola/shared/constants';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { Dialog } from '@components/ui/Dialog';

const supportIcon = require('@assets/icons/apps/support.png');

const ROW_DIVIDER = { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' };

interface SupportDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function SupportDialog({ visible, onClose }: SupportDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore(s => s.push);
  const mailPendingRef = useRef(false);

  const openPendingMail = useCallback(() => {
    if (!mailPendingRef.current) return;
    mailPendingRef.current = false;
    void Linking.openURL(`mailto:${SUPPORT_EMAIL}`).catch(() =>
      push('info', t('support.emailUnavailable', { email: SUPPORT_EMAIL })),
    );
  }, [push, t]);

  const sendMail = useCallback(() => {
    if (mailPendingRef.current) return;
    mailPendingRef.current = true;
    onClose();
    if (Platform.OS !== 'ios') requestAnimationFrame(openPendingMail);
  }, [onClose, openPendingMail]);

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      onDismiss={openPendingMail}
      title={t('support.title')}
      icon={supportIcon}
    >
      <View style={{ marginHorizontal: -8, marginVertical: -4 }}>
        <View className="min-h-16 justify-center px-4 py-2">
          <Text className="text-base font-semibold text-black/87">
            {t('support.contactAccount')}{' '}
            <Text className="text-ola-accent">@{SUPPORT_ACCOUNT_USERNAME}</Text>
          </Text>
        </View>
        <Pressable
          accessibilityRole="link"
          onPress={sendMail}
          className="min-h-16 flex-row items-center gap-3 px-4 py-2 active:bg-black/5"
          style={ROW_DIVIDER}
        >
          <Text numberOfLines={1} className="min-w-0 flex-1 text-base font-semibold text-black/87">
            {t('support.emailLabel')}{' '}
            <Text className="text-ola-primary underline">{SUPPORT_EMAIL}</Text>
          </Text>
          <Text className="text-lg text-black/40">{'↗'}</Text>
        </Pressable>
      </View>
    </Dialog>
  );
}

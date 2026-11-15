import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { BackHandler, StyleSheet, Text, View } from 'react-native';
import { socialLimitMessage, useSocialLimitStore } from '@ola/shared/stores/socialLimit';
import { DialogButton, DialogFrame } from '@components/ui/Dialog';
import { registerSocialLimitOverlay } from './socialLimitSlot';

const infoIcon = require('@assets/icons/chat/ic_dialog_indicate_info.png');

export function SocialLimitOverlay() {
  const { t } = useTranslation();
  const notice = useSocialLimitStore((state) => state.notice);
  const close = useSocialLimitStore((state) => state.close);
  const requestBuy = useSocialLimitStore((state) => state.requestBuy);
  const open = notice != null;

  useEffect(() => {
    if (!open) return;
    const sub = BackHandler.addEventListener('hardwareBackPress', () => {
      close();
      return true;
    });
    return () => sub.remove();
  }, [open, close]);

  if (notice == null) return null;
  const canBuy = !notice.isVip;

  return (
    <View style={StyleSheet.absoluteFill}>
      <DialogFrame
        onClose={close}
        title={t('socialLimit.title')}
        icon={infoIcon}
        avoidKeyboard={false}
        footer={
          canBuy ? (
            <>
              <DialogButton variant="green" onPress={requestBuy}>
                {t('socialLimit.buyVip')}
              </DialogButton>
              <DialogButton onPress={close}>{t('socialLimit.confirm')}</DialogButton>
            </>
          ) : (
            <DialogButton variant="green" onPress={close}>
              {t('socialLimit.confirm')}
            </DialogButton>
          )
        }
      >
        <Text className="text-sm leading-relaxed" style={{ color: '#616163' }}>
          {socialLimitMessage(notice)}
        </Text>
      </DialogFrame>
    </View>
  );
}

registerSocialLimitOverlay(SocialLimitOverlay);

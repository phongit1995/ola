import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, StyleSheet, Text, View } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { clearSavedAccounts, signOut } from '@lib/session';
import { useAppLockStore } from '@store/appLockStore';
import { AppLockExemptContext, registerAppLockOverlay, useBlockedByAppLock } from './appLockModal';
import { PinVerify } from './PinVerify';

const logo = require('@assets/ola-logo.png');

function LockScreen() {
  const { t } = useTranslation();
  const unlock = useAppLockStore((s) => s.unlock);
  const [forgotOpen, setForgotOpen] = useState(false);
  const [signingOut, setSigningOut] = useState(false);

  async function forgetPinAndSignOut() {
    if (signingOut) return;
    setSigningOut(true);
    setForgotOpen(false);
    clearSavedAccounts();
    await signOut();
    useAppLockStore.getState().disable();
  }

  return (
    <>
      <PinVerify
        title={t('appLock.enterPin')}
        allowBiometric
        autoPrompt
        onSuccess={unlock}
        footer={
          <Pressable
            onPress={() => setForgotOpen(true)}
            disabled={signingOut}
            hitSlop={8}
            className="px-3 py-1"
          >
            <Text className="text-sm text-white/80 underline">{t('appLock.forgotPin')}</Text>
          </Pressable>
        }
      />
      <ConfirmDialog
        visible={forgotOpen}
        danger
        title={t('appLock.forgotTitle')}
        message={t('appLock.forgotMessage')}
        confirmLabel={t('appLock.forgotConfirm')}
        onConfirm={() => void forgetPinAndSignOut()}
        onCancel={() => setForgotOpen(false)}
      />
    </>
  );
}

function PrivacyCover() {
  const colors = useThemeColors();
  return (
    <View className="flex-1 items-center justify-center" style={{ backgroundColor: colors.primary }}>
      <Image source={logo} style={{ width: 96, height: 96 }} resizeMode="contain" />
    </View>
  );
}

/**
 * Lớp khoá/che đặt ở root và bên trong MỌI Modal (OlaModal, Dialog). Modal
 * native luôn nằm trên view thường nên không thể đè từ ngoài vào; thay vì ẩn
 * modal (mất bản nháp), mỗi modal tự vẽ lớp này lên trên nội dung của nó.
 */
export function AppLockOverlay() {
  const blocked = useBlockedByAppLock();
  const locked = useAppLockStore((s) => s.locked);
  if (!blocked) return null;
  return (
    <AppLockExemptContext.Provider value>
      <View
        style={[StyleSheet.absoluteFill, { zIndex: 10000, elevation: 10000 }]}
        pointerEvents={locked ? 'auto' : 'none'}
      >
        <SafeAreaProvider style={{ flex: 1 }}>
          {locked ? <LockScreen /> : <PrivacyCover />}
        </SafeAreaProvider>
      </View>
    </AppLockExemptContext.Provider>
  );
}

registerAppLockOverlay(AppLockOverlay);

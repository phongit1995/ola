import { useEffect, useRef, useState } from 'react';
import { AppState, Text } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { openStoreForUpdate } from '@lib/appUpdate';
import { useAppUpdateStore } from '@store/appUpdateStore';

const PRESENT_RETRY_MS = 1500;

function noop() {}

export function AppUpdateGate() {
  const { t } = useTranslation();
  const required = useAppUpdateStore((s) => s.required);
  const [attempt, setAttempt] = useState(0);
  const shownRef = useRef(false);

  useEffect(() => {
    const { check } = useAppUpdateStore.getState();
    void check();
    const subscription = AppState.addEventListener('change', (state) => {
      if (state === 'active') void check();
    });
    return () => subscription.remove();
  }, []);

  // iOS bỏ qua lần present Modal nếu lúc đó đang có màn khác chen vào (vừa mở app, redbox...) và không tự thử lại; chưa thấy onShow thì gắn lại Dialog.
  useEffect(() => {
    if (!required) {
      shownRef.current = false;
      return;
    }
    if (shownRef.current) return;
    const timer = setTimeout(() => {
      if (!shownRef.current) setAttempt((value) => value + 1);
    }, PRESENT_RETRY_MS);
    return () => clearTimeout(timer);
  }, [required, attempt]);

  if (!required) return null;

  return (
    <Dialog
      key={attempt}
      visible
      onShow={() => {
        shownRef.current = true;
      }}
      onClose={noop}
      dismissOnBackdrop={false}
      avoidKeyboard={false}
      title={t('appUpdate.title')}
      footer={
        <DialogButton variant="green" onPress={() => void openStoreForUpdate()}>
          {t('appUpdate.updateNow')}
        </DialogButton>
      }
    >
      <Text className="py-1 text-sm" style={{ color: 'rgba(0,0,0,0.75)' }}>
        {t('appUpdate.requiredBody')}
      </Text>
    </Dialog>
  );
}

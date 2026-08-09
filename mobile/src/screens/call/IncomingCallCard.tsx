import { useEffect, useState } from 'react';
import { Pressable, Text, Vibration, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useThemeColors } from '@hooks/useThemeColors';
import { Avatar } from '@components/ui/Avatar';
import {
  callPeerNameView,
  colorForName,
  peerDisplayName,
} from '@ola/shared/lib';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { useCallStore } from '@store/callStore';
import { CALL_BG } from './constants';
import { EndCallIcon, PhoneIcon } from './icons';
import { ensureCallPermissions } from './lib/callPermissionGuard';
import { CALL_TYPE } from '@ola/shared/constants';

const RING_PATTERN = [0, 700, 1300];

function useRingVibration(enabled: boolean) {
  useEffect(() => {
    if (!enabled) return;
    if (!useSettingsStore.getState().settings.notifSound) return;
    Vibration.vibrate(RING_PATTERN, true);
    return () => Vibration.cancel();
  }, [enabled]);
}

export function IncomingCallCard() {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const incoming = useCallStore((s) => s.incoming);
  const pendingAction = useCallStore((s) => s.pendingAction);
  const answerIncoming = useCallStore((s) => s.answerIncoming);
  const declineIncoming = useCallStore((s) => s.declineIncoming);
  const [answering, setAnswering] = useState(false);

  useRingVibration(incoming != null);

  if (incoming == null) return null;

  const name = peerDisplayName(incoming.caller, t('call.unknownUser'));
  const nameView = callPeerNameView(incoming.caller, t('call.unknownUser'));
  const title =
    incoming.callType === CALL_TYPE.video
      ? t('call.incomingVideoCall')
      : t('call.incomingVoiceCall');
  const busy = pendingAction != null || answering;

  const handleAccept = async () => {
    if (busy) return;
    setAnswering(true);
    try {
      const allowed = await ensureCallPermissions(incoming.callType, t);
      if (!allowed) {
        await declineIncoming();
        return;
      }
      await answerIncoming();
    } finally {
      setAnswering(false);
    }
  };

  return (
    <View
      className="flex-1 items-center justify-between"
      style={{
        backgroundColor: CALL_BG,
        paddingTop: insets.top + 64,
        paddingBottom: insets.bottom + 56,
      }}
    >
        <View className="items-center gap-4 px-6">
        <Avatar
          name={name}
          uri={incoming.caller.avatar}
          size={112}
          color={colorForName(name)}
        />
        <Text className="text-xl font-bold text-white" numberOfLines={1}>
          {nameView.title}
        </Text>
        {nameView.subtitle != null && (
          <Text className="text-sm text-white/80" numberOfLines={1}>
            {nameView.subtitle}
          </Text>
        )}
        <Text className="text-sm text-white/70">{title}</Text>
      </View>

      <View className="w-full flex-row items-center justify-evenly">
        <Pressable
          accessibilityLabel={t('call.decline')}
          disabled={busy}
          onPress={() => void declineIncoming()}
          className="items-center gap-2"
          style={{ opacity: busy ? 0.4 : 1 }}
        >
          <View className="h-16 w-16 items-center justify-center rounded-full bg-ola-error">
            <EndCallIcon size={28} />
          </View>
          <Text className="text-xs text-white/70">{t('call.decline')}</Text>
        </Pressable>

        <Pressable
          accessibilityLabel={t('call.accept')}
          disabled={busy}
          onPress={() => void handleAccept()}
          className="items-center gap-2"
          style={{ opacity: busy ? 0.4 : 1 }}
        >
          <View className="h-16 w-16 items-center justify-center rounded-full bg-ola-button">
            <PhoneIcon size={28} color={colors.primaryDarker} />
          </View>
          <Text className="text-xs text-white/70">{t('call.accept')}</Text>
        </Pressable>
      </View>
    </View>
  );
}

import { Image, Pressable, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import type { ImageSourcePropType } from 'react-native';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useLastKeyboardHeight } from '@hooks/useKeyboardHeight';
import { SmileyKulPanel, SMILEY_PANEL_MIN_CONTENT_HEIGHT } from '@screens/room/components/SmileyKulPanel';
import { VoicePanel } from './VoicePanel';
import type { VoiceRecording } from '@hooks/useVoiceRecorder';

export type AttachTab = 'smiley' | 'camera' | 'photo' | 'voice' | 'more';

const TAB_ICONS: Record<AttachTab, { icon: ImageSourcePropType; active: ImageSourcePropType }> = {
  smiley: {
    icon: require('@assets/icons/chat/ic_smiley.png'),
    active: require('@assets/icons/chat/ic_smiley_selected.png'),
  },
  camera: {
    icon: require('@assets/icons/chat/ic_camera.png'),
    active: require('@assets/icons/chat/ic_camera_selected.png'),
  },
  photo: {
    icon: require('@assets/icons/chat/ic_local.png'),
    active: require('@assets/icons/chat/ic_local_selected.png'),
  },
  voice: {
    icon: require('@assets/icons/chat/ic_voice.png'),
    active: require('@assets/icons/chat/ic_voice_selected.png'),
  },
  more: {
    icon: require('@assets/icons/chat/ic_more.png'),
    active: require('@assets/icons/chat/ic_more_selected.png'),
  },
};

const ALL_TABS: AttachTab[] = ['smiley', 'camera', 'photo', 'voice', 'more'];

interface AttachmentBarProps {
  openTab: AttachTab | null;
  bottomInset?: number;
  onToggleTab: (tab: AttachTab) => void;
  onPickEmoji: (code: string) => void;
  onBackspace: () => void;
  onSendKul: (index: number) => void;
  onPickImage?: () => void;
  onPickCamera?: () => void;
  onRecorded?: (recording: VoiceRecording) => void;
  onTransferKen?: () => void;
  onTradingVip?: () => void;
  onSendVipDays?: () => void;
}

function MorePanel({
  onTransferKen,
  onTradingVip,
  onSendVipDays,
}: {
  onTransferKen?: () => void;
  onTradingVip?: () => void;
  onSendVipDays?: () => void;
}) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  const buttons: Array<{ key: string; label: string; onPress: () => void }> = [
    {
      key: 'location',
      label: t('chat.attachSendLocation'),
      onPress: () => push('info', t('chat.comingSoon')),
    },
    {
      key: 'transfer-ken',
      label: t('chat.attachTransferKen'),
      onPress: () => (onTransferKen != null ? onTransferKen() : push('info', t('chat.comingSoon'))),
    },
    {
      key: 'trading-vip',
      label: t('chat.attachTradingVip'),
      onPress: () => (onTradingVip != null ? onTradingVip() : push('info', t('chat.comingSoon'))),
    },
    {
      key: 'send-vip-days',
      label: t('chat.attachSendVipDays'),
      onPress: () => (onSendVipDays != null ? onSendVipDays() : push('info', t('chat.comingSoon'))),
    },
  ];

  return (
    <View className="gap-2 px-4 py-2">
      {buttons.map((button) => (
        <Pressable
          key={button.key}
          onPress={button.onPress}
          className="h-10 w-full items-center justify-center rounded bg-white active:bg-black/5"
          style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.15)' }}
        >
          <Text className="text-sm font-medium text-ola-ink">
            {button.label}
          </Text>
        </Pressable>
      ))}
    </View>
  );
}

export function AttachmentBar({
  openTab,
  bottomInset = 0,
  onToggleTab,
  onPickEmoji,
  onBackspace,
  onSendKul,
  onPickImage,
  onPickCamera,
  onRecorded,
  onTransferKen,
  onTradingVip,
  onSendVipDays,
}: AttachmentBarProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const lastKeyboardHeight = useLastKeyboardHeight();
  const panelContentHeight = Math.max(SMILEY_PANEL_MIN_CONTENT_HEIGHT, lastKeyboardHeight - 44);

  function handlePress(tab: AttachTab) {
    if (tab === 'smiley' || tab === 'more' || tab === 'voice') {
      onToggleTab(tab);
      return;
    }
    if (tab === 'photo' && onPickImage != null) {
      onPickImage();
      return;
    }
    if (tab === 'camera' && onPickCamera != null) {
      onPickCamera();
      return;
    }
    push('info', t('chat.comingSoon'));
  }

  return (
    <View
      className="bg-white"
      style={{
        borderTopWidth: 1,
        borderTopColor: 'rgba(0,0,0,0.12)',
        paddingBottom: bottomInset,
      }}
    >
      <View className="flex-row">
        {ALL_TABS.map((tab) => {
          const active = tab === openTab;
          return (
            <Pressable
              key={tab}
              onPress={() => handlePress(tab)}
              className="h-11 flex-1 items-center justify-center"
              style={{ opacity: active ? 1 : 0.6 }}
            >
              <Image
                source={active ? TAB_ICONS[tab].active : TAB_ICONS[tab].icon}
                style={{ width: 24, height: 24 }}
                resizeMode="contain"
              />
            </Pressable>
          );
        })}
      </View>
      {openTab === 'smiley' && (
        <SmileyKulPanel
          contentHeight={panelContentHeight}
          onPickEmoji={onPickEmoji}
          onBackspace={onBackspace}
          onSendKul={onSendKul}
        />
      )}
      {openTab === 'voice' && onRecorded != null && <VoicePanel onRecorded={onRecorded} />}
      {openTab === 'more' && (
        <MorePanel
          onTransferKen={onTransferKen}
          onTradingVip={onTradingVip}
          onSendVipDays={onSendVipDays}
        />
      )}
    </View>
  );
}

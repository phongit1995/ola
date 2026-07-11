import { Image, Pressable, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import type { ImageSourcePropType } from 'react-native';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { SmileyKulPanel } from '../room/SmileyKulPanel';

export type AttachTab = 'smiley' | 'camera' | 'photo' | 'voice' | 'more';

const TAB_ICONS: Record<AttachTab, { icon: ImageSourcePropType; active: ImageSourcePropType }> = {
  smiley: {
    icon: require('../../assets/icons/chat/ic_smiley.png'),
    active: require('../../assets/icons/chat/ic_smiley_selected.png'),
  },
  camera: {
    icon: require('../../assets/icons/chat/ic_camera.png'),
    active: require('../../assets/icons/chat/ic_camera_selected.png'),
  },
  photo: {
    icon: require('../../assets/icons/chat/ic_local.png'),
    active: require('../../assets/icons/chat/ic_local_selected.png'),
  },
  voice: {
    icon: require('../../assets/icons/chat/ic_voice.png'),
    active: require('../../assets/icons/chat/ic_voice_selected.png'),
  },
  more: {
    icon: require('../../assets/icons/chat/ic_more.png'),
    active: require('../../assets/icons/chat/ic_more_selected.png'),
  },
};

const ALL_TABS: AttachTab[] = ['smiley', 'camera', 'photo', 'voice', 'more'];

interface AttachmentBarProps {
  openTab: AttachTab | null;
  onToggleTab: (tab: AttachTab) => void;
  onPickEmoji: (code: string) => void;
  onBackspace: () => void;
  onSendKul: (index: number) => void;
  onPickImage?: () => void;
}

export function AttachmentBar({ openTab, onToggleTab, onPickEmoji, onBackspace, onSendKul, onPickImage }: AttachmentBarProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  function handlePress(tab: AttachTab) {
    if (tab === 'smiley') {
      onToggleTab(tab);
      return;
    }
    if (tab === 'photo' && onPickImage != null) {
      onPickImage();
      return;
    }
    push('info', t('chat.comingSoon'));
  }

  return (
    <View className="bg-white" style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}>
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
        <SmileyKulPanel onPickEmoji={onPickEmoji} onBackspace={onBackspace} onSendKul={onSendKul} />
      )}
    </View>
  );
}

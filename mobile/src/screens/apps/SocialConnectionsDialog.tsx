import { useCallback, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import type { ParseKeys } from 'i18next';
import {
  Image,
  Linking,
  Platform,
  Pressable,
  Text,
  View,
  type ImageSourcePropType,
} from 'react-native';
import { Dialog } from '@components/ui/Dialog';

const socialMenuIcon = require('@assets/icons/social/social-menu-light.png');

interface SocialOption {
  key: string;
  labelKey: ParseKeys;
  icon: ImageSourcePropType;
  url: string;
}

const SOCIAL_OPTIONS: SocialOption[] = [
  {
    key: 'fanpage',
    labelKey: 'social.fanpageTitle',
    icon: require('@assets/icons/social/fanpage.png'),
    url: 'https://www.facebook.com/ola2vn',
  },
  {
    key: 'group',
    labelKey: 'social.groupTitle',
    icon: require('@assets/icons/social/group.png'),
    url: 'https://www.facebook.com/groups/nghienola',
  },
  {
    key: 'tiktok',
    labelKey: 'social.tiktokTitle',
    icon: require('@assets/icons/social/tiktok.png'),
    url: 'https://www.tiktok.com/@olachat.net',
  },
];

interface SocialConnectionsDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function SocialConnectionsDialog({
  visible,
  onClose,
}: SocialConnectionsDialogProps) {
  const { t } = useTranslation();
  const pendingUrlRef = useRef<string | null>(null);

  const openPendingUrl = useCallback(() => {
    const url = pendingUrlRef.current;
    pendingUrlRef.current = null;
    if (url != null) void Linking.openURL(url).catch(() => undefined);
  }, []);

  const selectOption = useCallback(
    (url: string) => {
      if (pendingUrlRef.current != null) return;
      pendingUrlRef.current = url;
      onClose();
      if (Platform.OS !== 'ios') requestAnimationFrame(openPendingUrl);
    },
    [onClose, openPendingUrl],
  );

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      onDismiss={openPendingUrl}
      title={t('social.title')}
      icon={socialMenuIcon}
    >
      <View style={{ marginHorizontal: -8, marginVertical: -4 }}>
        {SOCIAL_OPTIONS.map((option, index) => (
          <Pressable
            key={option.key}
            accessibilityRole="button"
            onPress={() => selectOption(option.url)}
            className="min-h-16 flex-row items-center gap-3 px-4 py-2 active:bg-black/5"
            style={
              index > 0
                ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' }
                : null
            }
          >
            <Image
              source={option.icon}
              style={{ width: 44, height: 44 }}
              resizeMode="contain"
            />
            <Text
              numberOfLines={2}
              className="min-w-0 flex-1 text-base font-semibold text-black/87"
            >
              {t(option.labelKey)}
            </Text>
            <Text className="text-lg text-black/40">{'\u2197'}</Text>
          </Pressable>
        ))}
      </View>
    </Dialog>
  );
}

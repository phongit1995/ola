import { useEffect, useState } from 'react';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { REPORT_TARGET_TYPE } from '@ola/shared/constants';
import { colorForName, megaphoneSenderName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { selectMegaphoneEnabled, useMegaphoneConfigStore } from '@ola/shared/stores/megaphone/megaphoneConfigStore';
import { useMegaphoneHistory } from '@ola/shared/stores/megaphone/useMegaphoneHistory';
import type { Megaphone } from '@ola/shared/types';
import { MEGAPHONE_IMAGE, MEGAPHONE_LINE } from '@components/megaphone/megaphoneAssets';
import { InsetListSeparator } from '@components/ui/InsetListSeparator';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useThemeColors } from '@hooks/useThemeColors';
import { ROOT_ROUTES } from '@navigation/routes';
import type { RootStackParamList } from '@navigation/types';
import { MegaphoneComposeDialog } from './components/MegaphoneComposeDialog';
import { MegaphoneHistoryItem } from './components/MegaphoneHistoryItem';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.Megaphone>;

const HERO_IMAGE_SIZE = 56;
const LIST_END_GAP = 16;

export function MegaphoneScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const userId = useAuthStore((s) => s.user?.id);
  const history = useMegaphoneHistory();
  const megaphoneEnabled = useMegaphoneConfigStore(selectMegaphoneEnabled);
  const [composeOpen, setComposeOpen] = useState(false);
  const [menuTarget, setMenuTarget] = useState<Megaphone | null>(null);
  const [reportTarget, setReportTarget] = useState<Megaphone | null>(null);
  const [nowMs, setNowMs] = useState(() => Date.now());

  useEffect(() => {
    void useMegaphoneConfigStore.getState().load();
  }, []);

  function openProfile(megaphone: Megaphone) {
    navigation.navigate(ROOT_ROUTES.ProfileView, {
      userId: megaphone.sender.username,
      color: colorForName(megaphoneSenderName(megaphone)),
    });
  }

  const menuOptions: ListOption[] =
    menuTarget == null
      ? []
      : [
          {
            key: 'profile',
            label: t('megaphone.viewProfile'),
            onSelect: () => openProfile(menuTarget),
          },
          {
            key: 'report',
            label: t('megaphone.report'),
            danger: true,
            onSelect: () => setReportTarget(menuTarget),
          },
        ];

  const header = (
    <>
      {megaphoneEnabled && (
        <View
          className="m-3 flex-row items-center gap-3 rounded-xl bg-ola-megaphone-soft p-3"
          style={{ borderWidth: 1, borderColor: MEGAPHONE_LINE }}
        >
          <Image
            source={MEGAPHONE_IMAGE}
            style={{ width: HERO_IMAGE_SIZE, height: HERO_IMAGE_SIZE }}
            resizeMode="contain"
          />
          <Text className="min-w-0 flex-1 text-base font-semibold text-ola-ink">{t('megaphone.composeTitle')}</Text>
          <Pressable
            onPress={() => setComposeOpen(true)}
            className="rounded-full bg-ola-warning px-4 py-2 active:opacity-80"
          >
            <Text className="text-sm font-semibold text-white">{t('megaphone.compose')}</Text>
          </Pressable>
        </View>
      )}
      <Text className="px-4 pt-1 pb-2 text-sm font-semibold text-ola-ink-soft">{t('megaphone.history')}</Text>
    </>
  );

  const empty = (
    <View className="items-center py-12">
      {history.loading || !history.done ? (
        <ActivityIndicator color={colors.primary} />
      ) : (
        <Text className="text-sm text-ola-ink-soft">{t('megaphone.historyEmpty')}</Text>
      )}
    </View>
  );

  const footer =
    !history.done && history.items.length > 0 ? (
      <View className="items-center py-3">
        {history.loading ? (
          <ActivityIndicator color={colors.primary} />
        ) : (
          <Pressable onPress={history.loadMore} className="active:opacity-70">
            <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
              {t('megaphone.loadMore')}
            </Text>
          </Pressable>
        )}
      </View>
    ) : null;

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('megaphone.title')} onBack={() => navigation.goBack()} />
      <FlashList
        data={history.items}
        keyExtractor={(item) => item.id}
        maintainVisibleContentPosition={{ disabled: true }}
        renderItem={({ item }) => (
          <MegaphoneHistoryItem
            megaphone={item}
            isMine={item.sender.id === userId}
            nowMs={nowMs}
            onOpenProfile={openProfile}
            onMore={setMenuTarget}
          />
        )}
        ItemSeparatorComponent={InsetListSeparator}
        ListHeaderComponent={header}
        ListEmptyComponent={empty}
        ListFooterComponent={footer}
        contentContainerStyle={{ paddingBottom: insets.bottom + LIST_END_GAP }}
      />

      {composeOpen && (
        <MegaphoneComposeDialog
          onClose={() => setComposeOpen(false)}
          onSent={(result) => {
            setNowMs(Date.now());
            history.prepend(result.megaphone);
          }}
          onTopUp={() => {
            setComposeOpen(false);
            navigation.navigate(ROOT_ROUTES.BuyKen);
          }}
        />
      )}
      <ListOptionDialog
        visible={menuTarget != null}
        title={menuTarget != null ? megaphoneSenderName(menuTarget) : ''}
        options={menuOptions}
        onClose={() => setMenuTarget(null)}
      />
      {reportTarget != null && (
        <ReportDialog
          target={{ type: REPORT_TARGET_TYPE.megaphone, id: reportTarget.id }}
          onClose={() => setReportTarget(null)}
        />
      )}
    </View>
  );
}

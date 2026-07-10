import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Animated, FlatList, Image, Modal, Pressable, Text, TextInput, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { activeVipTypeId, colorForName } from '@ola/shared/lib';
import { useMeLocalStore, type ViewedProfile } from '../../store/meLocalStore';
import { Avatar } from '../../components/Avatar';
import { VipBadge } from '../../components/VipBadge';
import { ConfirmDialog } from '../../components/ConfirmDialog';

const searchEmptyIcon = require('../../assets/icons/me/ic_action_search.png');

const WIDTH = 240;

function DrawerEmpty({ message }: { message: string }) {
  return (
    <View className="flex-1 items-center justify-center gap-3 px-6">
      <Image
        source={searchEmptyIcon}
        style={{ width: 40, height: 40, tintColor: 'rgba(0,0,0,0.12)' }}
        resizeMode="contain"
      />
      <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>
        {message}
      </Text>
    </View>
  );
}

interface MeRightDrawerProps {
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
}

function MeProfileRow({
  profile,
  onOpen,
}: {
  profile: ViewedProfile;
  onOpen: (profile: ViewedProfile) => void;
}) {
  const title = profile.fullName != null && profile.fullName !== '' ? profile.fullName : profile.username;
  const hasFullName = profile.fullName != null && profile.fullName !== '';
  return (
    <Pressable
      onPress={() => onOpen(profile)}
      className="h-12 flex-row items-center gap-2 px-2 active:bg-ola-primary-light"
    >
      <Avatar name={title} uri={profile.avatar ?? undefined} size={32} />
      <View className="min-w-0 flex-1">
        <View className="flex-row items-center gap-1">
          <VipBadge typeId={profile.vipTypeId} />
          <Text numberOfLines={1} className="min-w-0 shrink text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {title}
          </Text>
        </View>
        {hasFullName && (
          <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            @{profile.username}
          </Text>
        )}
      </View>
    </Pressable>
  );
}

export function MeRightDrawer({ onClose, onOpenProfile }: MeRightDrawerProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore((s) => s.push);
  const translateX = useRef(new Animated.Value(WIDTH)).current;
  const backdrop = useRef(new Animated.Value(0)).current;

  const viewedProfiles = useMeLocalStore((s) => s.viewedProfiles);
  const clearViewedProfiles = useMeLocalStore((s) => s.clearViewedProfiles);

  const [query, setQuery] = useState('');
  const [results, setResults] = useState<ViewedProfile[]>([]);
  const [loading, setLoading] = useState(false);
  const [confirmClear, setConfirmClear] = useState(false);

  useEffect(() => {
    Animated.parallel([
      Animated.timing(translateX, { toValue: 0, duration: 200, useNativeDriver: true }),
      Animated.timing(backdrop, { toValue: 1, duration: 200, useNativeDriver: true }),
    ]).start();
  }, [translateX, backdrop]);

  useEffect(() => {
    const keyword = query.trim();
    const timer = setTimeout(() => {
      if (keyword === '') {
        setResults([]);
        setLoading(false);
        return;
      }
      setLoading(true);
      UserService.search(keyword, 30)
        .then((result) =>
          setResults(
            result.users.map((user) => ({
              id: user.id,
              username: user.username,
              fullName: user.fullName,
              avatar: user.avatar,
              vipTypeId: activeVipTypeId(user.vipUsed, user.vipEndTime),
            }))
          )
        )
        .catch(() => push('error', t('me.searchError')))
        .finally(() => setLoading(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, push, t]);

  const searching = query.trim() !== '';

  function openProfile(profile: ViewedProfile) {
    onOpenProfile(profile.username, colorForName(profile.username));
    onClose();
  }

  return (
    <Modal transparent animationType="none" onRequestClose={onClose}>
      <Animated.View style={{ flex: 1, opacity: backdrop }} className="bg-black/30">
        <Pressable className="flex-1" onPress={onClose} />
      </Animated.View>
      <Animated.View
        className="absolute inset-y-0 right-0 bg-white"
        style={{ width: WIDTH, transform: [{ translateX }] }}
      >
        <View
          style={{ paddingTop: insets.top, borderBottomWidth: 1, borderBottomColor: '#b2b2b2' }}
          className="bg-[#d5d5d5] px-4 py-3"
        >
          <View
            className="h-10 flex-row items-center gap-1 bg-white px-1"
            style={{ borderWidth: 1, borderColor: '#b2b2b2', borderRadius: 5 }}
          >
            <Image
              source={searchEmptyIcon}
              style={{ width: 16, height: 16, tintColor: 'rgba(0,0,0,0.38)' }}
              resizeMode="contain"
            />
            <TextInput
              className="flex-1 text-base"
              style={{ color: 'rgba(0,0,0,0.87)' }}
              value={query}
              onChangeText={setQuery}
              placeholder={t('me.searchHint')}
              placeholderTextColor="rgba(0,0,0,0.26)"
              autoFocus
            />
          </View>
        </View>

        {!searching && viewedProfiles.length > 0 && (
          <View className="flex-row items-center justify-between bg-white px-4 py-2">
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('me.recentlyViewed')}
            </Text>
            <Pressable onPress={() => setConfirmClear(true)}>
              <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('me.clearHistory')}
              </Text>
            </Pressable>
          </View>
        )}

        <View className="flex-1" style={{ paddingBottom: insets.bottom }}>
          {searching ? (
            loading ? (
              <ActivityIndicator className="py-6" color="#7cb342" />
            ) : results.length === 0 ? (
              <DrawerEmpty message={t('me.searchEmpty')} />
            ) : (
              <FlatList
                data={results}
                keyExtractor={(item) => item.id}
                keyboardShouldPersistTaps="handled"
                renderItem={({ item }) => <MeProfileRow profile={item} onOpen={openProfile} />}
              />
            )
          ) : viewedProfiles.length === 0 ? (
            <DrawerEmpty message={t('me.searchHistoryEmpty')} />
          ) : (
            <FlatList
              data={viewedProfiles}
              keyExtractor={(item) => item.id}
              keyboardShouldPersistTaps="handled"
              renderItem={({ item }) => <MeProfileRow profile={item} onOpen={openProfile} />}
            />
          )}
        </View>
      </Animated.View>

      <ConfirmDialog
        visible={confirmClear}
        danger
        title={t('me.clearHistoryTitle')}
        message={t('me.clearHistoryConfirm')}
        confirmLabel={t('me.clearHistory')}
        cancelLabel={t('common.cancel')}
        onConfirm={() => {
          clearViewedProfiles();
          setConfirmClear(false);
        }}
        onCancel={() => setConfirmClear(false)}
      />
    </Modal>
  );
}

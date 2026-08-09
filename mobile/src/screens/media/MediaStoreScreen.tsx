import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  ScrollView,
  Text,
  View,
  type NativeScrollEvent,
  type NativeSyntheticEvent,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { MeService } from '@ola/shared/services';
import type { MePhoto } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { CachedImage } from '@components/ui/CachedImage';
import { useThemeColors } from '@hooks/useThemeColors';
import { PHOTOS_PAGE_SIZE } from './constants';
const MUTED = 'rgba(0,0,0,0.45)';

const mediaIcon = require('@assets/icons/apps/media.png');

interface PhotoGroup {
  key: string;
  label: string;
  items: { url: string; index: number }[];
}

function monthKey(iso: string): string {
  const date = new Date(iso);
  return `${date.getFullYear()}-${date.getMonth()}`;
}

function monthLabel(iso: string, language: string): string {
  const date = new Date(iso);
  const text = new Intl.DateTimeFormat(language, { month: 'long', year: 'numeric' }).format(date);
  return text.charAt(0).toUpperCase() + text.slice(1);
}

function groupByMonth(photos: MePhoto[], language: string): PhotoGroup[] {
  const groups: PhotoGroup[] = [];
  photos.forEach((photo, index) => {
    const key = monthKey(photo.createdAt);
    let last = groups[groups.length - 1];
    if (last == null || last.key !== key) {
      last = { key, label: monthLabel(photo.createdAt, language), items: [] };
      groups.push(last);
    }
    last.items.push({ url: photo.url, index });
  });
  return groups;
}

function PhotoSkeleton() {
  return (
    <View className="flex-row flex-wrap p-2" style={{ margin: -2 }}>
      {Array.from({ length: 12 }).map((_, index) => (
        <View key={index} style={{ width: '33.33%', padding: 2 }}>
          <View className="rounded-sm" style={{ aspectRatio: 1, backgroundColor: 'rgba(0,0,0,0.1)' }} />
        </View>
      ))}
    </View>
  );
}

function PhotoTile({ url, label, onOpen }: { url: string; label?: string; onOpen: () => void }) {
  return (
    <Pressable
      onPress={onOpen}
      className="overflow-hidden rounded-sm active:opacity-90"
      style={{ aspectRatio: 1, backgroundColor: 'rgba(0,0,0,0.05)' }}
    >
      <CachedImage uri={url} style={{ width: '100%', height: '100%' }} resizeMode="cover" />
      {label != null && (
        <View
          className="absolute inset-x-0 bottom-0 px-1.5 py-1"
          style={{ backgroundColor: 'rgba(0,0,0,0.45)' }}
        >
          <Text numberOfLines={1} className="text-xs font-medium text-white">
            {label}
          </Text>
        </View>
      )}
    </Pressable>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.MediaStore>;

export function MediaStoreScreen({ navigation }: Props) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const [photos, setPhotos] = useState<MePhoto[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(false);
  const [hasMore, setHasMore] = useState(false);
  const offsetRef = useRef(0);
  const loadingRef = useRef(false);

  const loadPage = useCallback(async (reset: boolean) => {
    if (loadingRef.current) return;
    loadingRef.current = true;
    const offset = reset ? 0 : offsetRef.current;
    try {
      const result = await MeService.photos({ limit: PHOTOS_PAGE_SIZE, offset });
      setPhotos((prev) => (reset ? result.items : [...prev, ...result.items]));
      setTotal(result.total);
      const loaded = offset + result.items.length;
      offsetRef.current = loaded;
      setHasMore(loaded < result.total);
      setError(false);
    } catch {
      setError(true);
      setHasMore(false);
    } finally {
      loadingRef.current = false;
      setLoading(false);
      setLoadingMore(false);
    }
  }, []);

  useEffect(() => {
    void loadPage(true);
  }, [loadPage]);

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    if (!hasMore || loadingRef.current) return;
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    if (contentSize.height - contentOffset.y - layoutMeasurement.height > 300) return;
    setLoadingMore(true);
    void loadPage(false);
  }

  const allUrls = useMemo(() => photos.map((photo) => photo.url), [photos]);
  const groups = useMemo(() => groupByMonth(photos, i18n.language), [photos, i18n.language]);
  const hasPhotos = photos.length > 0;

  return (
    <View className="flex-1" style={{ backgroundColor: '#fafafa' }}>
      <ScreenHeader
        title={t('media.title')}
        subtitle={hasPhotos ? t('media.count', { count: total }) : undefined}
        onBack={() => navigation.goBack()}
      />

      {loading ? (
        <PhotoSkeleton />
      ) : error && !hasPhotos ? (
        <View className="flex-1 items-center justify-center px-8">
          <Text className="text-center text-sm" style={{ color: '#e34545' }}>
            {t('common.error')}
          </Text>
        </View>
      ) : !hasPhotos ? (
        <View className="flex-1 items-center justify-center gap-3 px-8">
          <Image
            source={mediaIcon}
            style={{ width: 56, height: 56, opacity: 0.25 }}
            resizeMode="contain"
          />
          <Text className="text-center text-sm" style={{ color: MUTED }}>
            {t('media.empty')}
          </Text>
        </View>
      ) : (
        <ScrollView
          className="flex-1"
          onScroll={handleScroll}
          scrollEventThrottle={100}
          contentContainerClassName="p-2"
          contentContainerStyle={{ paddingBottom: Math.max(insets.bottom, 8) }}
        >
          {groups.map((group, groupIndex) => (
            <View
              key={group.key}
              className="flex-row flex-wrap"
              style={{ margin: -2, marginTop: groupIndex > 0 ? 10 : -2 }}
            >
              {group.items.map((item, position) => (
                <View key={`${item.url}-${item.index}`} style={{ width: '33.33%', padding: 2 }}>
                  <PhotoTile
                    url={item.url}
                    label={position === 0 ? group.label : undefined}
                    onOpen={() => openViewer(allUrls, item.index)}
                  />
                </View>
              ))}
            </View>
          ))}
          {loadingMore && <ActivityIndicator className="py-2" color={colors.primary} />}
        </ScrollView>
      )}
    </View>
  );
}

import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useNavigation, type CompositeNavigationProp } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { STORY_STATUS_FILTER } from '@ola/shared/constants';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { Story, StoryProgress, StoryStatusFilter } from '@ola/shared/types';
import type { RootStackParamList, StoryStackParamList } from '@navigation/types';
import { ROOT_ROUTES, STORY_ROUTES } from '@navigation/routes';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { useThemeColors } from '@hooks/useThemeColors';
import {
  ROW_SEPARATOR,
  SEARCH_DEBOUNCE_MS,
  SORT_OPTIONS,
  STATUS_FILTER_OPTIONS,
} from './constants';
import {
  ContinueCard,
  StorySectionTitle,
  StoryShelf,
  TopStoryCard,
} from './components/StoryCards';
import { StoryIcon } from './components/StoryIcons';
import { StoryRow } from './components/StoryRow';
import { StoryStateMessage } from './components/StoryStateMessage';
import { useStoryTextSize } from './typography';

const CHIP_BORDER = '#d5d5d5';
const MUTED = 'rgba(0,0,0,0.54)';
const FILTER_ICON_MUTED = 'rgba(0,0,0,0.45)';
const SMALL_ICON_SIZE = 16;

type StoryListNavigation = CompositeNavigationProp<
  NativeStackNavigationProp<StoryStackParamList, typeof STORY_ROUTES.StoryList>,
  NativeStackNavigationProp<RootStackParamList>
>;

interface ChipProps {
  active: boolean;
  onPress: () => void;
  children: string;
}

function Chip({ active, onPress, children }: ChipProps) {
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <Pressable
      onPress={onPress}
      className="rounded-full px-3 py-1 active:opacity-80"
      style={{
        borderWidth: 1,
        borderColor: active ? colors.primary : CHIP_BORDER,
        backgroundColor: active ? colors.primary : '#ffffff',
      }}
    >
      <Text style={[textSize(13, 18), { color: active ? colors.onPrimary : 'rgba(0,0,0,0.7)' }]}>
        {children}
      </Text>
    </Pressable>
  );
}

interface StatusFilterProps {
  value: StoryStatusFilter;
  onPress: () => void;
}

function StatusFilter({ value, onPress }: StatusFilterProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const filtered = value !== STORY_STATUS_FILTER.all;
  const labelKey =
    STATUS_FILTER_OPTIONS.find((option) => option.value === value)?.labelKey ??
    'story.statusAll';
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t('story.statusFilter')}
      onPress={onPress}
      className="flex-row items-center gap-1 rounded-full py-1 pl-2.5 pr-1.5 active:opacity-80"
      style={{ borderWidth: 1, borderColor: filtered ? colors.primary : CHIP_BORDER }}
    >
      <StoryIcon
        name="filterAlt"
        size={SMALL_ICON_SIZE}
        color={filtered ? colors.primary : FILTER_ICON_MUTED}
      />
      <Text
        style={[textSize(13, 18), { color: filtered ? colors.primaryInk : 'rgba(0,0,0,0.7)' }]}
      >
        {t(labelKey)}
      </Text>
      <StoryIcon name="arrowDropDown" size={SMALL_ICON_SIZE} color={FILTER_ICON_MUTED} />
    </Pressable>
  );
}

function Separator() {
  return <View style={{ height: 1, backgroundColor: ROW_SEPARATOR }} />;
}

export function StoryListScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const navigation = useNavigation<StoryListNavigation>();
  const genres = useStoryStore((state) => state.genres);
  const topViewed = useStoryStore((state) => state.topViewed);
  const list = useStoryStore((state) => state.list);
  const loadHome = useStoryStore((state) => state.loadHome);
  const setFilter = useStoryStore((state) => state.setFilter);
  const loadMore = useStoryStore((state) => state.loadMore);
  const progress = useStoryPrefsStore((state) => state.progress);
  const [query, setQuery] = useState(list.filter.q);
  const [statusOpen, setStatusOpen] = useState(false);
  const { filter } = list;
  const searching = filter.q !== '';
  const firstLoad = list.status === 'loading' && list.items.length === 0;

  const recent = useMemo(
    () => Object.values(progress).sort((a, b) => b.updatedAt - a.updatedAt),
    [progress]
  );

  useEffect(() => {
    if (useStoryStore.getState().list.status === 'idle') void loadHome();
  }, [loadHome]);

  useEffect(() => {
    const trimmed = query.trim();
    if (trimmed === filter.q) return;
    const timer = setTimeout(() => void setFilter({ q: trimmed }), SEARCH_DEBOUNCE_MS);
    return () => clearTimeout(timer);
  }, [query, filter.q, setFilter]);

  const openStory = useCallback(
    (storyId: string) => navigation.navigate(STORY_ROUTES.StoryDetail, { storyId }),
    [navigation]
  );

  const continueReading = useCallback(
    (item: StoryProgress) =>
      navigation.navigate(ROOT_ROUTES.StoryReader, {
        storyId: item.storyId,
        position: item.position,
      }),
    [navigation]
  );

  function renderEmpty() {
    if (firstLoad) {
      return (
        <View className="items-center bg-white py-10">
          <ActivityIndicator color={colors.primary} />
        </View>
      );
    }
    if (list.status === 'error') {
      return (
        <View className="bg-white">
          <StoryStateMessage
            kind="error"
            text={t('story.loadError')}
            onRetry={() => void setFilter({})}
          />
        </View>
      );
    }
    return (
      <View className="bg-white">
        <StoryStateMessage
          kind="empty"
          text={t(searching ? 'story.searchEmpty' : 'story.empty')}
        />
      </View>
    );
  }

  function renderFooter() {
    if (!list.hasMore || list.items.length === 0) return null;
    const loading = list.status === 'loading';
    return (
      <View className="items-center bg-white py-4">
        <Pressable
          disabled={loading}
          onPress={() => void loadMore()}
          className="h-9 items-center justify-center rounded-full px-4"
          style={{ minWidth: 144, borderWidth: 1, borderColor: colors.primary, opacity: loading ? 0.6 : 1 }}
        >
          {loading ? (
            <ActivityIndicator size="small" color={colors.primary} />
          ) : (
            <Text style={[textSize(14, 20), { color: colors.primaryInk }]}>
              {t('story.loadMore')}
            </Text>
          )}
        </Pressable>
      </View>
    );
  }

  const header = (
    <View>
      {!searching && recent.length > 0 && (
        <StoryShelf title={t('story.continueReading')} icon="book">
          {recent.map((item) => (
            <ContinueCard key={item.storyId} progress={item} onOpen={continueReading} />
          ))}
        </StoryShelf>
      )}
      {!searching && topViewed.length > 0 && (
        <View className={recent.length > 0 ? 'mt-2' : ''}>
          <StoryShelf title={t('story.topViewed')} icon="emojiEvents">
            {topViewed.map((story, index) => (
              <TopStoryCard key={story.id} story={story} rank={index + 1} onOpen={openStory} />
            ))}
          </StoryShelf>
        </View>
      )}
      <View className={`bg-white ${searching ? '' : 'mt-2'}`}>
        <View className="flex-row items-center gap-2 px-3 pt-3">
          <View className="min-w-0 flex-1">
            <StorySectionTitle icon={searching ? 'search' : 'libraryBooks'}>
              {t(searching ? 'story.searchResults' : 'story.allStories')}
            </StorySectionTitle>
          </View>
          {list.status === 'loading' && list.items.length > 0 && (
            <ActivityIndicator size="small" color={colors.primary} />
          )}
          <StatusFilter value={filter.status} onPress={() => setStatusOpen(true)} />
        </View>
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          keyboardShouldPersistTaps="handled"
          className="mt-2"
          contentContainerStyle={{ paddingHorizontal: 12, gap: 8 }}
        >
          <Chip active={filter.genre === ''} onPress={() => void setFilter({ genre: '' })}>
            {t('story.allGenres')}
          </Chip>
          {genres.map((genre) => (
            <Chip
              key={genre.name}
              active={filter.genre === genre.name}
              onPress={() => void setFilter({ genre: genre.name })}
            >
              {genre.name}
            </Chip>
          ))}
        </ScrollView>
        <View
          className="mt-2 flex-row gap-5 px-3"
          style={{ borderBottomWidth: 1, borderBottomColor: ROW_SEPARATOR }}
        >
          {SORT_OPTIONS.map((option) => {
            const active = filter.sort === option.value;
            const color = active ? colors.primaryInk : MUTED;
            return (
              <Pressable
                key={option.value}
                accessibilityRole="tab"
                accessibilityState={{ selected: active }}
                onPress={() => void setFilter({ sort: option.value })}
                className="flex-row items-center gap-1 py-2"
                style={{
                  marginBottom: -1,
                  borderBottomWidth: 2,
                  borderBottomColor: active ? colors.primary : 'transparent',
                }}
              >
                <StoryIcon name={option.icon} size={SMALL_ICON_SIZE} color={color} />
                <Text
                  className={active ? 'font-semibold' : ''}
                  style={[textSize(13, 18), { color }]}
                >
                  {t(option.labelKey)}
                </Text>
              </Pressable>
            );
          })}
        </View>
      </View>
    </View>
  );

  return (
    <View className="flex-1 bg-ola-surface">
      <View className="bg-ola-primary px-2" style={{ paddingTop: insets.top }}>
        <View className="h-12 justify-center">
          <View
            className="h-9 flex-row items-center gap-2 rounded-full px-3"
            style={{ backgroundColor: 'rgba(255,255,255,0.2)' }}
          >
            <StoryIcon name="search" size={20} color="rgba(255,255,255,0.8)" />
            <TextInput
              value={query}
              onChangeText={setQuery}
              placeholder={t('story.searchPlaceholder')}
              placeholderTextColor="rgba(255,255,255,0.7)"
              returnKeyType="search"
              autoCorrect={false}
              className="min-w-0 flex-1 py-0"
              style={{ fontSize: textSize(16).fontSize, color: '#ffffff' }}
            />
            {query !== '' && (
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('common.clear')}
                onPress={() => setQuery('')}
                hitSlop={6}
                className="h-6 w-6 items-center justify-center rounded-full"
              >
                <Text style={[textSize(18, 20), { color: 'rgba(255,255,255,0.8)' }]}>
                  ×
                </Text>
              </Pressable>
            )}
          </View>
        </View>
      </View>
      <FlashList<Story>
        data={list.items}
        keyExtractor={(story) => story.id}
        renderItem={({ item }) => <StoryRow story={item} onOpen={openStory} />}
        ItemSeparatorComponent={Separator}
        ListHeaderComponent={header}
        ListEmptyComponent={renderEmpty()}
        ListFooterComponent={renderFooter()}
        keyboardShouldPersistTaps="handled"
        keyboardDismissMode="on-drag"
        maintainVisibleContentPosition={{ disabled: true }}
      />
      <ListOptionDialog
        visible={statusOpen}
        title={t('story.statusFilter')}
        options={STATUS_FILTER_OPTIONS.map((option) => ({
          key: option.value,
          label: t(option.labelKey),
          onSelect: () => void setFilter({ status: option.value }),
        }))}
        onClose={() => setStatusOpen(false)}
      />
    </View>
  );
}

import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { appendReelViewers, colorForName, toast } from '@ola/shared/lib';
import { ReelService } from '@ola/shared/services';
import type { ReelViewer } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { UserListDialog } from '@components/ui/UserListDialog';
import { useThemeColors } from '@hooks/useThemeColors';

const LIST_MAX_HEIGHT = 360;

interface ViewerList {
  reelId: string;
  items: ReelViewer[];
  total: number;
  nextOffset: number | null;
}

interface ReelViewersDialogProps {
  visible: boolean;
  reelId: string;
  onClose: () => void;
}

export function ReelViewersDialog({ visible, reelId, onClose }: ReelViewersDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const [list, setList] = useState<ViewerList | null>(null);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    if (!visible) return;
    let cancelled = false;
    ReelService.visibleViewers(reelId)
      .then((page) => {
        if (!cancelled) {
          setList({ reelId, items: page.items, total: page.total, nextOffset: page.nextOffset });
        }
      })
      .catch(() => {
        if (!cancelled) setList({ reelId, items: [], total: 0, nextOffset: null });
      });
    return () => {
      cancelled = true;
    };
  }, [visible, reelId]);

  const current = list?.reelId === reelId ? list : null;
  const items = current?.items ?? [];
  const nextOffset = current?.nextOffset ?? null;

  async function loadMore() {
    if (nextOffset == null || loadingMore) return;
    setLoadingMore(true);
    try {
      const page = await ReelService.visibleViewers(reelId, nextOffset);
      setList((value) =>
        value?.reelId === reelId
          ? {
              reelId,
              items: appendReelViewers(value.items, page.items),
              total: page.total,
              nextOffset: page.nextOffset,
            }
          : value
      );
    } catch {
      toast.error(t('reel.viewersFailed'));
    } finally {
      setLoadingMore(false);
    }
  }

  return (
    <UserListDialog
      visible={visible}
      title={current ? t('reel.viewerCount', { count: current.total }) : t('reel.viewers')}
      onClose={onClose}
      loading={current == null}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('reel.viewersEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={LIST_MAX_HEIGHT}
    >
      {[
        ...items.map(({ user }) => (
          <View key={user.id} className="flex-row items-center gap-3 py-2">
            <Avatar
              name={user.username}
              uri={user.avatar ?? undefined}
              color={colorForName(user.username)}
              size={40}
            />
            <View className="min-w-0 flex-1">
              <Text numberOfLines={1} className="text-base text-ola-ink">
                {user.username}
              </Text>
              {user.fullName ? (
                <Text numberOfLines={1} className="text-sm text-ola-ink-soft">
                  {user.fullName}
                </Text>
              ) : null}
            </View>
          </View>
        )),
        ...(nextOffset != null
          ? [
              <Pressable
                key="more"
                accessibilityRole="button"
                disabled={loadingMore}
                onPress={() => void loadMore()}
                className="items-center py-2.5 active:bg-black/5"
                style={{ opacity: loadingMore ? 0.5 : 1 }}
              >
                <Text className="text-base font-semibold" style={{ color: colors.primary }}>
                  {t('reel.viewersMore')}
                </Text>
              </Pressable>,
            ]
          : []),
      ]}
    </UserListDialog>
  );
}

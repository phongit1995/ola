import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { FloatingBubble } from '@components/ui/FloatingBubble';
import { useThemeColors } from '@hooks/useThemeColors';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { WordChainImage } from './WordChainIcons';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const WORD_CHAIN_BUBBLE_STORAGE_KEY = 'ola.word-chain.bubble-position';
const WORD_CHAIN_BUBBLE_BOTTOM_GAP = 152;
const ROOM_ICON_SIZE = 44;
const SYLLABLE_OFFSET = 14;
const SYLLABLE_OVERHANG = 8;
const SYLLABLE_MAX_WIDTH = 64;

export function WordChainBubble({ onRestore }: { onRestore: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const opened = useWordChainStore((store) => store.opened);
  const minimized = useWordChainStore((store) => store.minimized);
  const notify = useWordChainStore((store) => store.notify);
  const syllable = useWordChainStore((store) => store.state?.requiredSyllable);
  const restore = useWordChainStore((store) => store.restore);
  const close = useWordChainStore((store) => store.close);
  const arcadeCovers = useArcadeOverlayStore(
    (store) => store.active != null && !store.minimized
  );

  if (!opened || !minimized || arcadeCovers) return null;

  return (
    <FloatingBubble
      storageKey={WORD_CHAIN_BUBBLE_STORAGE_KEY}
      bottomGap={WORD_CHAIN_BUBBLE_BOTTOM_GAP}
      label={
        notify
          ? `${t('wordChain.restore')}. ${t('wordChain.hasNotification')}`
          : t('wordChain.restore')
      }
      hint={t('wordChain.restore')}
      notify={notify}
      overhangBottom={SYLLABLE_OVERHANG}
      onRestore={() => {
        restore();
        onRestore();
      }}
      onClose={close}
    >
      <View>
        <WordChainImage source={WORD_CHAIN_ICONS.room} size={ROOM_ICON_SIZE} />
        {syllable != null && syllable !== '' && (
          <View
            pointerEvents="none"
            className="absolute items-center"
            style={{
              bottom: -SYLLABLE_OFFSET,
              left: (ROOM_ICON_SIZE - SYLLABLE_MAX_WIDTH) / 2,
              width: SYLLABLE_MAX_WIDTH,
            }}
          >
            <Text
              numberOfLines={1}
              className="rounded-full px-1.5 font-semibold"
              style={{
                maxWidth: SYLLABLE_MAX_WIDTH,
                overflow: 'hidden',
                fontSize: 11,
                lineHeight: 16,
                color: colors.onPrimary,
                backgroundColor: colors.primary,
              }}
            >
              {syllable}
            </Text>
          </View>
        )}
      </View>
    </FloatingBubble>
  );
}

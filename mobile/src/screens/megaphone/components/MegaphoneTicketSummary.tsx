import { Image, Pressable, Text } from 'react-native';
import { useTranslation } from 'react-i18next';
import {
  selectMegaphoneTicketCount,
  useMegaphoneTicketStore,
} from '@ola/shared/stores/megaphone/megaphoneTicketStore';
import { MEGAPHONE_TICKET_IMAGE } from '@components/megaphone/megaphoneAssets';

const ICON_SIZE = 24;

interface MegaphoneTicketSummaryProps {
  onOpen: () => void;
}

export function MegaphoneTicketSummary({ onOpen }: MegaphoneTicketSummaryProps) {
  const { t } = useTranslation();
  const count = useMegaphoneTicketStore(selectMegaphoneTicketCount);
  if (count === 0) return null;
  return (
    <Pressable onPress={onOpen} hitSlop={6} className="mt-1 flex-row items-center gap-1 active:opacity-70">
      <Image source={MEGAPHONE_TICKET_IMAGE} style={{ width: ICON_SIZE, height: ICON_SIZE }} resizeMode="contain" />
      <Text className="min-w-0 flex-shrink text-sm text-ola-megaphone-ink" style={{ fontVariant: ['tabular-nums'] }}>
        {t('megaphone.ticket.summary', { count })}
        <Text className="text-black/38"> ›</Text>
      </Text>
    </Pressable>
  );
}

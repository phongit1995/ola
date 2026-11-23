import { Image, ScrollView, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { megaphoneTicketSourceText } from '@ola/shared/lib';
import { useMegaphoneTicketStore } from '@ola/shared/stores/megaphone/megaphoneTicketStore';
import { MEGAPHONE_TICKET_IMAGE } from '@components/megaphone/megaphoneAssets';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ItemCountdown } from '@components/ui/ItemGrantMarks';

const ROW_ICON_SIZE = 24;
const LIST_MAX_HEIGHT = 320;

interface MegaphoneTicketListDialogProps {
  onClose: () => void;
}

export function MegaphoneTicketListDialog({ onClose }: MegaphoneTicketListDialogProps) {
  const { t } = useTranslation();
  const tickets = useMegaphoneTicketStore((s) => s.tickets);
  return (
    <Dialog
      visible
      onClose={onClose}
      title={t('megaphone.ticket.listTitle')}
      icon={MEGAPHONE_TICKET_IMAGE}
      showClose
      footer={
        <DialogButton variant="green" onPress={onClose}>
          {t('dialog.close')}
        </DialogButton>
      }
    >
      <View className="gap-2 p-4">
        <Text className="text-sm text-ola-ink-soft">{t('megaphone.ticket.listHint')}</Text>
        {tickets.length === 0 ? (
          <Text className="py-6 text-center text-sm text-ola-ink-soft">{t('megaphone.ticket.empty')}</Text>
        ) : (
          <ScrollView className="rounded-lg bg-ola-surface" style={{ maxHeight: LIST_MAX_HEIGHT }}>
            {tickets.map((ticket, index) => (
              <View
                key={ticket.id}
                className="flex-row items-center gap-3 px-3 py-2.5"
                style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.06)' } : undefined}
              >
                <Text className="w-5 text-center text-xs font-semibold text-black/38">{index + 1}</Text>
                <Image source={MEGAPHONE_TICKET_IMAGE} style={{ width: ROW_ICON_SIZE, height: ROW_ICON_SIZE }} resizeMode="contain" />
                <Text numberOfLines={1} className="min-w-0 flex-1 text-sm text-ola-ink">
                  {megaphoneTicketSourceText(t, ticket.source)}
                </Text>
                {ticket.expiresAt != null ? (
                  <ItemCountdown expiresAt={ticket.expiresAt} style={{ fontSize: 14 }} />
                ) : (
                  <Text className="text-sm text-ola-ink-soft">{t('megaphone.ticket.noExpiry')}</Text>
                )}
              </View>
            ))}
          </ScrollView>
        )}
      </View>
    </Dialog>
  );
}

import type { ReactNode } from 'react';
import { UiSheet } from './Ui';

export function BottomSheet({ title, onClose, children, footer, tall, accent }: { title: string; onClose: () => void; children: ReactNode; footer?: ReactNode; tall?: boolean; accent?: string }) {
  return (
    <UiSheet title={title} onClose={onClose} footer={footer} tall={tall} accent={accent}>
      {children}
    </UiSheet>
  );
}

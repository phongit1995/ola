import { VipBadge } from '@components';
import megaphoneImage from '@/assets/images/member-megaphone.webp';

interface MegaphonePreviewProps {
  username: string;
  vipTypeId: number | null;
  content: string;
}

export function MegaphonePreview({ username, vipTypeId, content }: MegaphonePreviewProps) {
  return (
    <div className="flex items-start gap-2 rounded-lg border border-ola-megaphone-line bg-ola-megaphone-soft px-2.5 py-2">
      <img src={megaphoneImage} alt="" className="h-6 w-6 shrink-0 object-contain" />
      <VipBadge typeId={vipTypeId} className="h-6 w-6" />
      <p className="min-w-0 flex-1 text-sm break-words">
        <b className="font-semibold text-ola-megaphone-name">@{username}: </b>
        <span className="text-black/87">{content}</span>
      </p>
    </div>
  );
}

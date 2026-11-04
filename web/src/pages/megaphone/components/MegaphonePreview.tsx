import { colorForName } from '@lib';
import { Avatar } from '@components';
import megaphoneImage from '@/assets/images/announcement-megaphone.png';

interface MegaphonePreviewProps {
  name: string;
  avatar?: string;
  content: string;
}

export function MegaphonePreview({ name, avatar, content }: MegaphonePreviewProps) {
  return (
    <div className="flex items-start gap-2 rounded-lg border border-ola-megaphone-line bg-ola-megaphone-soft px-2.5 py-2">
      <img src={megaphoneImage} alt="" className="h-6 w-6 shrink-0 object-contain" />
      <Avatar name={name} src={avatar} color={colorForName(name)} size={24} />
      <p className="min-w-0 flex-1 text-sm break-words">
        <b className="font-semibold text-ola-megaphone-ink">{name}: </b>
        <span className="text-black/87">{content}</span>
      </p>
    </div>
  );
}

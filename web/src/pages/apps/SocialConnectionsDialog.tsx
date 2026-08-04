import type { ParseKeys } from 'i18next';
import { useTranslation } from 'react-i18next';
import { Dialog } from '@components';
import fanpageIcon from '@/assets/icons/social/fanpage.png';
import groupIcon from '@/assets/icons/social/group.png';
import socialMenuIcon from '@/assets/icons/social/social-menu-light.png';
import tiktokIcon from '@/assets/icons/social/tiktok.png';

interface SocialOption {
  key: 'fanpage' | 'group' | 'tiktok';
  icon: string;
  labelKey: ParseKeys;
  url: string;
}

const SOCIAL_OPTIONS: SocialOption[] = [
  {
    key: 'fanpage',
    icon: fanpageIcon,
    labelKey: 'social.fanpageTitle',
    url: 'https://www.facebook.com/ola2vn',
  },
  {
    key: 'group',
    icon: groupIcon,
    labelKey: 'social.groupTitle',
    url: 'https://www.facebook.com/groups/nghienola',
  },
  {
    key: 'tiktok',
    icon: tiktokIcon,
    labelKey: 'social.tiktokTitle',
    url: 'https://www.tiktok.com/@olachat.net',
  },
];

function ExternalLinkIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-5 w-5"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
    >
      <path d="M14 5h5v5M10 14 19 5M19 13v6H5V5h6" />
    </svg>
  );
}

export function SocialConnectionsDialog({
  open,
  onClose,
}: {
  open: boolean;
  onClose: () => void;
}) {
  const { t } = useTranslation();

  function openOption(option: SocialOption) {
    window.open(option.url, '_blank', 'noopener,noreferrer');
    onClose();
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('social.title')}
      showClose
      icon={<img src={socialMenuIcon} alt="" className="h-8 w-8" />}
    >
      <div className="-m-2">
        {SOCIAL_OPTIONS.map((option) => (
          <button
            key={option.key}
            type="button"
            onClick={() => openOption(option)}
            className="flex min-h-16 w-full items-center gap-3 border-b border-black/8 px-4 py-2 text-left last:border-b-0 hover:bg-gray-50 active:bg-gray-100"
          >
            <img
              src={option.icon}
              alt=""
              className="h-11 w-11 shrink-0 object-contain"
            />
            <span className="min-w-0 flex-1 truncate text-base font-semibold text-black/85">
              {t(option.labelKey)}
            </span>
            <span className="shrink-0 text-black/35">
              <ExternalLinkIcon />
            </span>
          </button>
        ))}
      </div>
    </Dialog>
  );
}

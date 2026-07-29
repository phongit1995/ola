import { type CSSProperties } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { portalRoot, REACTION_IMAGE, REACTION_ORDER } from '@lib';
import type { ReactionType } from '@app-types';

export interface MessageSheetAction {
  key: string;
  label: string;
  icon?: string;
  destructive?: boolean;
  onSelect: () => void;
}

interface MessageActionSheetProps {
  actions: MessageSheetAction[];
  onReact: (type: ReactionType) => void;
  onClose: () => void;
  anchor?: DOMRect | null;
  showReactions?: boolean;
}

const POPUP_GAP = 8;
const POPUP_MARGIN = 12;
const BAR_WIDTH = 244;
const BAR_HEIGHT = 48;
const MENU_WIDTH = 160;
const MENU_ITEM_HEIGHT = 38;
const MENU_PADDING = 8;
const MENU_GAP = 6;

function ReactionBar({
  onReact,
  onClose,
}: Pick<MessageActionSheetProps, 'onReact' | 'onClose'>) {
  return (
    <div className="flex items-center gap-0.5 rounded-full bg-white px-2 py-1.5 shadow-[0_8px_28px_rgba(0,0,0,0.18)]">
      {REACTION_ORDER.map((type) => (
        <button
          key={type}
          type="button"
          onClick={() => {
            onReact(type);
            onClose();
          }}
          className="flex h-9 w-9 items-center justify-center rounded-full transition-transform duration-150 hover:-translate-y-1 hover:scale-[1.3] active:scale-110"
        >
          <img
            src={REACTION_IMAGE[type]}
            alt={type}
            className="h-6 w-6 object-contain"
          />
        </button>
      ))}
    </div>
  );
}

function clamp(value: number, min: number, max: number): number {
  if (max < min) return min;
  return Math.min(Math.max(value, min), max);
}

function alignsRight(anchor: DOMRect): boolean {
  return anchor.left + anchor.width / 2 > window.innerWidth / 2;
}

function popupHeight(actionCount: number, withBar: boolean): number {
  const menu =
    actionCount > 0 ? MENU_PADDING + actionCount * MENU_ITEM_HEIGHT : 0;
  if (!withBar) return menu;
  if (menu === 0) return BAR_HEIGHT;
  return BAR_HEIGHT + MENU_GAP + menu;
}

function anchoredStyle(
  anchor: DOMRect,
  actionCount: number,
  withBar: boolean
): CSSProperties {
  const refWidth = Math.min(
    withBar ? BAR_WIDTH : MENU_WIDTH,
    window.innerWidth - POPUP_MARGIN * 2
  );

  const height = popupHeight(actionCount, withBar);
  const spaceBelow = window.innerHeight - anchor.bottom - POPUP_MARGIN;
  const placeBelow =
    spaceBelow >= height + POPUP_GAP || spaceBelow >= anchor.top - POPUP_MARGIN;
  const rawTop = placeBelow
    ? anchor.bottom + POPUP_GAP
    : anchor.top - POPUP_GAP - height;
  const top = clamp(
    rawTop,
    POPUP_MARGIN,
    window.innerHeight - POPUP_MARGIN - height
  );

  if (alignsRight(anchor)) {
    const right = clamp(
      window.innerWidth - anchor.right,
      POPUP_MARGIN,
      window.innerWidth - POPUP_MARGIN - refWidth
    );
    return { right, top };
  }
  const left = clamp(
    anchor.left,
    POPUP_MARGIN,
    window.innerWidth - POPUP_MARGIN - refWidth
  );
  return { left, top };
}

function ActionMenuButton({
  action,
  onClose,
}: {
  action: MessageSheetAction;
  onClose: () => void;
}) {
  return (
    <button
      type="button"
      onClick={() => {
        action.onSelect();
        onClose();
      }}
      className={`flex w-full items-center gap-2.5 px-3.5 py-2 text-left text-sm active:bg-black/5 ${
        action.destructive ? 'text-ola-error' : 'text-black/87'
      }`}
    >
      {action.icon != null && (
        <img src={action.icon} alt="" className="h-4 w-4 object-contain" />
      )}
      {action.label}
    </button>
  );
}

function AnchoredPopup({
  actions,
  onReact,
  onClose,
  anchor,
  showReactions = true,
}: MessageActionSheetProps & { anchor: DOMRect }) {
  const alignRight = alignsRight(anchor);

  return (
    <div className="fixed inset-0 z-[120]" onClick={onClose}>
      <div
        className={`animate-ola-menu-in absolute flex flex-col gap-1.5 ${
          alignRight ? 'items-end' : 'items-start'
        }`}
        style={anchoredStyle(anchor, actions.length, showReactions)}
        onClick={(event) => event.stopPropagation()}
      >
        {showReactions && <ReactionBar onReact={onReact} onClose={onClose} />}
        {actions.length > 0 && (
          <div className="min-w-40 overflow-hidden rounded-xl bg-white py-1 shadow-[0_8px_28px_rgba(0,0,0,0.18)]">
            {actions.map((action) => (
              <ActionMenuButton
                key={action.key}
                action={action}
                onClose={onClose}
              />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

function BottomSheet({
  actions,
  onReact,
  onClose,
  showReactions = true,
}: MessageActionSheetProps) {
  const { t } = useTranslation();

  return (
    <div
      className="fixed inset-0 z-[120] flex flex-col justify-end"
      onClick={onClose}
    >
      <div className="absolute inset-0 bg-black/40" />
      <div
        className="relative mx-auto w-full max-w-md rounded-t-2xl bg-white pb-[env(safe-area-inset-bottom)]"
        onClick={(event) => event.stopPropagation()}
      >
        {showReactions && (
          <div className="flex items-center justify-around px-2 py-3">
            <ReactionBar onReact={onReact} onClose={onClose} />
          </div>
        )}

        <div className={showReactions ? 'border-t border-black/8' : ''}>
          {actions.map((action) => (
            <button
              key={action.key}
              type="button"
              onClick={() => {
                action.onSelect();
                onClose();
              }}
              className={`flex w-full items-center gap-3 px-5 py-3 text-left text-base ${
                action.destructive ? 'text-ola-error' : 'text-black/87'
              }`}
            >
              {action.icon != null && (
                <img
                  src={action.icon}
                  alt=""
                  className="h-5 w-5 object-contain"
                />
              )}
              {action.label}
            </button>
          ))}
          <button
            type="button"
            onClick={onClose}
            className="flex w-full items-center justify-center px-5 py-3 text-base font-medium text-black/54"
          >
            {t('dialog.cancel')}
          </button>
        </div>
      </div>
    </div>
  );
}

export function MessageActionSheet(props: MessageActionSheetProps) {
  if (props.anchor != null) {
    return createPortal(
      <AnchoredPopup {...props} anchor={props.anchor} />,
      document.body
    );
  }
  return createPortal(<BottomSheet {...props} />, portalRoot());
}

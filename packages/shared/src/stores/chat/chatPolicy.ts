import i18n from 'i18next';
import { CHAT_POLICY_ERROR_CODES } from '../../constants/chat';
import { toApiError } from '../../lib/apiError';
import { toast } from '../../lib/toast';
import { HTTP_STATUS } from '../../constants/http';

export function showMessageDeleteError(error: unknown): void {
  const expired =
    toApiError(error).code === CHAT_POLICY_ERROR_CODES.deleteExpired;
  toast.error(
    i18n.t(expired ? 'chat.deleteErrExpired' : 'chat.deleteErrFailed')
  );
}

export function showMessagingPolicyError(error: unknown): boolean {
  const apiError = toApiError(error);
  if (
    apiError.code === CHAT_POLICY_ERROR_CODES.messageBlocked ||
    apiError.code === CHAT_POLICY_ERROR_CODES.recipientUnavailable
  ) {
    toast.error(i18n.t('chat.sendErrBlocked'));
    return true;
  }
  if (apiError.code === CHAT_POLICY_ERROR_CODES.friendsOnly) {
    toast.error(i18n.t('chat.sendErrFriendsOnly'));
    return true;
  }
  return false;
}

export function showDirectMessagingError(error: unknown): boolean {
  if (showMessagingPolicyError(error)) return true;
  if (toApiError(error).status === HTTP_STATUS.forbidden) {
    toast.error(i18n.t('chat.sendErrFriendsOnly'));
    return true;
  }
  return false;
}

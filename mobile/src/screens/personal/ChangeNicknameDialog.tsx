import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { TFunction } from 'i18next';
import { Image, Text, TextInput, View } from 'react-native';
import {
  ApiError,
  formatKen,
  USERNAME_MAX,
  USERNAME_PATTERN,
} from '@ola/shared/lib';
import { SettingsService, UserService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type {
  CheckUsernameResult,
  UsernameChangeTier,
} from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';

const kenIcon = require('@assets/icons/apps/ken.png');

const USERNAME_MIN = 2;
const CHECK_DEBOUNCE_MS = 400;

function normalizeNickname(value: string): string {
  return value.trim().toLowerCase().replace(/^@/, '');
}

function isValidNickname(nickname: string): boolean {
  return (
    nickname.length >= USERNAME_MIN &&
    nickname.length <= USERNAME_MAX &&
    USERNAME_PATTERN.test(nickname)
  );
}

function isDisabledError(err: unknown): boolean {
  return err instanceof ApiError && /disabled/i.test(err.message);
}

function tierLabel(
  tier: UsernameChangeTier,
  next: UsernameChangeTier | undefined,
  t: TFunction,
): string {
  if (!next) return t('changeNickname.tierLabelPlus', { n: tier.minLength });
  const upper = next.minLength - 1;
  if (upper === tier.minLength) {
    return t('changeNickname.tierLabel', { n: tier.minLength });
  }
  return t('changeNickname.tierRange', { from: tier.minLength, to: upper });
}

export function ChangeNicknameDialog({
  visible,
  onClose,
  onSuccess,
}: {
  visible: boolean;
  onClose: () => void;
  onSuccess: () => void;
}) {
  const { t } = useTranslation();
  const push = useToastStore(s => s.push);
  const user = useAuthStore(s => s.user);
  const [tiers, setTiers] = useState<UsernameChangeTier[]>([]);
  const [featureDisabled, setFeatureDisabled] = useState(false);
  const [value, setValue] = useState('');
  const [lastCheck, setLastCheck] = useState<CheckUsernameResult | null>(null);
  const [checkFailedFor, setCheckFailedFor] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const ken = user?.ken ?? 0;
  const nickname = normalizeNickname(value);
  const localError =
    nickname === ''
      ? null
      : !isValidNickname(nickname)
        ? 'format'
        : nickname === user?.username
          ? 'same'
          : null;
  const needsCheck = nickname !== '' && localError == null;
  const checked =
    needsCheck && lastCheck?.username === nickname ? lastCheck : null;
  const checkFailed = needsCheck && checkFailedFor === nickname;
  const cost = checked?.cost;
  const canSubmit =
    !submitting &&
    !featureDisabled &&
    tiers.length > 0 &&
    checked != null &&
    checked.available &&
    cost != null &&
    ken >= cost;

  useEffect(() => {
    if (!visible) return;
    let cancelled = false;
    SettingsService.usernameChangeConfig()
      .then(config => {
        if (cancelled) return;
        setFeatureDisabled(!(config.enabled && config.enabledMobile === true));
        setTiers([...config.tiers].sort((a, b) => a.minLength - b.minLength));
      })
      .catch(() => {
        if (!cancelled) push('error', t('changeNickname.checkError'));
      });
    return () => {
      cancelled = true;
    };
  }, [visible, push, t]);

  useEffect(() => {
    if (!visible || !needsCheck || featureDisabled || checked != null) return;
    let cancelled = false;
    const timer = setTimeout(() => {
      setCheckFailedFor(prev => (prev === nickname ? null : prev));
      UserService.checkUsername(nickname)
        .then(result => {
          if (cancelled) return;
          setLastCheck(result);
          setCheckFailedFor(null);
        })
        .catch(err => {
          if (cancelled) return;
          if (isDisabledError(err)) {
            setFeatureDisabled(true);
            return;
          }
          setCheckFailedFor(nickname);
        });
    }, CHECK_DEBOUNCE_MS);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [visible, needsCheck, nickname, featureDisabled, checked]);

  function close() {
    if (submitting) return;
    setValue('');
    setLastCheck(null);
    setCheckFailedFor(null);
    onClose();
  }

  function statusLine() {
    if (localError != null) {
      return (
        <Text className="text-xs text-ola-error">
          {localError === 'same'
            ? t('changeNickname.same')
            : t('changeNickname.invalid')}
        </Text>
      );
    }
    if (checkFailed) {
      return (
        <Text className="text-xs text-ola-error">
          {t('changeNickname.checkError')}
        </Text>
      );
    }
    if (needsCheck && checked == null) {
      return (
        <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.5)' }}>
          {t('changeNickname.checking')}
        </Text>
      );
    }
    if (checked != null) {
      if (!checked.available) {
        return (
          <Text className="text-xs text-ola-error">
            {t('changeNickname.taken')}
          </Text>
        );
      }
      if (cost != null && ken < cost) {
        return (
          <Text className="text-xs text-ola-error">
            {t('changeNickname.insufficient')}
          </Text>
        );
      }
      return (
        <Text className="text-xs text-ola-primary-dark">
          {t('changeNickname.available')}
        </Text>
      );
    }
    return null;
  }

  async function submit() {
    if (!canSubmit || checked == null || cost == null) return;
    setSubmitting(true);
    try {
      await UserService.changeUsername(checked.username, cost);
      push('success', t('changeNickname.success'));
      onSuccess();
      setSubmitting(false);
    } catch (err) {
      if (err instanceof ApiError && /failed to revoke/i.test(err.message)) {
        push('success', t('changeNickname.success'));
        onSuccess();
        setSubmitting(false);
        return;
      }
      let message = t('changeNickname.error');
      if (err instanceof ApiError) {
        if (isDisabledError(err)) {
          setFeatureDisabled(true);
          message = t('changeNickname.disabledNotice');
        } else if (/cost has changed/i.test(err.message)) {
          setLastCheck(null);
          message = t('changeNickname.costChanged');
        } else if (/already exists/i.test(err.message)) {
          message = t('changeNickname.taken');
        } else if (/insufficient ken/i.test(err.message)) {
          message = t('changeNickname.insufficient');
        }
      }
      push('error', message);
      setSubmitting(false);
    }
  }

  return (
    <Dialog
      visible={visible}
      onClose={close}
      title={t('changeNickname.title')}
      dismissOnBackdrop={!submitting}
      footer={
        <>
          <DialogButton onPress={close} disabled={submitting}>
            {t('changeNickname.cancel')}
          </DialogButton>
          {!featureDisabled && (
            <DialogButton
              variant="green"
              disabled={!canSubmit}
              onPress={() => void submit()}
            >
              {cost != null
                ? t('changeNickname.confirm', { ken: formatKen(cost) })
                : t('changeNickname.title')}
            </DialogButton>
          )}
        </>
      }
    >
      {featureDisabled ? (
        <Text className="py-2 text-sm" style={{ color: 'rgba(0,0,0,0.6)' }}>
          {t('changeNickname.disabledNotice')}
        </Text>
      ) : (
        <View className="gap-3">
          <View
            className="rounded"
            style={{
              borderWidth: 1,
              borderColor: 'rgba(0,0,0,0.1)',
              backgroundColor: 'rgba(0,0,0,0.04)',
            }}
          >
            <Text
              className="px-3 py-2 text-xs font-semibold"
              style={{
                color: 'rgba(0,0,0,0.6)',
                borderBottomWidth: 1,
                borderBottomColor: 'rgba(0,0,0,0.1)',
              }}
            >
              {t('changeNickname.priceTitle')}
            </Text>
            {tiers.map((tier, index) => (
              <View
                key={tier.minLength}
                className="flex-row items-center justify-between px-3 py-1.5"
              >
                <Text className="text-sm text-black/80">
                  {tierLabel(tier, tiers[index + 1], t)}
                </Text>
                <View className="flex-row items-center gap-1">
                  <Text className="text-sm font-semibold text-black/80">
                    {formatKen(tier.cost)}
                  </Text>
                  <Image
                    source={kenIcon}
                    style={{ width: 16, height: 16 }}
                    resizeMode="contain"
                  />
                </View>
              </View>
            ))}
          </View>
          <View className="flex-row items-center gap-1">
            <Image
              source={kenIcon}
              style={{ width: 14, height: 14 }}
              resizeMode="contain"
            />
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.6)' }}>
              {t('changeNickname.balance', { ken: formatKen(ken) })}
            </Text>
          </View>
          <View>
            <TextInput
              autoComplete="off"
              autoCapitalize="none"
              autoCorrect={false}
              placeholder={t('changeNickname.inputPlaceholder')}
              placeholderTextColor="rgba(0,0,0,0.4)"
              value={value}
              onChangeText={setValue}
              editable={!submitting}
              className="w-full rounded bg-white px-3 py-2 text-sm"
              style={{
                color: 'rgba(0,0,0,0.87)',
                borderWidth: 1,
                borderColor: 'rgba(0,0,0,0.15)',
              }}
            />
            <View className="mt-1" style={{ minHeight: 16 }}>
              {statusLine()}
            </View>
          </View>
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.5)' }}>
            {t('changeNickname.note')}
          </Text>
        </View>
      )}
    </Dialog>
  );
}

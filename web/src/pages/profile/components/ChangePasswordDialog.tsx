import { useState } from 'react';
import { useForm, type UseFormRegisterReturn } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { PASSWORD_MAX, PASSWORD_MIN } from '@constants';
import { ApiError, toast } from '@lib';
import { AuthService } from '@services';
import { Dialog, DialogButton } from '@components';

interface ChangePasswordForm {
  current: string;
  next: string;
  confirm: string;
}

const FORM_ID = 'change-password-form';
const FIELD_CLASS =
  'w-full rounded border border-black/15 bg-white px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary';

function PasswordField({
  placeholder,
  error,
  field,
}: {
  placeholder: string;
  error?: string;
  field: UseFormRegisterReturn;
}) {
  return (
    <div>
      <input
        type="password"
        autoComplete="off"
        placeholder={placeholder}
        className={FIELD_CLASS}
        {...field}
      />
      {error && <p className="mt-1 text-xs text-ola-error">{error}</p>}
    </div>
  );
}

export function ChangePasswordDialog({
  open,
  onClose,
}: {
  open: boolean;
  onClose: () => void;
}) {
  const { t } = useTranslation();
  const [submitting, setSubmitting] = useState(false);
  const {
    register,
    handleSubmit,
    reset,
    getValues,
    setError,
    formState: { errors },
  } = useForm<ChangePasswordForm>({
    mode: 'onTouched',
    defaultValues: { current: '', next: '', confirm: '' },
  });

  function close() {
    if (submitting) return;
    reset();
    onClose();
  }

  async function onSubmit(data: ChangePasswordForm) {
    setSubmitting(true);
    try {
      await AuthService.changePassword({
        currentPassword: data.current,
        newPassword: data.next,
      });
      toast.success(t('changePassword.success'));
      reset();
      onClose();
    } catch (err) {
      const wrongCurrent =
        err instanceof ApiError && /current password/i.test(err.message);
      const message = wrongCurrent
        ? t('changePassword.errCurrentWrong')
        : t('changePassword.errGeneric');
      if (wrongCurrent) setError('current', { message });
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={close}
      title={t('changePassword.title')}
      dismissOnBackdrop={!submitting}
      footer={
        <>
          <DialogButton type="button" onClick={close} disabled={submitting}>
            {t('common.cancel')}
          </DialogButton>
          <DialogButton
            type="submit"
            form={FORM_ID}
            variant="green"
            disabled={submitting}
          >
            {t('changePassword.submit')}
          </DialogButton>
        </>
      }
    >
      <form
        id={FORM_ID}
        onSubmit={handleSubmit(onSubmit)}
        className="flex flex-col gap-3"
      >
        <PasswordField
          placeholder={t('changePassword.currentPlaceholder')}
          error={errors.current?.message}
          field={register('current', {
            required: t('changePassword.errCurrentRequired'),
          })}
        />
        <PasswordField
          placeholder={t('changePassword.newPlaceholder')}
          error={errors.next?.message}
          field={register('next', {
            required: t('changePassword.errNewRequired'),
            minLength: {
              value: PASSWORD_MIN,
              message: t('changePassword.errNewMin', { min: PASSWORD_MIN }),
            },
            maxLength: {
              value: PASSWORD_MAX,
              message: t('changePassword.errNewMax', { max: PASSWORD_MAX }),
            },
            validate: (value) =>
              value !== getValues('current') ||
              t('changePassword.errSameAsOld'),
          })}
        />
        <PasswordField
          placeholder={t('changePassword.confirmPlaceholder')}
          error={errors.confirm?.message}
          field={register('confirm', {
            required: t('changePassword.errConfirmRequired'),
            validate: (value) =>
              value === getValues('next') ||
              t('changePassword.errConfirmMismatch'),
          })}
        />
      </form>
    </Dialog>
  );
}

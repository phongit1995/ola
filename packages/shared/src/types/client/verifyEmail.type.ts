export type VerifyEmailErrorKey =
  | 'verifyEmail.errGeneric'
  | 'verifyEmail.errEmailInvalid'
  | 'verifyEmail.errDomainNotAllowed'
  | 'verifyEmail.errDailyLimit'
  | 'verifyEmail.errCooldown'
  | 'verifyEmail.errTaken'
  | 'verifyEmail.errTooMany'
  | 'verifyEmail.errCodeExpired'
  | 'verifyEmail.errCodeInvalid'
  | 'verifyEmail.errUnavailable';

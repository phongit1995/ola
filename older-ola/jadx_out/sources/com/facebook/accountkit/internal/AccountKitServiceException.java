package com.facebook.accountkit.internal;

import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitServiceException extends AccountKitException {
    private static final long serialVersionUID = 1;
    private final AccountKitRequestError error;

    public AccountKitServiceException(AccountKitRequestError accountKitRequestError, AccountKitError.Type type, InternalAccountKitError internalAccountKitError) {
        super(type, internalAccountKitError);
        this.error = accountKitRequestError;
    }

    public AccountKitServiceException(AccountKitRequestError accountKitRequestError, AccountKitException accountKitException) {
        super(accountKitException.getError());
        this.error = accountKitRequestError;
    }

    public final AccountKitRequestError getRequestError() {
        return this.error;
    }

    @Override // com.facebook.accountkit.AccountKitException, java.lang.Throwable
    public final String toString() {
        return "{AccountKitServiceException: httpResponseCode: " + this.error.getRequestStatusCode() + ", errorCode: " + this.error.getErrorCode() + ", errorType: " + this.error.getErrorType() + ", message: " + this.error.getErrorMessage() + "}";
    }
}

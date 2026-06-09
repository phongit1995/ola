package com.facebook.accountkit.internal;

import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitRequestError {
    public static final int INVALID_ERROR_CODE = -1;
    public static final int INVALID_HTTP_STATUS_CODE = -1;
    private final int errorCode;
    private final String errorMessage;
    private final String errorType;
    private final AccountKitException exception;
    private final int requestStatusCode;
    private final int subErrorCode;
    private final String userErrorMessage;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public AccountKitRequestError(int i, int i2, int i3, String str, String str2, String str3, AccountKitException accountKitException) {
        this.requestStatusCode = i;
        this.errorCode = i2;
        this.errorType = str;
        this.errorMessage = str2;
        this.subErrorCode = i3;
        this.userErrorMessage = str3;
        this.exception = accountKitException != null ? new AccountKitServiceException(this, accountKitException) : new AccountKitServiceException(this, AccountKitError.Type.SERVER_ERROR, new InternalAccountKitError(i2, str2));
    }

    public AccountKitRequestError(AccountKitException accountKitException) {
        this(-1, accountKitException.getError().getDetailErrorCode(), -1, null, null, null, accountKitException);
    }

    public int getErrorCode() {
        return this.errorCode;
    }

    public String getErrorMessage() {
        return this.errorMessage != null ? this.errorMessage : this.exception.getLocalizedMessage();
    }

    public String getErrorType() {
        return this.errorType;
    }

    public AccountKitException getException() {
        return this.exception;
    }

    public int getRequestStatusCode() {
        return this.requestStatusCode;
    }

    public int getSubErrorCode() {
        return this.subErrorCode;
    }

    public String getUserErrorMessage() {
        return this.userErrorMessage;
    }

    public String toString() {
        return "{HttpStatus: " + this.requestStatusCode + ", errorCode: " + this.errorCode + ", errorType: " + this.errorType + ", errorMessage: " + getErrorMessage() + "}";
    }
}

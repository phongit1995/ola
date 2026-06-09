package com.facebook.accountkit;

import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.internal.InternalAccountKitError;

/* JADX INFO: loaded from: classes.dex */
public class AccountKitException extends RuntimeException {
    private static final long serialVersionUID = 1;
    private final AccountKitError error;

    public AccountKitException(AccountKitError.Type type, InternalAccountKitError internalAccountKitError) {
        super(type.getMessage());
        this.error = new AccountKitError(type, internalAccountKitError);
    }

    public AccountKitException(AccountKitError.Type type, InternalAccountKitError internalAccountKitError, String str) {
        super(String.format(type.getMessage(), str));
        this.error = new AccountKitError(type, internalAccountKitError);
    }

    public AccountKitException(AccountKitError.Type type, InternalAccountKitError internalAccountKitError, Throwable th) {
        super(type.getMessage(), th);
        this.error = new AccountKitError(type, internalAccountKitError);
    }

    public AccountKitException(AccountKitError.Type type, Throwable th) {
        super(type.getMessage(), th);
        this.error = new AccountKitError(type);
    }

    public AccountKitException(AccountKitError accountKitError) {
        super(accountKitError.getErrorType().getMessage());
        this.error = accountKitError;
    }

    public AccountKitError getError() {
        return this.error;
    }

    @Override // java.lang.Throwable
    public String toString() {
        return this.error.toString();
    }
}

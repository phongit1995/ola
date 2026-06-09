package com.facebook.accountkit.internal;

import android.content.Context;
import android.support.annotation.NonNull;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;

/* JADX INFO: loaded from: classes.dex */
final class Validate {
    private static final String NO_INTERNET_PERMISSION_REASON = "No internet permissions granted for the app, please add <uses-permission android:name=\"android.permission.INTERNET\" /> to your AndroidManifest.xml.";

    Validate() {
    }

    static void checkInternetPermissionAndThrow(@NonNull Context context) {
        if (context.checkCallingOrSelfPermission("android.permission.INTERNET") == -1) {
            throw new IllegalStateException(NO_INTERNET_PERMISSION_REASON);
        }
    }

    static void isEquals(Object obj, Object obj2, String str) {
        if (Utility.notEquals(obj, obj2)) {
            throw new AccountKitException(AccountKitError.Type.ARGUMENT_ERROR, InternalAccountKitError.NOT_EQUAL_OBJECTS, str);
        }
    }

    static void loginModelInProgress(LoginModelImpl loginModelImpl) {
        if (loginModelImpl == null) {
            throw new AccountKitException(AccountKitError.Type.ARGUMENT_ERROR, InternalAccountKitError.NO_LOGIN_ATTEMPT_IN_PROGRESS);
        }
    }

    static void loginModelsEqual(LoginModelImpl loginModelImpl, LoginModelImpl loginModelImpl2) {
        if (Utility.notEquals(loginModelImpl, loginModelImpl2)) {
            throw new AccountKitException(AccountKitError.Type.ARGUMENT_ERROR, InternalAccountKitError.DIFFERENT_LOGIN_ATTEMPT_IN_PROGRESS);
        }
    }

    static void sdkInitialized() {
        if (!AccountKit.isInitialized()) {
            throw new AccountKitException(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.SDK_NOT_INITIALIZED);
        }
    }
}

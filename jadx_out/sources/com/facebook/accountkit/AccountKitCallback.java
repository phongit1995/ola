package com.facebook.accountkit;

/* JADX INFO: loaded from: classes.dex */
public interface AccountKitCallback<RESULT> {
    void onError(AccountKitError accountKitError);

    void onSuccess(RESULT result);
}

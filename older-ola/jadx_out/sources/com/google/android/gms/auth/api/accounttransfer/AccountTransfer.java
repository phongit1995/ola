package com.google.android.gms.auth.api.accounttransfer;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Api;

/* JADX INFO: loaded from: classes.dex */
public final class AccountTransfer {
    public static final String ACTION_ACCOUNT_EXPORT_DATA_AVAILABLE = "com.google.android.gms.auth.ACCOUNT_EXPORT_DATA_AVAILABLE";
    public static final String ACTION_ACCOUNT_IMPORT_DATA_AVAILABLE = "com.google.android.gms.auth.ACCOUNT_IMPORT_DATA_AVAILABLE";
    public static final String ACTION_START_ACCOUNT_EXPORT = "com.google.android.gms.auth.START_ACCOUNT_EXPORT";
    public static final String KEY_EXTRA_ACCOUNT_TYPE = "key_extra_account_type";
    private static final Api.ClientKey<com.google.android.gms.internal.auth.zzx> zzau = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<com.google.android.gms.internal.auth.zzx, zzq> zzav = new zzd();
    private static final Api<zzq> zzaw = new Api<>("AccountTransfer.ACCOUNT_TRANSFER_API", zzav, zzau);

    @Deprecated
    private static final zze zzax = new com.google.android.gms.internal.auth.zzw();
    private static final zzt zzay = new com.google.android.gms.internal.auth.zzw();

    private AccountTransfer() {
    }

    public static AccountTransferClient getAccountTransferClient(@NonNull Activity activity) {
        return new AccountTransferClient(activity);
    }

    public static AccountTransferClient getAccountTransferClient(@NonNull Context context) {
        return new AccountTransferClient(context);
    }
}

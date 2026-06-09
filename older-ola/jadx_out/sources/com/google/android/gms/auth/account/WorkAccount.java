package com.google.android.gms.auth.account;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.internal.auth.zzk;
import com.google.android.gms.internal.auth.zzu;

/* JADX INFO: loaded from: classes.dex */
public class WorkAccount {
    private static final Api.ClientKey<zzu> CLIENT_KEY = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<zzu, Api.ApiOptions.NoOptions> CLIENT_BUILDER = new zzi();
    public static final Api<Api.ApiOptions.NoOptions> API = new Api<>("WorkAccount.API", CLIENT_BUILDER, CLIENT_KEY);

    @Deprecated
    public static final WorkAccountApi WorkAccountApi = new zzk();

    private WorkAccount() {
    }

    public static WorkAccountClient getClient(@NonNull Activity activity) {
        return new WorkAccountClient(activity);
    }

    public static WorkAccountClient getClient(@NonNull Context context) {
        return new WorkAccountClient(context);
    }
}

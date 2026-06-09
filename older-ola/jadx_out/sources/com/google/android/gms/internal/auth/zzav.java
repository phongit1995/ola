package com.google.android.gms.internal.auth;

import android.content.Context;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
abstract class zzav<R extends Result> extends BaseImplementation.ApiMethodImpl<R, zzax> {
    zzav(GoogleApiClient googleApiClient) {
        super(Auth.CREDENTIALS_API, googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected /* synthetic */ void doExecute(Api.AnyClient anyClient) {
        zzax zzaxVar = (zzax) anyClient;
        zzd(zzaxVar.getContext(), (zzbc) zzaxVar.getService());
    }

    protected abstract void zzd(Context context, zzbc zzbcVar);
}

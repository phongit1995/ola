package com.google.android.gms.internal.auth;

import android.content.Context;
import com.google.android.gms.auth.api.proxy.ProxyApi;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
abstract class zzbm extends BaseImplementation.ApiMethodImpl<ProxyApi.ProxyResult, zzbh> {
    public zzbm(GoogleApiClient googleApiClient) {
        super(com.google.android.gms.auth.api.zzf.API, googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    protected /* synthetic */ Result createFailedResult(Status status) {
        return new zzbq(status);
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected /* synthetic */ void doExecute(Api.AnyClient anyClient) {
        zzbh zzbhVar = (zzbh) anyClient;
        zzd(zzbhVar.getContext(), (zzbk) zzbhVar.getService());
    }

    protected abstract void zzd(Context context, zzbk zzbkVar);
}

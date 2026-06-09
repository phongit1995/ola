package com.google.android.gms.common.internal.service;

import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.internal.service.CommonApiImpl;

/* JADX INFO: loaded from: classes.dex */
final class zzb extends zzd {
    zzb(CommonApiImpl commonApiImpl, GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) {
        ((ICommonService) ((CommonClient) anyClient).getService()).clearDefaultAccount(new CommonApiImpl.zza(this));
    }
}

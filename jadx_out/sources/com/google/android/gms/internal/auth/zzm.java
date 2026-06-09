package com.google.android.gms.internal.auth;

import com.google.android.gms.auth.account.WorkAccountApi;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
final class zzm extends BaseImplementation.ApiMethodImpl<WorkAccountApi.AddAccountResult, zzu> {
    private final /* synthetic */ String zzt;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzm(zzk zzkVar, Api api, GoogleApiClient googleApiClient, String str) {
        super((Api<?>) api, googleApiClient);
        this.zzt = str;
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    protected final /* synthetic */ Result createFailedResult(Status status) {
        return new zzr(status, null);
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) {
        ((com.google.android.gms.auth.account.zzf) ((zzu) anyClient).getService()).zzd(new zzn(this), this.zzt);
    }
}

package com.google.android.gms.internal.auth;

import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
final class zzl extends BaseImplementation.ApiMethodImpl<Result, zzu> {
    private final /* synthetic */ boolean zzag;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzl(zzk zzkVar, Api api, GoogleApiClient googleApiClient, boolean z) {
        super((Api<?>) api, googleApiClient);
        this.zzag = z;
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    protected final Result createFailedResult(Status status) {
        return new zzs(status);
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) {
        ((com.google.android.gms.auth.account.zzf) ((zzu) anyClient).getService()).zze(this.zzag);
        setResult(new zzs(Status.RESULT_SUCCESS));
    }
}

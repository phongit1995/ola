package com.google.android.gms.internal.auth;

import android.content.Context;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzas extends zzav<Status> {
    private final /* synthetic */ Credential zzdt;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzas(zzao zzaoVar, GoogleApiClient googleApiClient, Credential credential) {
        super(googleApiClient);
        this.zzdt = credential;
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    protected final /* synthetic */ Result createFailedResult(Status status) {
        return status;
    }

    @Override // com.google.android.gms.internal.auth.zzav
    protected final void zzd(Context context, zzbc zzbcVar) {
        zzbcVar.zzd(new zzau(this), new zzay(this.zzdt));
    }
}

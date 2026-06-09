package com.google.android.gms.internal.auth;

import android.content.Context;
import com.google.android.gms.auth.api.credentials.CredentialRequest;
import com.google.android.gms.auth.api.credentials.CredentialRequestResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzap extends zzav<CredentialRequestResult> {
    private final /* synthetic */ CredentialRequest zzdr;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzap(zzao zzaoVar, GoogleApiClient googleApiClient, CredentialRequest credentialRequest) {
        super(googleApiClient);
        this.zzdr = credentialRequest;
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    protected final /* synthetic */ Result createFailedResult(Status status) {
        return zzan.zzf(status);
    }

    @Override // com.google.android.gms.internal.auth.zzav
    protected final void zzd(Context context, zzbc zzbcVar) {
        zzbcVar.zzd(new zzaq(this), this.zzdr);
    }
}

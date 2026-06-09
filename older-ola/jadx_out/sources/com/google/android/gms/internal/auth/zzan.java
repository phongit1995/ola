package com.google.android.gms.internal.auth;

import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.auth.api.credentials.CredentialRequestResult;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
public final class zzan implements CredentialRequestResult {
    private final Status mStatus;
    private final Credential zzdq;

    public zzan(Status status, Credential credential) {
        this.mStatus = status;
        this.zzdq = credential;
    }

    public static zzan zzf(Status status) {
        return new zzan(status, null);
    }

    @Override // com.google.android.gms.auth.api.credentials.CredentialRequestResult
    public final Credential getCredential() {
        return this.zzdq;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.mStatus;
    }
}

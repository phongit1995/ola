package com.google.android.gms.auth.api.signin.internal;

import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzo extends zzd {
    private final /* synthetic */ zzn zzez;

    zzo(zzn zznVar) {
        this.zzez = zznVar;
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzd, com.google.android.gms.auth.api.signin.internal.zzt
    public final void zzh(Status status) {
        this.zzez.setResult(status);
    }
}

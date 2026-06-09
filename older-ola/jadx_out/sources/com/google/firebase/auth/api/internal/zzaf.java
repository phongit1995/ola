package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzaf implements zzdk<com.google.android.gms.internal.firebase_auth.zzba> {
    private final /* synthetic */ zzcb zzfl;

    zzaf(zza zzaVar, zzcb zzcbVar) {
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzba zzbaVar) {
        this.zzfl.zzd(zzbaVar.getEmail());
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

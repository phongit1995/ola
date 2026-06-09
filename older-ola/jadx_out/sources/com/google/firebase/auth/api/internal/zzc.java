package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzc implements zzdk<com.google.android.gms.internal.firebase_auth.zzbc> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;

    zzc(zza zzaVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzbc zzbcVar) {
        com.google.android.gms.internal.firebase_auth.zzbc zzbcVar2 = zzbcVar;
        this.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzao(zzbcVar2.zzap(), zzbcVar2.getIdToken(), Long.valueOf(zzbcVar2.zzaq()), "Bearer"), null, null, true, null, this.zzfl, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

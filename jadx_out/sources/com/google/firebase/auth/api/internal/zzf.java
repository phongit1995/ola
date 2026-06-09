package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzf implements zzdk<com.google.android.gms.internal.firebase_auth.zzab> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;

    zzf(zza zzaVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzab zzabVar) {
        com.google.android.gms.internal.firebase_auth.zzab zzabVar2 = zzabVar;
        this.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzao(zzabVar2.zzap(), zzabVar2.getIdToken(), Long.valueOf(zzabVar2.zzaq()), "Bearer"), null, null, Boolean.valueOf(zzabVar2.isNewUser()), null, this.zzfl, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

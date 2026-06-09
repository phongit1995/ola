package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzm implements zzdk<com.google.android.gms.internal.firebase_auth.zzbj> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;

    zzm(zza zzaVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzbj zzbjVar) {
        com.google.android.gms.internal.firebase_auth.zzbj zzbjVar2 = zzbjVar;
        this.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzao(zzbjVar2.zzap(), zzbjVar2.getIdToken(), Long.valueOf(zzbjVar2.zzaq()), "Bearer"), null, null, Boolean.valueOf(zzbjVar2.isNewUser()), null, this.zzfl, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

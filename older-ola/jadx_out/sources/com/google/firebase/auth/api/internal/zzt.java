package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzt implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    final /* synthetic */ zzcb zzfl;
    final /* synthetic */ zza zzfm;
    final /* synthetic */ String zzgc;

    zzt(zza zzaVar, String str, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzgc = str;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        com.google.android.gms.internal.firebase_auth.zzao zzaoVar2 = zzaoVar;
        this.zzfm.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzag(zzaoVar2.zzaw()), new zzu(this, this, zzaoVar2));
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

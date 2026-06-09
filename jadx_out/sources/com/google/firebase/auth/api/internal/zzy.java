package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzy implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;

    zzy(zza zzaVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzfm.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzz(zzaoVar.zzaw()), new zzz(this, this));
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

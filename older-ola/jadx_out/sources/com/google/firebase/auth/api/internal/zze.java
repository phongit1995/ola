package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.firebase.auth.EmailAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
final class zze implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;
    private final /* synthetic */ EmailAuthCredential zzfn;

    zze(zza zzaVar, EmailAuthCredential emailAuthCredential, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfn = emailAuthCredential;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzaa(this.zzfn, zzaoVar.zzaw()), this.zzfl);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}

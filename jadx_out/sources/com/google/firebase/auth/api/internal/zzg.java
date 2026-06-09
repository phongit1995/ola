package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzg implements zzdk<com.google.android.gms.internal.firebase_auth.zzah> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;
    private final /* synthetic */ zzdj zzfo;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzao zzfp;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzaz zzfq;

    zzg(zza zzaVar, zzdj zzdjVar, zzcb zzcbVar, com.google.android.gms.internal.firebase_auth.zzao zzaoVar, com.google.android.gms.internal.firebase_auth.zzaz zzazVar) {
        this.zzfm = zzaVar;
        this.zzfo = zzdjVar;
        this.zzfl = zzcbVar;
        this.zzfp = zzaoVar;
        this.zzfq = zzazVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzah zzahVar) {
        List<com.google.android.gms.internal.firebase_auth.zzaj> listZzas = zzahVar.zzas();
        if (listZzas == null || listZzas.isEmpty()) {
            this.zzfo.zzc("No users");
        } else {
            this.zzfm.zza(this.zzfl, this.zzfp, listZzas.get(0), this.zzfq, this.zzfo);
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfo.zzc(str);
    }
}

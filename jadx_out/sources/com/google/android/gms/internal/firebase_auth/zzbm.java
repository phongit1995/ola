package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbm implements com.google.firebase.auth.api.internal.zzcg<zzbm, zzg.zzi> {
    private String zzad;
    private String zzaf;
    private String zzah;
    private String zzai;
    private long zzaj;
    private String zzbh;
    private String zzbr;

    @NonNull
    public final String getIdToken() {
        return this.zzaf;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.zzi zziVar = (zzg.zzi) zzgtVar;
        this.zzad = Strings.emptyToNull(zziVar.zzad);
        this.zzah = Strings.emptyToNull(zziVar.zzah);
        this.zzbh = Strings.emptyToNull(zziVar.zzbh);
        this.zzaf = Strings.emptyToNull(zziVar.zzaf);
        this.zzbr = Strings.emptyToNull(zziVar.zzbr);
        this.zzai = Strings.emptyToNull(zziVar.zzai);
        this.zzaj = zziVar.zzaj;
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.zzi> zzag() {
        return zzg.zzi.class;
    }

    @NonNull
    public final String zzap() {
        return this.zzai;
    }

    public final long zzaq() {
        return this.zzaj;
    }
}

package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;

/* JADX INFO: loaded from: classes2.dex */
public final class zzab implements com.google.firebase.auth.api.internal.zzcg<zzab, zzg.zzb> {
    private String zzad;
    private String zzaf;
    private String zzah;
    private String zzai;
    private long zzaj;
    private boolean zzak;

    @NonNull
    public final String getIdToken() {
        return this.zzaf;
    }

    public final boolean isNewUser() {
        return this.zzak;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.zzb zzbVar = (zzg.zzb) zzgtVar;
        this.zzad = Strings.emptyToNull(zzbVar.zzad);
        this.zzah = Strings.emptyToNull(zzbVar.zzah);
        this.zzaf = Strings.emptyToNull(zzbVar.zzaf);
        this.zzai = Strings.emptyToNull(zzbVar.zzai);
        this.zzak = zzbVar.zzak;
        this.zzaj = zzbVar.zzaj;
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.zzb> zzag() {
        return zzg.zzb.class;
    }

    @NonNull
    public final String zzap() {
        return this.zzai;
    }

    public final long zzaq() {
        return this.zzaj;
    }
}

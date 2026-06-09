package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.Nullable;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzba implements com.google.firebase.auth.api.internal.zzcg<zzba, zzg.zze> {
    private String zzaf;
    private String zzah;
    private String zzai;
    private long zzaj;
    private String zzbh;
    private String zzbi;
    private String zzbr;
    private zzas zzjr;
    private Boolean zzkg;

    @Nullable
    public final String getEmail() {
        return this.zzah;
    }

    @Nullable
    public final String getIdToken() {
        return this.zzaf;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.zze zzeVar = (zzg.zze) zzgtVar;
        this.zzah = Strings.emptyToNull(zzeVar.zzah);
        this.zzbi = Strings.emptyToNull(zzeVar.zzby);
        this.zzkg = Boolean.valueOf(zzeVar.zzbk);
        this.zzbh = Strings.emptyToNull(zzeVar.zzbh);
        this.zzbr = Strings.emptyToNull(zzeVar.zzbr);
        this.zzjr = zzas.zza(zzeVar.zzbx);
        this.zzaf = Strings.emptyToNull(zzeVar.zzaf);
        this.zzai = Strings.emptyToNull(zzeVar.zzai);
        this.zzaj = zzeVar.zzaj;
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.zze> zzag() {
        return zzg.zze.class;
    }

    @Nullable
    public final String zzap() {
        return this.zzai;
    }

    public final long zzaq() {
        return this.zzaj;
    }

    public final List<zzaq> zzat() {
        if (this.zzjr != null) {
            return this.zzjr.zzat();
        }
        return null;
    }
}

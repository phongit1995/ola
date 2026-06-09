package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbh implements com.google.firebase.auth.api.internal.zzcg<zzbh, zzg.C0067zzg> {
    private String zzad;
    private String zzaf;
    private String zzah;
    private String zzai;
    private long zzaj;
    private boolean zzak;
    private String zzbh;
    private String zzbr;
    private String zzdf;
    private String zzj;
    private boolean zzkl;
    private boolean zzkm;
    private String zzkn;
    private String zzko;

    public final String getIdToken() {
        return this.zzaf;
    }

    public final String getProviderId() {
        return this.zzj;
    }

    public final String getRawUserInfo() {
        return this.zzdf;
    }

    public final boolean isNewUser() {
        return this.zzak;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.C0067zzg c0067zzg = (zzg.C0067zzg) zzgtVar;
        this.zzkl = c0067zzg.zzcu;
        this.zzkm = c0067zzg.zzdb;
        this.zzaf = Strings.emptyToNull(c0067zzg.zzaf);
        this.zzai = Strings.emptyToNull(c0067zzg.zzai);
        this.zzaj = c0067zzg.zzaj;
        this.zzad = Strings.emptyToNull(c0067zzg.zzad);
        this.zzah = Strings.emptyToNull(c0067zzg.zzah);
        this.zzbh = Strings.emptyToNull(c0067zzg.zzbh);
        this.zzbr = Strings.emptyToNull(c0067zzg.zzbr);
        this.zzj = Strings.emptyToNull(c0067zzg.zzj);
        this.zzdf = Strings.emptyToNull(c0067zzg.zzdf);
        this.zzak = c0067zzg.zzak;
        this.zzkn = c0067zzg.zzcx;
        this.zzko = c0067zzg.zzdd;
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.C0067zzg> zzag() {
        return zzg.C0067zzg.class;
    }

    @Nullable
    public final String zzap() {
        return this.zzai;
    }

    public final long zzaq() {
        return this.zzaj;
    }

    @Nullable
    public final com.google.firebase.auth.zzd zzav() {
        if (TextUtils.isEmpty(this.zzkn) && TextUtils.isEmpty(this.zzko)) {
            return null;
        }
        return com.google.firebase.auth.zzd.zza(this.zzj, this.zzko, this.zzkn);
    }

    public final boolean zzbe() {
        return this.zzkl;
    }
}

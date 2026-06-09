package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaf implements com.google.firebase.auth.api.internal.zzdp<zzgz> {
    private String zzjm;
    private String zzjn;

    @Nullable
    private final String zzjo;

    public zzaf(String str) {
        this(str, null);
    }

    private zzaf(String str, @Nullable String str2) {
        this.zzjm = zzae.REFRESH_TOKEN.toString();
        this.zzjn = Preconditions.checkNotEmpty(str);
        this.zzjo = null;
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzgz zzgzVar = new zzgz();
        zzgzVar.zzjm = this.zzjm;
        zzgzVar.zzai = this.zzjn;
        zzgzVar.zzjo = null;
        return zzgzVar;
    }
}

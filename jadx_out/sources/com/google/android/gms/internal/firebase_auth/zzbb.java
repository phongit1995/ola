package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbb implements com.google.firebase.auth.api.internal.zzdp<zzp> {
    private String zzah;
    private String zzbh;
    private String zzbi;
    private boolean zzbt;

    public zzbb() {
        this.zzbt = true;
    }

    public zzbb(@NonNull String str, @NonNull String str2, @Nullable String str3) {
        this.zzah = Preconditions.checkNotEmpty(str);
        this.zzbi = Preconditions.checkNotEmpty(str2);
        this.zzbh = null;
        this.zzbt = true;
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzp zzpVar = new zzp();
        zzpVar.zzah = this.zzah;
        zzpVar.zzbi = this.zzbi;
        zzpVar.zzbh = null;
        return zzpVar;
    }
}

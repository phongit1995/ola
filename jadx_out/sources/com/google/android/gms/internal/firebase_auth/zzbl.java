package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbl implements com.google.firebase.auth.api.internal.zzdp<zzs> {
    private String zzah;
    private String zzbi;
    private boolean zzbt = true;

    public zzbl(@NonNull String str, @NonNull String str2) {
        this.zzah = Preconditions.checkNotEmpty(str);
        this.zzbi = Preconditions.checkNotEmpty(str2);
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzs zzsVar = new zzs();
        zzsVar.zzah = this.zzah;
        zzsVar.zzbi = this.zzbi;
        zzsVar.zzbt = this.zzbt;
        return zzsVar;
    }
}

package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzw implements com.google.firebase.auth.api.internal.zzdp<zzh> {
    private String zzg;
    private String zzh = "http://localhost";

    public zzw(@NonNull String str) {
        this.zzg = Preconditions.checkNotEmpty(str);
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzh zzhVar = new zzh();
        zzhVar.zzg = this.zzg;
        zzhVar.zzh = this.zzh;
        return zzhVar;
    }
}

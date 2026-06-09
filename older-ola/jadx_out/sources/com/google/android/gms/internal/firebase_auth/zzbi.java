package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbi implements com.google.firebase.auth.api.internal.zzdp<zzr> {
    private boolean zzbt = true;
    private String zzdh;

    public zzbi(@NonNull String str) {
        this.zzdh = Preconditions.checkNotEmpty(str);
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzr zzrVar = new zzr();
        zzrVar.zzdh = this.zzdh;
        zzrVar.zzbt = this.zzbt;
        return zzrVar;
    }
}

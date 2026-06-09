package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzz implements com.google.firebase.auth.api.internal.zzdp<zzi> {
    private String zzaf;

    public zzz(@NonNull String str) {
        this.zzaf = Preconditions.checkNotEmpty(str);
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzi zziVar = new zzi();
        zziVar.zzaf = this.zzaf;
        return zziVar;
    }
}

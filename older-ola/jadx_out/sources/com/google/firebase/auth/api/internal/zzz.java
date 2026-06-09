package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzz implements zzdk<Void> {
    private final /* synthetic */ zzdk zzga;
    private final /* synthetic */ zzy zzgg;

    zzz(zzy zzyVar, zzdk zzdkVar) {
        this.zzgg = zzyVar;
        this.zzga = zzdkVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull Void r1) {
        this.zzgg.zzfl.zzac();
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzga.zzc(str);
    }
}

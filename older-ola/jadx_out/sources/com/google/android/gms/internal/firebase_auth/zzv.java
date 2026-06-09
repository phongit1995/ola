package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public class zzv extends RuntimeException {
    private zzad zzfi;

    public zzv(zzad zzadVar) {
        this.zzfi = (zzad) Preconditions.checkNotNull(zzadVar);
    }

    public zzv(Throwable th) {
        super(th);
    }

    @Nullable
    public final String getErrorMessage() {
        zzac zzacVarZzar = this.zzfi != null ? this.zzfi.zzar() : null;
        return zzacVarZzar != null ? zzacVarZzar.getErrorMessage() : getMessage();
    }
}

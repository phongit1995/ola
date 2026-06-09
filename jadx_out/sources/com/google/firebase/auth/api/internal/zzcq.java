package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcq {
    private String zzho;

    public zzcq(@NonNull String str) {
        this.zzho = Preconditions.checkNotEmpty(str);
    }

    public final zzcp zzah() {
        return new zzcp(this.zzho, null);
    }
}

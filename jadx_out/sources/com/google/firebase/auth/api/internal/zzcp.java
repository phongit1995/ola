package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcp extends zzaj implements Api.ApiOptions.HasOptions {
    private final String zzho;

    private zzcp(@NonNull String str) {
        this.zzho = Preconditions.checkNotEmpty(str, "A valid API key must be provided");
    }

    /* synthetic */ zzcp(String str, zzco zzcoVar) {
        this(str);
    }

    @Override // com.google.firebase.auth.api.internal.zzaj
    public final /* synthetic */ Object clone() {
        return new zzcq(this.zzho).zzah();
    }

    public final String getApiKey() {
        return this.zzho;
    }

    @Override // com.google.firebase.auth.api.internal.zzaj
    /* JADX INFO: renamed from: zzy */
    public final /* synthetic */ zzaj clone() {
        return (zzcp) clone();
    }
}

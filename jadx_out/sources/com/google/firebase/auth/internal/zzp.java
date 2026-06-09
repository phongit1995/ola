package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.auth.ProviderQueryResult;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzp implements ProviderQueryResult {
    private List<String> zzlg;

    public zzp(@NonNull com.google.android.gms.internal.firebase_auth.zzx zzxVar) {
        Preconditions.checkNotNull(zzxVar);
        this.zzlg = zzxVar.getAllProviders();
    }

    @Override // com.google.firebase.auth.ProviderQueryResult
    @Nullable
    public final List<String> getProviders() {
        return this.zzlg;
    }
}

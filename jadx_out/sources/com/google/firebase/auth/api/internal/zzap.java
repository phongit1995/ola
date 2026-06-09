package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzap extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzgu;

    public zzap(@NonNull String str) {
        super(7);
        this.zzgu = Preconditions.checkNotEmpty(str, "code cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzj(this.zzgu, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(null);
    }
}

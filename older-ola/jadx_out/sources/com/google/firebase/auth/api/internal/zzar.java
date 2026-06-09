package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzar extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzba;

    @NonNull
    private final String zzgu;

    public zzar(@NonNull String str, @NonNull String str2) {
        super(4);
        this.zzgu = Preconditions.checkNotEmpty(str, "code cannot be null or empty");
        this.zzba = Preconditions.checkNotEmpty(str2, "new password cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzf(this.zzgu, this.zzba, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(null);
    }
}

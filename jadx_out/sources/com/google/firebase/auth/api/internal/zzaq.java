package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.ActionCodeResult;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzaq extends zzcy<ActionCodeResult, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzgu;

    public zzaq(@NonNull String str) {
        super(4);
        this.zzgu = Preconditions.checkNotEmpty(str, "code cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzi(this.zzgu, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(new com.google.firebase.auth.internal.zzc(this.zzio));
    }
}

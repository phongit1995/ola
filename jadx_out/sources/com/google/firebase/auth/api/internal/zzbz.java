package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseError;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbz extends zzcy<String, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzgu;

    public zzbz(@NonNull String str) {
        super(4);
        this.zzgu = Preconditions.checkNotEmpty(str, "code cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzi(this.zzgu, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        if (new com.google.firebase.auth.internal.zzc(this.zzio).getOperation() != 0) {
            zzc(new Status(FirebaseError.ERROR_INTERNAL_ERROR));
        } else {
            zzb(this.zzio.getEmail());
        }
    }
}

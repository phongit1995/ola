package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.SignInMethodQueryResult;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzav extends zzcy<SignInMethodQueryResult, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzah;

    public zzav(@NonNull String str) {
        super(3);
        this.zzah = Preconditions.checkNotEmpty(str, "email cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzc(this.zzah, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(new com.google.firebase.auth.internal.zzr(this.zzin.getSignInMethods()));
    }
}

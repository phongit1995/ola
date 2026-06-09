package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.ActionCodeSettings;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbl extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzah;

    @NonNull
    private final ActionCodeSettings zzhb;

    public zzbl(@NonNull String str, @NonNull ActionCodeSettings actionCodeSettings) {
        super(4);
        this.zzah = Preconditions.checkNotEmpty(str, "email cannot be null or empty");
        this.zzhb = actionCodeSettings;
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzc(this.zzah, this.zzhb, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(null);
    }
}

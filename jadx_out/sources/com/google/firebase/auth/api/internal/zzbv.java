package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbv extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzah;

    public zzbv(String str) {
        super(2);
        this.zzah = Preconditions.checkNotEmpty(str, "email cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzic.zzq(), this.zzah, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzao.zza(this.zzeb, this.zzim));
        zzb(null);
    }
}

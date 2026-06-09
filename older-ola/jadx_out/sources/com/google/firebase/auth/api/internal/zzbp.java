package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.AuthResult;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbp extends zzcy<AuthResult, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final String zzdh;

    public zzbp(@NonNull String str) {
        super(2);
        this.zzdh = Preconditions.checkNotEmpty(str, "token cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzb(this.zzdh, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
        zzb(new com.google.firebase.auth.internal.zzf(zzlVarZza));
    }
}

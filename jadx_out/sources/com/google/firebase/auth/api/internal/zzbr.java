package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.EmailAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbr extends zzcy<AuthResult, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final EmailAuthCredential zzhd;

    public zzbr(@NonNull EmailAuthCredential emailAuthCredential) {
        super(2);
        this.zzhd = (EmailAuthCredential) Preconditions.checkNotNull(emailAuthCredential, "credential cannot be null");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzhd, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
        zzb(new com.google.firebase.auth.internal.zzf(zzlVarZza));
    }
}

package com.google.firebase.auth.api.internal;

import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbs extends zzcy<AuthResult, com.google.firebase.auth.internal.zza> {
    private PhoneAuthCredential zzgx;

    public zzbs(PhoneAuthCredential phoneAuthCredential) {
        super(2);
        this.zzgx = (PhoneAuthCredential) Preconditions.checkNotNull(phoneAuthCredential);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzgx, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
        zzb(new com.google.firebase.auth.internal.zzf(zzlVarZza));
    }
}

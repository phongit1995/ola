package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzaz extends zzcy<AuthResult, com.google.firebase.auth.internal.zza> implements zzda {

    @NonNull
    private final PhoneAuthCredential zzgx;

    public zzaz(@NonNull PhoneAuthCredential phoneAuthCredential) {
        super(2);
        this.zzgx = (PhoneAuthCredential) Preconditions.checkNotNull(phoneAuthCredential, "credential cannot be null");
        this.zzik = this;
    }

    @Override // com.google.firebase.auth.api.internal.zzda
    public final void zza(@NonNull Status status, @NonNull PhoneAuthCredential phoneAuthCredential) {
        boolean z = this.zzia == 2;
        int i = this.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zzis = false;
        this.zziq = phoneAuthCredential;
        if (this.zzif != null) {
            this.zzif.zza(status);
        }
        zzc(status);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzic.zzq(), this.zzgx, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
        zzb(new com.google.firebase.auth.internal.zzf(zzlVarZza));
    }
}

package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseError;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.EmailAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbf extends zzcy<AuthResult, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final EmailAuthCredential zzgv;

    public zzbf(@NonNull EmailAuthCredential emailAuthCredential) {
        super(2);
        this.zzgv = (EmailAuthCredential) Preconditions.checkNotNull(emailAuthCredential, "credential cannot be null or empty");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzgv, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        if (!this.zzic.getUid().equalsIgnoreCase(zzlVarZza.getUid())) {
            zzc(new Status(FirebaseError.ERROR_USER_MISMATCH));
        } else {
            ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
            zzb(new com.google.firebase.auth.internal.zzf(zzlVarZza));
        }
    }
}

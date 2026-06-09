package com.google.firebase.auth.api.internal;

import android.os.IInterface;
import com.google.android.gms.common.api.Status;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
public interface zzch extends IInterface {
    void onFailure(Status status);

    void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential);

    void zza(Status status, PhoneAuthCredential phoneAuthCredential);

    void zza(com.google.android.gms.internal.firebase_auth.zzao zzaoVar, com.google.android.gms.internal.firebase_auth.zzaj zzajVar);

    void zza(com.google.android.gms.internal.firebase_auth.zzav zzavVar);

    void zza(com.google.android.gms.internal.firebase_auth.zzx zzxVar);

    void zzac();

    void zzad();

    void zzae();

    void zzb(com.google.android.gms.internal.firebase_auth.zzao zzaoVar);

    void zzd(String str);

    void zze(String str);

    void zzf(String str);
}

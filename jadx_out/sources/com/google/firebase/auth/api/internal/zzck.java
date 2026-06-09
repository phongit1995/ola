package com.google.firebase.auth.api.internal;

import android.os.IInterface;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.EmailAuthCredential;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
public interface zzck extends IInterface {
    void zza(com.google.android.gms.internal.firebase_auth.zzax zzaxVar, zzch zzchVar);

    void zza(com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, zzch zzchVar);

    void zza(EmailAuthCredential emailAuthCredential, zzch zzchVar);

    void zza(PhoneAuthCredential phoneAuthCredential, zzch zzchVar);

    void zza(zzch zzchVar);

    void zza(String str, com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, zzch zzchVar);

    @Deprecated
    void zza(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar);

    void zza(String str, PhoneAuthCredential phoneAuthCredential, zzch zzchVar);

    void zza(String str, UserProfileChangeRequest userProfileChangeRequest, zzch zzchVar);

    void zza(String str, zzch zzchVar);

    void zza(String str, String str2, zzch zzchVar);

    void zza(String str, String str2, String str3, zzch zzchVar);

    void zzb(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar);

    void zzb(String str, zzch zzchVar);

    void zzb(String str, String str2, zzch zzchVar);

    void zzc(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar);

    void zzc(String str, zzch zzchVar);

    void zzc(String str, String str2, zzch zzchVar);

    void zzd(String str, zzch zzchVar);

    void zzd(String str, String str2, zzch zzchVar);

    void zze(String str, zzch zzchVar);

    void zze(String str, String str2, zzch zzchVar);

    void zzf(String str, zzch zzchVar);

    void zzf(String str, String str2, zzch zzchVar);

    void zzg(String str, zzch zzchVar);

    void zzh(String str, zzch zzchVar);

    void zzi(String str, zzch zzchVar);

    void zzj(String str, zzch zzchVar);

    void zzk(String str, zzch zzchVar);
}

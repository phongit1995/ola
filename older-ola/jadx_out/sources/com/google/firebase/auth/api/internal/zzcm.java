package com.google.firebase.auth.api.internal;

import android.os.IBinder;
import android.os.Parcel;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.EmailAuthCredential;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcm extends com.google.android.gms.internal.firebase_auth.zza implements zzck {
    zzcm(IBinder iBinder) {
        super(iBinder, "com.google.firebase.auth.api.internal.IFirebaseAuthService");
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(com.google.android.gms.internal.firebase_auth.zzax zzaxVar, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzaxVar);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(22, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzbfVar);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(EmailAuthCredential emailAuthCredential, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, emailAuthCredential);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(29, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(PhoneAuthCredential phoneAuthCredential, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, phoneAuthCredential);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(23, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(16, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzbfVar);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(12, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, actionCodeSettings);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(25, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, PhoneAuthCredential phoneAuthCredential, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, phoneAuthCredential);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(24, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, UserProfileChangeRequest userProfileChangeRequest, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, userProfileChangeRequest);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(4, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(1, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(5, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zza(String str, String str2, String str3, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        parcelObtainAndWriteInterfaceToken.writeString(str3);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(11, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzb(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, actionCodeSettings);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(26, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzb(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzb(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(6, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzc(String str, ActionCodeSettings actionCodeSettings, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, actionCodeSettings);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(28, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzc(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzc(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(7, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzd(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(10, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzd(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(8, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zze(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(13, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zze(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(14, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzf(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(15, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzf(String str, String str2, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        parcelObtainAndWriteInterfaceToken.writeString(str2);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(21, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzg(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(17, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzh(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(18, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzi(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(19, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzj(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(20, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzck
    public final void zzk(String str, zzch zzchVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzchVar);
        transactAndReadExceptionReturnVoid(27, parcelObtainAndWriteInterfaceToken);
    }
}

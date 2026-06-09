package com.google.firebase.auth.api.internal;

import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.common.api.Status;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcj extends com.google.android.gms.internal.firebase_auth.zza implements zzch {
    zzcj(IBinder iBinder) {
        super(iBinder, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void onFailure(Status status) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, status);
        transactOneway(5, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, phoneAuthCredential);
        transactOneway(10, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(Status status, PhoneAuthCredential phoneAuthCredential) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, status);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, phoneAuthCredential);
        transactOneway(12, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(com.google.android.gms.internal.firebase_auth.zzao zzaoVar, com.google.android.gms.internal.firebase_auth.zzaj zzajVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzaoVar);
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzajVar);
        transactOneway(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(com.google.android.gms.internal.firebase_auth.zzav zzavVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzavVar);
        transactOneway(4, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(com.google.android.gms.internal.firebase_auth.zzx zzxVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzxVar);
        transactOneway(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzac() {
        transactOneway(6, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzad() {
        transactOneway(7, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzae() {
        transactOneway(13, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzb(com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.firebase_auth.zzc.zza(parcelObtainAndWriteInterfaceToken, zzaoVar);
        transactOneway(1, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzd(String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactOneway(8, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zze(String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactOneway(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzf(String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactOneway(11, parcelObtainAndWriteInterfaceToken);
    }
}

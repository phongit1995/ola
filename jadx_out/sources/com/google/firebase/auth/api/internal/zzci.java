package com.google.firebase.auth.api.internal;

import android.os.Parcel;
import com.google.android.gms.common.api.Status;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzci extends com.google.android.gms.internal.firebase_auth.zzb implements zzch {
    public zzci() {
        super("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzb
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        switch (i) {
            case 1:
                zzb((com.google.android.gms.internal.firebase_auth.zzao) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzao.CREATOR));
                return true;
            case 2:
                zza((com.google.android.gms.internal.firebase_auth.zzao) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzao.CREATOR), (com.google.android.gms.internal.firebase_auth.zzaj) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzaj.CREATOR));
                return true;
            case 3:
                zza((com.google.android.gms.internal.firebase_auth.zzx) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzx.CREATOR));
                return true;
            case 4:
                zza((com.google.android.gms.internal.firebase_auth.zzav) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzav.CREATOR));
                return true;
            case 5:
                onFailure((Status) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, Status.CREATOR));
                return true;
            case 6:
                zzac();
                return true;
            case 7:
                zzad();
                return true;
            case 8:
                zzd(parcel.readString());
                return true;
            case 9:
                zze(parcel.readString());
                return true;
            case 10:
                onVerificationCompleted((PhoneAuthCredential) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, PhoneAuthCredential.CREATOR));
                return true;
            case 11:
                zzf(parcel.readString());
                return true;
            case 12:
                zza((Status) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, Status.CREATOR), (PhoneAuthCredential) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, PhoneAuthCredential.CREATOR));
                return true;
            case 13:
                zzae();
                return true;
            default:
                return false;
        }
    }
}

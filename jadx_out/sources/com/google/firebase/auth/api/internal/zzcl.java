package com.google.firebase.auth.api.internal;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.EmailAuthCredential;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzcl extends com.google.android.gms.internal.firebase_auth.zzb implements zzck {
    public zzcl() {
        super("com.google.firebase.auth.api.internal.IFirebaseAuthService");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzb
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        zzch zzcjVar = null;
        switch (i) {
            case 1:
                String string = parcel.readString();
                IBinder strongBinder = parcel.readStrongBinder();
                if (strongBinder != null) {
                    IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface instanceof zzch ? (zzch) iInterfaceQueryLocalInterface : new zzcj(strongBinder);
                }
                zza(string, zzcjVar);
                break;
            case 2:
                String string2 = parcel.readString();
                IBinder strongBinder2 = parcel.readStrongBinder();
                if (strongBinder2 != null) {
                    IInterface iInterfaceQueryLocalInterface2 = strongBinder2.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface2 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface2 : new zzcj(strongBinder2);
                }
                zzb(string2, zzcjVar);
                break;
            case 3:
                com.google.android.gms.internal.firebase_auth.zzbf zzbfVar = (com.google.android.gms.internal.firebase_auth.zzbf) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzbf.CREATOR);
                IBinder strongBinder3 = parcel.readStrongBinder();
                if (strongBinder3 != null) {
                    IInterface iInterfaceQueryLocalInterface3 = strongBinder3.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface3 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface3 : new zzcj(strongBinder3);
                }
                zza(zzbfVar, zzcjVar);
                break;
            case 4:
                String string3 = parcel.readString();
                UserProfileChangeRequest userProfileChangeRequest = (UserProfileChangeRequest) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, UserProfileChangeRequest.CREATOR);
                IBinder strongBinder4 = parcel.readStrongBinder();
                if (strongBinder4 != null) {
                    IInterface iInterfaceQueryLocalInterface4 = strongBinder4.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface4 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface4 : new zzcj(strongBinder4);
                }
                zza(string3, userProfileChangeRequest, zzcjVar);
                break;
            case 5:
                String string4 = parcel.readString();
                String string5 = parcel.readString();
                IBinder strongBinder5 = parcel.readStrongBinder();
                if (strongBinder5 != null) {
                    IInterface iInterfaceQueryLocalInterface5 = strongBinder5.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface5 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface5 : new zzcj(strongBinder5);
                }
                zza(string4, string5, zzcjVar);
                break;
            case 6:
                String string6 = parcel.readString();
                String string7 = parcel.readString();
                IBinder strongBinder6 = parcel.readStrongBinder();
                if (strongBinder6 != null) {
                    IInterface iInterfaceQueryLocalInterface6 = strongBinder6.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface6 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface6 : new zzcj(strongBinder6);
                }
                zzb(string6, string7, zzcjVar);
                break;
            case 7:
                String string8 = parcel.readString();
                String string9 = parcel.readString();
                IBinder strongBinder7 = parcel.readStrongBinder();
                if (strongBinder7 != null) {
                    IInterface iInterfaceQueryLocalInterface7 = strongBinder7.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface7 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface7 : new zzcj(strongBinder7);
                }
                zzc(string8, string9, zzcjVar);
                break;
            case 8:
                String string10 = parcel.readString();
                String string11 = parcel.readString();
                IBinder strongBinder8 = parcel.readStrongBinder();
                if (strongBinder8 != null) {
                    IInterface iInterfaceQueryLocalInterface8 = strongBinder8.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface8 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface8 : new zzcj(strongBinder8);
                }
                zzd(string10, string11, zzcjVar);
                break;
            case 9:
                String string12 = parcel.readString();
                IBinder strongBinder9 = parcel.readStrongBinder();
                if (strongBinder9 != null) {
                    IInterface iInterfaceQueryLocalInterface9 = strongBinder9.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface9 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface9 : new zzcj(strongBinder9);
                }
                zzc(string12, zzcjVar);
                break;
            case 10:
                String string13 = parcel.readString();
                IBinder strongBinder10 = parcel.readStrongBinder();
                if (strongBinder10 != null) {
                    IInterface iInterfaceQueryLocalInterface10 = strongBinder10.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface10 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface10 : new zzcj(strongBinder10);
                }
                zzd(string13, zzcjVar);
                break;
            case 11:
                String string14 = parcel.readString();
                String string15 = parcel.readString();
                String string16 = parcel.readString();
                IBinder strongBinder11 = parcel.readStrongBinder();
                if (strongBinder11 != null) {
                    IInterface iInterfaceQueryLocalInterface11 = strongBinder11.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface11 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface11 : new zzcj(strongBinder11);
                }
                zza(string14, string15, string16, zzcjVar);
                break;
            case 12:
                String string17 = parcel.readString();
                com.google.android.gms.internal.firebase_auth.zzbf zzbfVar2 = (com.google.android.gms.internal.firebase_auth.zzbf) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzbf.CREATOR);
                IBinder strongBinder12 = parcel.readStrongBinder();
                if (strongBinder12 != null) {
                    IInterface iInterfaceQueryLocalInterface12 = strongBinder12.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface12 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface12 : new zzcj(strongBinder12);
                }
                zza(string17, zzbfVar2, zzcjVar);
                break;
            case 13:
                String string18 = parcel.readString();
                IBinder strongBinder13 = parcel.readStrongBinder();
                if (strongBinder13 != null) {
                    IInterface iInterfaceQueryLocalInterface13 = strongBinder13.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface13 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface13 : new zzcj(strongBinder13);
                }
                zze(string18, zzcjVar);
                break;
            case 14:
                String string19 = parcel.readString();
                String string20 = parcel.readString();
                IBinder strongBinder14 = parcel.readStrongBinder();
                if (strongBinder14 != null) {
                    IInterface iInterfaceQueryLocalInterface14 = strongBinder14.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface14 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface14 : new zzcj(strongBinder14);
                }
                zze(string19, string20, zzcjVar);
                break;
            case 15:
                String string21 = parcel.readString();
                IBinder strongBinder15 = parcel.readStrongBinder();
                if (strongBinder15 != null) {
                    IInterface iInterfaceQueryLocalInterface15 = strongBinder15.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface15 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface15 : new zzcj(strongBinder15);
                }
                zzf(string21, zzcjVar);
                break;
            case 16:
                IBinder strongBinder16 = parcel.readStrongBinder();
                if (strongBinder16 != null) {
                    IInterface iInterfaceQueryLocalInterface16 = strongBinder16.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface16 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface16 : new zzcj(strongBinder16);
                }
                zza(zzcjVar);
                break;
            case 17:
                String string22 = parcel.readString();
                IBinder strongBinder17 = parcel.readStrongBinder();
                if (strongBinder17 != null) {
                    IInterface iInterfaceQueryLocalInterface17 = strongBinder17.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface17 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface17 : new zzcj(strongBinder17);
                }
                zzg(string22, zzcjVar);
                break;
            case 18:
                String string23 = parcel.readString();
                IBinder strongBinder18 = parcel.readStrongBinder();
                if (strongBinder18 != null) {
                    IInterface iInterfaceQueryLocalInterface18 = strongBinder18.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface18 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface18 : new zzcj(strongBinder18);
                }
                zzh(string23, zzcjVar);
                break;
            case 19:
                String string24 = parcel.readString();
                IBinder strongBinder19 = parcel.readStrongBinder();
                if (strongBinder19 != null) {
                    IInterface iInterfaceQueryLocalInterface19 = strongBinder19.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface19 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface19 : new zzcj(strongBinder19);
                }
                zzi(string24, zzcjVar);
                break;
            case 20:
                String string25 = parcel.readString();
                IBinder strongBinder20 = parcel.readStrongBinder();
                if (strongBinder20 != null) {
                    IInterface iInterfaceQueryLocalInterface20 = strongBinder20.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface20 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface20 : new zzcj(strongBinder20);
                }
                zzj(string25, zzcjVar);
                break;
            case 21:
                String string26 = parcel.readString();
                String string27 = parcel.readString();
                IBinder strongBinder21 = parcel.readStrongBinder();
                if (strongBinder21 != null) {
                    IInterface iInterfaceQueryLocalInterface21 = strongBinder21.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface21 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface21 : new zzcj(strongBinder21);
                }
                zzf(string26, string27, zzcjVar);
                break;
            case 22:
                com.google.android.gms.internal.firebase_auth.zzax zzaxVar = (com.google.android.gms.internal.firebase_auth.zzax) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, com.google.android.gms.internal.firebase_auth.zzax.CREATOR);
                IBinder strongBinder22 = parcel.readStrongBinder();
                if (strongBinder22 != null) {
                    IInterface iInterfaceQueryLocalInterface22 = strongBinder22.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface22 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface22 : new zzcj(strongBinder22);
                }
                zza(zzaxVar, zzcjVar);
                break;
            case 23:
                PhoneAuthCredential phoneAuthCredential = (PhoneAuthCredential) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, PhoneAuthCredential.CREATOR);
                IBinder strongBinder23 = parcel.readStrongBinder();
                if (strongBinder23 != null) {
                    IInterface iInterfaceQueryLocalInterface23 = strongBinder23.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface23 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface23 : new zzcj(strongBinder23);
                }
                zza(phoneAuthCredential, zzcjVar);
                break;
            case 24:
                String string28 = parcel.readString();
                PhoneAuthCredential phoneAuthCredential2 = (PhoneAuthCredential) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, PhoneAuthCredential.CREATOR);
                IBinder strongBinder24 = parcel.readStrongBinder();
                if (strongBinder24 != null) {
                    IInterface iInterfaceQueryLocalInterface24 = strongBinder24.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface24 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface24 : new zzcj(strongBinder24);
                }
                zza(string28, phoneAuthCredential2, zzcjVar);
                break;
            case 25:
                String string29 = parcel.readString();
                ActionCodeSettings actionCodeSettings = (ActionCodeSettings) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, ActionCodeSettings.CREATOR);
                IBinder strongBinder25 = parcel.readStrongBinder();
                if (strongBinder25 != null) {
                    IInterface iInterfaceQueryLocalInterface25 = strongBinder25.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface25 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface25 : new zzcj(strongBinder25);
                }
                zza(string29, actionCodeSettings, zzcjVar);
                break;
            case 26:
                String string30 = parcel.readString();
                ActionCodeSettings actionCodeSettings2 = (ActionCodeSettings) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, ActionCodeSettings.CREATOR);
                IBinder strongBinder26 = parcel.readStrongBinder();
                if (strongBinder26 != null) {
                    IInterface iInterfaceQueryLocalInterface26 = strongBinder26.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface26 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface26 : new zzcj(strongBinder26);
                }
                zzb(string30, actionCodeSettings2, zzcjVar);
                break;
            case 27:
                String string31 = parcel.readString();
                IBinder strongBinder27 = parcel.readStrongBinder();
                if (strongBinder27 != null) {
                    IInterface iInterfaceQueryLocalInterface27 = strongBinder27.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface27 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface27 : new zzcj(strongBinder27);
                }
                zzk(string31, zzcjVar);
                break;
            case 28:
                String string32 = parcel.readString();
                ActionCodeSettings actionCodeSettings3 = (ActionCodeSettings) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, ActionCodeSettings.CREATOR);
                IBinder strongBinder28 = parcel.readStrongBinder();
                if (strongBinder28 != null) {
                    IInterface iInterfaceQueryLocalInterface28 = strongBinder28.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface28 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface28 : new zzcj(strongBinder28);
                }
                zzc(string32, actionCodeSettings3, zzcjVar);
                break;
            case 29:
                EmailAuthCredential emailAuthCredential = (EmailAuthCredential) com.google.android.gms.internal.firebase_auth.zzc.zza(parcel, EmailAuthCredential.CREATOR);
                IBinder strongBinder29 = parcel.readStrongBinder();
                if (strongBinder29 != null) {
                    IInterface iInterfaceQueryLocalInterface29 = strongBinder29.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks");
                    zzcjVar = iInterfaceQueryLocalInterface29 instanceof zzch ? (zzch) iInterfaceQueryLocalInterface29 : new zzcj(strongBinder29);
                }
                zza(emailAuthCredential, zzcjVar);
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}

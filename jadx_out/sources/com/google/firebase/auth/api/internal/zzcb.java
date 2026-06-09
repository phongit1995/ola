package com.google.firebase.auth.api.internal;

import android.os.RemoteException;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcb {
    private final Logger zzdx;
    private final zzch zzhh;

    public zzcb(@NonNull zzch zzchVar, @NonNull Logger logger) {
        this.zzhh = (zzch) Preconditions.checkNotNull(zzchVar);
        this.zzdx = (Logger) Preconditions.checkNotNull(logger);
    }

    public final void onFailure(@NonNull Status status) {
        try {
            this.zzhh.onFailure(status);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending failure result.", e, new Object[0]);
        }
    }

    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull com.google.android.gms.internal.firebase_auth.zzaj zzajVar) {
        try {
            this.zzhh.zza(zzaoVar, zzajVar);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending get token and account info user response", e, new Object[0]);
        }
    }

    public final void zza(@Nullable com.google.android.gms.internal.firebase_auth.zzav zzavVar) {
        try {
            this.zzhh.zza(zzavVar);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending password reset response.", e, new Object[0]);
        }
    }

    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzx zzxVar) {
        try {
            this.zzhh.zza(zzxVar);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending create auth uri response.", e, new Object[0]);
        }
    }

    public final void zzac() {
        try {
            this.zzhh.zzac();
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending delete account response.", e, new Object[0]);
        }
    }

    public final void zzad() {
        try {
            this.zzhh.zzad();
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending email verification response.", e, new Object[0]);
        }
    }

    public final void zzae() {
        try {
            this.zzhh.zzae();
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when setting FirebaseUI Version", e, new Object[0]);
        }
    }

    public final void zzb(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        try {
            this.zzhh.zzb(zzaoVar);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending token result.", e, new Object[0]);
        }
    }

    public final void zzd(@NonNull String str) {
        try {
            this.zzhh.zzd(str);
        } catch (RemoteException e) {
            this.zzdx.e("RemoteException when sending set account info response.", e, new Object[0]);
        }
    }
}

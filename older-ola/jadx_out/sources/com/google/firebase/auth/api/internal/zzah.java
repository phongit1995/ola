package com.google.firebase.auth.api.internal;

import android.support.annotation.GuardedBy;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseError;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzah {
    private static Logger zzdx = new Logger("BiChannelGoogleApi", "FirebaseAuth: ");

    @GuardedBy("this")
    private zzai zzgj;

    private final GoogleApi zzc(zzam zzamVar) {
        zzai zzaiVarZzx = zzx();
        if (zzaiVarZzx.zzgm.zzd(zzamVar)) {
            Logger logger = zzdx;
            String strValueOf = String.valueOf(zzaiVarZzx.zzgl);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 43);
            sb.append("getGoogleApiForMethod() returned Fallback: ");
            sb.append(strValueOf);
            logger.w(sb.toString(), new Object[0]);
            return zzaiVarZzx.zzgl;
        }
        Logger logger2 = zzdx;
        String strValueOf2 = String.valueOf(zzaiVarZzx.zzgk);
        StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 38);
        sb2.append("getGoogleApiForMethod() returned Gms: ");
        sb2.append(strValueOf2);
        logger2.w(sb2.toString(), new Object[0]);
        return zzaiVarZzx.zzgk;
    }

    private final zzai zzx() {
        zzai zzaiVar;
        synchronized (this) {
            if (this.zzgj == null) {
                this.zzgj = zzw();
            }
            zzaiVar = this.zzgj;
        }
        return zzaiVar;
    }

    public final <TResult, A extends Api.AnyClient> Task<TResult> zza(zzam<A, TResult> zzamVar) {
        GoogleApi googleApiZzc = zzc(zzamVar);
        return googleApiZzc == null ? Tasks.forException(zzce.zzb(new Status(FirebaseError.ERROR_INTERNAL_ERROR, "Unable to connect to GoogleApi instance - Google Play Services may be unavailable"))) : googleApiZzc.doRead(zzamVar);
    }

    public final <TResult, A extends Api.AnyClient> Task<TResult> zzb(zzam<A, TResult> zzamVar) {
        GoogleApi googleApiZzc = zzc(zzamVar);
        return googleApiZzc == null ? Tasks.forException(zzce.zzb(new Status(FirebaseError.ERROR_INTERNAL_ERROR, "Unable to connect to GoogleApi instance - Google Play Services may be unavailable"))) : googleApiZzc.doWrite(zzamVar);
    }

    abstract zzai zzw();
}

package com.google.firebase.iid;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.VisibleForTesting;
import android.util.Log;
import com.google.android.gms.tasks.Task;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes2.dex */
public final class zzv {

    @GuardedBy("MessengerIpcClient.class")
    private static zzv zzbm;
    private final ScheduledExecutorService zzbn;

    @GuardedBy("this")
    private zzx zzbo = new zzx(this);

    @GuardedBy("this")
    private int zzbp = 1;
    private final Context zzz;

    @VisibleForTesting
    private zzv(Context context, ScheduledExecutorService scheduledExecutorService) {
        this.zzbn = scheduledExecutorService;
        this.zzz = context.getApplicationContext();
    }

    private final synchronized <T> Task<T> zza(zzae<T> zzaeVar) {
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            String strValueOf = String.valueOf(zzaeVar);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 9);
            sb.append("Queueing ");
            sb.append(strValueOf);
            Log.d("MessengerIpcClient", sb.toString());
        }
        if (!this.zzbo.zzb(zzaeVar)) {
            this.zzbo = new zzx(this);
            this.zzbo.zzb(zzaeVar);
        }
        return zzaeVar.zzbz.getTask();
    }

    public static synchronized zzv zzc(Context context) {
        if (zzbm == null) {
            zzbm = new zzv(context, Executors.newSingleThreadScheduledExecutor());
        }
        return zzbm;
    }

    private final synchronized int zzr() {
        int i;
        i = this.zzbp;
        this.zzbp = i + 1;
        return i;
    }

    public final Task<Void> zza(int i, Bundle bundle) {
        return zza(new zzad(zzr(), 2, bundle));
    }

    public final Task<Bundle> zzb(int i, Bundle bundle) {
        return zza(new zzag(zzr(), 1, bundle));
    }
}

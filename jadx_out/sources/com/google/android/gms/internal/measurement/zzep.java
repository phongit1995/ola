package com.google.android.gms.internal.measurement;

import android.os.Handler;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzep {
    private static volatile Handler handler;
    private final zzhk zzagz;
    private final Runnable zzyc;
    private volatile long zzyd;

    zzep(zzhk zzhkVar) {
        Preconditions.checkNotNull(zzhkVar);
        this.zzagz = zzhkVar;
        this.zzyc = new zzeq(this, zzhkVar);
    }

    private final Handler getHandler() {
        Handler handler2;
        if (handler != null) {
            return handler;
        }
        synchronized (zzep.class) {
            if (handler == null) {
                handler = new Handler(this.zzagz.getContext().getMainLooper());
            }
            handler2 = handler;
        }
        return handler2;
    }

    static /* synthetic */ long zza(zzep zzepVar, long j) {
        zzepVar.zzyd = 0L;
        return 0L;
    }

    final void cancel() {
        this.zzyd = 0L;
        getHandler().removeCallbacks(this.zzyc);
    }

    public abstract void run();

    public final boolean zzef() {
        return this.zzyd != 0;
    }

    public final void zzh(long j) {
        cancel();
        if (j >= 0) {
            this.zzyd = this.zzagz.zzbt().currentTimeMillis();
            if (getHandler().postDelayed(this.zzyc, j)) {
                return;
            }
            this.zzagz.zzgi().zziv().zzg("Failed to schedule delayed post. time", Long.valueOf(j));
        }
    }
}

package com.google.firebase.auth.internal;

import android.os.Handler;
import android.os.HandlerThread;
import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.common.util.DefaultClock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseApp;

/* JADX INFO: loaded from: classes2.dex */
public final class zzs {
    private static Logger zzdx = new Logger("TokenRefresher", "FirebaseAuth:");

    @VisibleForTesting
    private Handler handler;
    private final FirebaseApp zzeb;

    @VisibleForTesting
    volatile long zzlh;

    @VisibleForTesting
    volatile long zzli;

    @VisibleForTesting
    private long zzlj;

    @VisibleForTesting
    private HandlerThread zzlk;

    @VisibleForTesting
    private Runnable zzll;

    public zzs(@NonNull FirebaseApp firebaseApp) {
        zzdx.v("Initializing TokenRefresher", new Object[0]);
        this.zzeb = (FirebaseApp) Preconditions.checkNotNull(firebaseApp);
        this.zzlk = new HandlerThread("TokenRefresher", 10);
        this.zzlk.start();
        this.handler = new Handler(this.zzlk.getLooper());
        this.zzll = new zzt(this, this.zzeb.getName());
        this.zzlj = 300000L;
    }

    public final void cancel() {
        this.handler.removeCallbacks(this.zzll);
    }

    public final void zzbi() {
        Logger logger = zzdx;
        long j = this.zzlh - this.zzlj;
        StringBuilder sb = new StringBuilder(43);
        sb.append("Scheduling refresh for ");
        sb.append(j);
        logger.v(sb.toString(), new Object[0]);
        cancel();
        this.zzli = Math.max((this.zzlh - DefaultClock.getInstance().currentTimeMillis()) - this.zzlj, 0L) / 1000;
        this.handler.postDelayed(this.zzll, this.zzli * 1000);
    }

    final void zzbj() {
        int i = (int) this.zzli;
        this.zzli = (i == 30 || i == 60 || i == 120 || i == 240 || i == 480) ? 2 * this.zzli : i != 960 ? 30L : 960L;
        this.zzlh = DefaultClock.getInstance().currentTimeMillis() + (this.zzli * 1000);
        Logger logger = zzdx;
        long j = this.zzlh;
        StringBuilder sb = new StringBuilder(43);
        sb.append("Scheduling refresh for ");
        sb.append(j);
        logger.v(sb.toString(), new Object[0]);
        this.handler.postDelayed(this.zzll, this.zzli * 1000);
    }
}

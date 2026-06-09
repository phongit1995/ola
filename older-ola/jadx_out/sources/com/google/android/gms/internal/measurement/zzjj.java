package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
public final class zzjj extends zzdz {
    private Handler handler;

    @VisibleForTesting
    private long zzarl;
    private final zzep zzarm;
    private final zzep zzarn;

    zzjj(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzarm = new zzjk(this, this.zzacv);
        this.zzarn = new zzjl(this, this.zzacv);
        this.zzarl = zzbt().elapsedRealtime();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzak(long j) {
        zzep zzepVar;
        long j2;
        zzab();
        zzku();
        this.zzarm.cancel();
        this.zzarn.cancel();
        zzgi().zzjc().zzg("Activity resumed, time", Long.valueOf(j));
        this.zzarl = j;
        if (zzbt().currentTimeMillis() - zzgj().zzami.get() > zzgj().zzamk.get()) {
            zzgj().zzamj.set(true);
            zzgj().zzaml.set(0L);
        }
        if (zzgj().zzamj.get()) {
            zzepVar = this.zzarm;
            j2 = zzgj().zzamh.get();
        } else {
            zzepVar = this.zzarn;
            j2 = 3600000;
        }
        zzepVar.zzh(Math.max(0L, j2 - zzgj().zzaml.get()));
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzal(long j) {
        zzab();
        zzku();
        this.zzarm.cancel();
        this.zzarn.cancel();
        zzgi().zzjc().zzg("Activity paused, time", Long.valueOf(j));
        if (this.zzarl != 0) {
            zzgj().zzaml.set(zzgj().zzaml.get() + (j - this.zzarl));
        }
    }

    private final void zzku() {
        synchronized (this) {
            if (this.handler == null) {
                this.handler = new Handler(Looper.getMainLooper());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzkw() {
        zzab();
        zzl(false);
        zzfx().zzp(zzbt().elapsedRealtime());
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfu() {
        super.zzfu();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfv() {
        super.zzfv();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfw() {
        super.zzfw();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzdu zzfx() {
        return super.zzfx();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzhm zzfy() {
        return super.zzfy();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzfd zzfz() {
        return super.zzfz();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzik zzga() {
        return super.zzga();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzih zzgb() {
        return super.zzgb();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzfe zzgc() {
        return super.zzgc();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzjj zzgd() {
        return super.zzgd();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzer zzge() {
        return super.zzge();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzfg zzgf() {
        return super.zzgf();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzkd zzgg() {
        return super.zzgg();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzgi zzgh() {
        return super.zzgh();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzfi zzgi() {
        return super.zzgi();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzft zzgj() {
        return super.zzgj();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzeh zzgk() {
        return super.zzgk();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzee zzgl() {
        return super.zzgl();
    }

    @Override // com.google.android.gms.internal.measurement.zzdz
    protected final boolean zzgn() {
        return false;
    }

    final void zzkv() {
        this.zzarm.cancel();
        this.zzarn.cancel();
        this.zzarl = 0L;
    }

    @WorkerThread
    public final boolean zzl(boolean z) {
        zzab();
        zzch();
        long jElapsedRealtime = zzbt().elapsedRealtime();
        zzgj().zzamk.set(zzbt().currentTimeMillis());
        long j = jElapsedRealtime - this.zzarl;
        if (!z && j < 1000) {
            zzgi().zzjc().zzg("Screen exposed for less than 1000 ms. Event not sent. time", Long.valueOf(j));
            return false;
        }
        zzgj().zzaml.set(j);
        zzgi().zzjc().zzg("Recording user engagement, ms", Long.valueOf(j));
        Bundle bundle = new Bundle();
        bundle.putLong("_et", j);
        zzih.zza(zzgb().zzkn(), bundle, true);
        zzfy().logEvent("auto", "_e", bundle);
        this.zzarl = jElapsedRealtime;
        this.zzarn.cancel();
        this.zzarn.zzh(Math.max(0L, 3600000 - zzgj().zzaml.get()));
        return true;
    }
}

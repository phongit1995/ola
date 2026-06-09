package com.google.android.gms.internal.measurement;

import android.content.Context;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import java.lang.Thread;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.Semaphore;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgi extends zzhj {
    private static final AtomicLong zzanv = new AtomicLong(Long.MIN_VALUE);
    private ExecutorService executor;
    private zzgm zzanm;
    private zzgm zzann;
    private final PriorityBlockingQueue<zzgl<?>> zzano;
    private final BlockingQueue<zzgl<?>> zzanp;
    private final Thread.UncaughtExceptionHandler zzanq;
    private final Thread.UncaughtExceptionHandler zzanr;
    private final Object zzans;
    private final Semaphore zzant;
    private volatile boolean zzanu;

    zzgi(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzans = new Object();
        this.zzant = new Semaphore(2);
        this.zzano = new PriorityBlockingQueue<>();
        this.zzanp = new LinkedBlockingQueue();
        this.zzanq = new zzgk(this, "Thread death: Uncaught exception on worker thread");
        this.zzanr = new zzgk(this, "Thread death: Uncaught exception on network thread");
    }

    static /* synthetic */ zzgm zza(zzgi zzgiVar, zzgm zzgmVar) {
        zzgiVar.zzanm = null;
        return null;
    }

    private final void zza(zzgl<?> zzglVar) {
        synchronized (this.zzans) {
            this.zzano.add(zzglVar);
            if (this.zzanm == null) {
                this.zzanm = new zzgm(this, "Measurement Worker", this.zzano);
                this.zzanm.setUncaughtExceptionHandler(this.zzanq);
                this.zzanm.start();
            } else {
                this.zzanm.zzjx();
            }
        }
    }

    static /* synthetic */ zzgm zzb(zzgi zzgiVar, zzgm zzgmVar) {
        zzgiVar.zzann = null;
        return null;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    final <T> T zza(AtomicReference<T> atomicReference, long j, String str, Runnable runnable) {
        synchronized (atomicReference) {
            zzgh().zzc(runnable);
            try {
                atomicReference.wait(15000L);
            } catch (InterruptedException unused) {
                zzfk zzfkVarZziy = zzgi().zziy();
                String strValueOf = String.valueOf(str);
                zzfkVarZziy.log(strValueOf.length() != 0 ? "Interrupted waiting for ".concat(strValueOf) : new String("Interrupted waiting for "));
                return null;
            }
        }
        T t = atomicReference.get();
        if (t == null) {
            zzfk zzfkVarZziy2 = zzgi().zziy();
            String strValueOf2 = String.valueOf(str);
            zzfkVarZziy2.log(strValueOf2.length() != 0 ? "Timed out waiting for ".concat(strValueOf2) : new String("Timed out waiting for "));
        }
        return t;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final void zzab() {
        if (Thread.currentThread() != this.zzanm) {
            throw new IllegalStateException("Call expected from worker thread");
        }
    }

    public final <V> Future<V> zzb(Callable<V> callable) {
        zzch();
        Preconditions.checkNotNull(callable);
        zzgl<?> zzglVar = new zzgl<>(this, (Callable<?>) callable, false, "Task exception on worker thread");
        if (Thread.currentThread() != this.zzanm) {
            zza(zzglVar);
            return zzglVar;
        }
        if (!this.zzano.isEmpty()) {
            zzgi().zziy().log("Callable skipped the worker queue.");
        }
        zzglVar.run();
        return zzglVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    public final <V> Future<V> zzc(Callable<V> callable) {
        zzch();
        Preconditions.checkNotNull(callable);
        zzgl<?> zzglVar = new zzgl<>(this, (Callable<?>) callable, true, "Task exception on worker thread");
        if (Thread.currentThread() == this.zzanm) {
            zzglVar.run();
            return zzglVar;
        }
        zza(zzglVar);
        return zzglVar;
    }

    public final void zzc(Runnable runnable) {
        zzch();
        Preconditions.checkNotNull(runnable);
        zza(new zzgl<>(this, runnable, false, "Task exception on worker thread"));
    }

    public final void zzd(Runnable runnable) {
        zzch();
        Preconditions.checkNotNull(runnable);
        zzgl<?> zzglVar = new zzgl<>(this, runnable, false, "Task exception on network thread");
        synchronized (this.zzans) {
            this.zzanp.add(zzglVar);
            if (this.zzann == null) {
                this.zzann = new zzgm(this, "Measurement Network", this.zzanp);
                this.zzann.setUncaughtExceptionHandler(this.zzanr);
                this.zzann.start();
            } else {
                this.zzann.zzjx();
            }
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfu() {
        super.zzfu();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfv() {
        super.zzfv();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final void zzfw() {
        if (Thread.currentThread() != this.zzann) {
            throw new IllegalStateException("Call expected from network thread");
        }
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

    @Override // com.google.android.gms.internal.measurement.zzhj
    protected final boolean zzgn() {
        return false;
    }

    public final boolean zzju() {
        return Thread.currentThread() == this.zzanm;
    }

    final ExecutorService zzjv() {
        ExecutorService executorService;
        synchronized (this.zzans) {
            if (this.executor == null) {
                this.executor = new ThreadPoolExecutor(0, 1, 30L, TimeUnit.SECONDS, new ArrayBlockingQueue(100));
            }
            executorService = this.executor;
        }
        return executorService;
    }
}

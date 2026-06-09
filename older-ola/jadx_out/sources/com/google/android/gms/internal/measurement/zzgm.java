package com.google.android.gms.internal.measurement;

import android.os.Process;
import com.google.android.gms.common.internal.Preconditions;
import java.util.concurrent.BlockingQueue;

/* JADX INFO: loaded from: classes2.dex */
final class zzgm extends Thread {
    private final /* synthetic */ zzgi zzanx;
    private final Object zzaoa;
    private final BlockingQueue<zzgl<?>> zzaob;

    public zzgm(zzgi zzgiVar, String str, BlockingQueue<zzgl<?>> blockingQueue) {
        this.zzanx = zzgiVar;
        Preconditions.checkNotNull(str);
        Preconditions.checkNotNull(blockingQueue);
        this.zzaoa = new Object();
        this.zzaob = blockingQueue;
        setName(str);
    }

    private final void zza(InterruptedException interruptedException) {
        this.zzanx.zzgi().zziy().zzg(String.valueOf(getName()).concat(" was interrupted"), interruptedException);
    }

    @Override // java.lang.Thread, java.lang.Runnable
    public final void run() {
        boolean z = false;
        while (!z) {
            try {
                this.zzanx.zzant.acquire();
                z = true;
            } catch (InterruptedException e) {
                zza(e);
            }
        }
        try {
            int threadPriority = Process.getThreadPriority(Process.myTid());
            while (true) {
                zzgl<?> zzglVarPoll = this.zzaob.poll();
                if (zzglVarPoll == null) {
                    synchronized (this.zzaoa) {
                        if (this.zzaob.peek() == null && !this.zzanx.zzanu) {
                            try {
                                this.zzaoa.wait(30000L);
                            } catch (InterruptedException e2) {
                                zza(e2);
                            }
                        }
                    }
                    synchronized (this.zzanx.zzans) {
                        if (this.zzaob.peek() == null) {
                            break;
                        }
                    }
                } else {
                    Process.setThreadPriority(zzglVarPoll.zzanz ? threadPriority : 10);
                    zzglVarPoll.run();
                }
            }
            synchronized (this.zzanx.zzans) {
                this.zzanx.zzant.release();
                this.zzanx.zzans.notifyAll();
                if (this == this.zzanx.zzanm) {
                    zzgi.zza(this.zzanx, null);
                } else if (this == this.zzanx.zzann) {
                    zzgi.zzb(this.zzanx, null);
                } else {
                    this.zzanx.zzgi().zziv().log("Current scheduler thread is neither worker nor network");
                }
            }
        } catch (Throwable th) {
            synchronized (this.zzanx.zzans) {
                this.zzanx.zzant.release();
                this.zzanx.zzans.notifyAll();
                if (this == this.zzanx.zzanm) {
                    zzgi.zza(this.zzanx, null);
                } else if (this == this.zzanx.zzann) {
                    zzgi.zzb(this.zzanx, null);
                } else {
                    this.zzanx.zzgi().zziv().log("Current scheduler thread is neither worker nor network");
                }
                throw th;
            }
        }
    }

    public final void zzjx() {
        synchronized (this.zzaoa) {
            this.zzaoa.notifyAll();
        }
    }
}

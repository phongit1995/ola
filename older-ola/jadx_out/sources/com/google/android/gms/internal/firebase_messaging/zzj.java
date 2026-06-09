package com.google.android.gms.internal.firebase_messaging;

import java.lang.ref.Reference;
import java.lang.ref.ReferenceQueue;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;

/* JADX INFO: loaded from: classes2.dex */
final class zzj {
    private final ConcurrentHashMap<zzk, List<Throwable>> zzh = new ConcurrentHashMap<>(16, 0.75f, 10);
    private final ReferenceQueue<Throwable> zzi = new ReferenceQueue<>();

    zzj() {
    }

    public final List<Throwable> zza(Throwable th, boolean z) {
        while (true) {
            Reference<? extends Throwable> referencePoll = this.zzi.poll();
            if (referencePoll == null) {
                break;
            }
            this.zzh.remove(referencePoll);
        }
        List<Throwable> list = this.zzh.get(new zzk(th, null));
        if (list != null) {
            return list;
        }
        Vector vector = new Vector(2);
        List<Throwable> listPutIfAbsent = this.zzh.putIfAbsent(new zzk(th, this.zzi), vector);
        return listPutIfAbsent == null ? vector : listPutIfAbsent;
    }
}

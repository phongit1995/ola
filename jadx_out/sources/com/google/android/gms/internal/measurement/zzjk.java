package com.google.android.gms.internal.measurement;

import android.os.Bundle;
import android.support.annotation.WorkerThread;

/* JADX INFO: loaded from: classes2.dex */
final class zzjk extends zzep {
    private final /* synthetic */ zzjj zzaro;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzjk(zzjj zzjjVar, zzhk zzhkVar) {
        super(zzhkVar);
        this.zzaro = zzjjVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzep
    @WorkerThread
    public final void run() {
        zzjj zzjjVar = this.zzaro;
        zzjjVar.zzab();
        zzjjVar.zzgi().zzjc().zzg("Session started, time", Long.valueOf(zzjjVar.zzbt().elapsedRealtime()));
        zzjjVar.zzgj().zzamj.set(false);
        zzjjVar.zzfy().zza("auto", "_s", new Bundle());
        zzjjVar.zzgj().zzamk.set(zzjjVar.zzbt().currentTimeMillis());
    }
}

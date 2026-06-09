package com.google.android.gms.internal.measurement;

import android.support.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
@WorkerThread
final class zzfp implements Runnable {
    private final String packageName;
    private final int status;
    private final zzfo zzalg;
    private final Throwable zzalh;
    private final byte[] zzali;
    private final Map<String, List<String>> zzalj;

    private zzfp(String str, zzfo zzfoVar, int i, Throwable th, byte[] bArr, Map<String, List<String>> map) {
        Preconditions.checkNotNull(zzfoVar);
        this.zzalg = zzfoVar;
        this.status = i;
        this.zzalh = th;
        this.zzali = bArr;
        this.packageName = str;
        this.zzalj = map;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzalg.zza(this.packageName, this.status, this.zzalh, this.zzali, this.zzalj);
    }
}

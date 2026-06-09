package com.google.android.gms.internal.measurement;

import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes2.dex */
final class zzhq implements Callable<String> {
    private final /* synthetic */ zzhm zzaps;

    zzhq(zzhm zzhmVar) {
        this.zzaps = zzhmVar;
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0067  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x006d  */
    @Override // java.util.concurrent.Callable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final /* synthetic */ java.lang.String call() throws java.util.concurrent.TimeoutException {
        /*
            r10 = this;
            com.google.android.gms.internal.measurement.zzhm r0 = r10.zzaps
            com.google.android.gms.internal.measurement.zzft r0 = r0.zzgj()
            java.lang.String r0 = r0.zzjk()
            if (r0 == 0) goto Ld
            return r0
        Ld:
            com.google.android.gms.internal.measurement.zzhm r0 = r10.zzaps
            com.google.android.gms.internal.measurement.zzhm r0 = r0.zzfy()
            com.google.android.gms.internal.measurement.zzgi r1 = r0.zzgh()
            boolean r1 = r1.zzju()
            r2 = 0
            if (r1 == 0) goto L2c
            com.google.android.gms.internal.measurement.zzfi r0 = r0.zzgi()
            com.google.android.gms.internal.measurement.zzfk r0 = r0.zziv()
            java.lang.String r1 = "Cannot retrieve app instance id from analytics worker thread"
        L28:
            r0.log(r1)
            goto L65
        L2c:
            boolean r1 = com.google.android.gms.internal.measurement.zzee.isMainThread()
            if (r1 == 0) goto L3d
            com.google.android.gms.internal.measurement.zzfi r0 = r0.zzgi()
            com.google.android.gms.internal.measurement.zzfk r0 = r0.zziv()
            java.lang.String r1 = "Cannot retrieve app instance id from main thread"
            goto L28
        L3d:
            com.google.android.gms.common.util.Clock r1 = r0.zzbt()
            long r1 = r1.elapsedRealtime()
            r3 = 120000(0x1d4c0, double:5.9288E-319)
            java.lang.String r5 = r0.zzaj(r3)
            com.google.android.gms.common.util.Clock r6 = r0.zzbt()
            long r6 = r6.elapsedRealtime()
            long r8 = r6 - r1
            if (r5 != 0) goto L64
            int r1 = (r8 > r3 ? 1 : (r8 == r3 ? 0 : -1))
            if (r1 >= 0) goto L64
            long r1 = r3 - r8
            java.lang.String r0 = r0.zzaj(r1)
            r2 = r0
            goto L65
        L64:
            r2 = r5
        L65:
            if (r2 != 0) goto L6d
            java.util.concurrent.TimeoutException r0 = new java.util.concurrent.TimeoutException
            r0.<init>()
            throw r0
        L6d:
            com.google.android.gms.internal.measurement.zzhm r0 = r10.zzaps
            com.google.android.gms.internal.measurement.zzft r0 = r0.zzgj()
            r0.zzbu(r2)
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzhq.call():java.lang.Object");
    }
}

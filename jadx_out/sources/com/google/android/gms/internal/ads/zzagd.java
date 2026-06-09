package com.google.android.gms.internal.ads;

import android.content.Context;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
final class zzagd implements Callable<zzaga> {
    private final /* synthetic */ Context val$context;
    private final /* synthetic */ zzagc zzckk;

    zzagd(zzagc zzagcVar, Context context) {
        this.zzckk = zzagcVar;
        this.val$context = context;
    }

    /* JADX WARN: Removed duplicated region for block: B:12:0x0055  */
    @Override // java.util.concurrent.Callable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final /* synthetic */ com.google.android.gms.internal.ads.zzaga call() {
        /*
            r7 = this;
            com.google.android.gms.internal.ads.zzagc r0 = r7.zzckk
            java.util.WeakHashMap r0 = com.google.android.gms.internal.ads.zzagc.zza(r0)
            android.content.Context r1 = r7.val$context
            java.lang.Object r0 = r0.get(r1)
            com.google.android.gms.internal.ads.zzage r0 = (com.google.android.gms.internal.ads.zzage) r0
            if (r0 == 0) goto L55
            long r1 = r0.zzckl
            com.google.android.gms.internal.ads.zzna<java.lang.Long> r3 = com.google.android.gms.internal.ads.zznk.zzazw
            com.google.android.gms.internal.ads.zzni r4 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r3 = r4.zzd(r3)
            java.lang.Long r3 = (java.lang.Long) r3
            long r3 = r3.longValue()
            long r5 = r1 + r3
            com.google.android.gms.common.util.Clock r1 = com.google.android.gms.ads.internal.zzbv.zzer()
            long r1 = r1.currentTimeMillis()
            int r3 = (r5 > r1 ? 1 : (r5 == r1 ? 0 : -1))
            if (r3 >= 0) goto L32
            r1 = 1
            goto L33
        L32:
            r1 = 0
        L33:
            if (r1 != 0) goto L55
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r1 = com.google.android.gms.internal.ads.zznk.zzazv
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r1 = r2.zzd(r1)
            java.lang.Boolean r1 = (java.lang.Boolean) r1
            boolean r1 = r1.booleanValue()
            if (r1 == 0) goto L55
            com.google.android.gms.internal.ads.zzagb r1 = new com.google.android.gms.internal.ads.zzagb
            android.content.Context r2 = r7.val$context
            com.google.android.gms.internal.ads.zzaga r0 = r0.zzckm
            r1.<init>(r2, r0)
            com.google.android.gms.internal.ads.zzaga r0 = r1.zzoo()
            goto L60
        L55:
            com.google.android.gms.internal.ads.zzagb r0 = new com.google.android.gms.internal.ads.zzagb
            android.content.Context r1 = r7.val$context
            r0.<init>(r1)
            com.google.android.gms.internal.ads.zzaga r0 = r0.zzoo()
        L60:
            com.google.android.gms.internal.ads.zzagc r1 = r7.zzckk
            java.util.WeakHashMap r1 = com.google.android.gms.internal.ads.zzagc.zza(r1)
            android.content.Context r2 = r7.val$context
            com.google.android.gms.internal.ads.zzage r3 = new com.google.android.gms.internal.ads.zzage
            com.google.android.gms.internal.ads.zzagc r4 = r7.zzckk
            r3.<init>(r4, r0)
            r1.put(r2, r3)
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzagd.call():java.lang.Object");
    }
}

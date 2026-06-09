package com.google.android.gms.internal.ads;

import java.nio.charset.Charset;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/* JADX INFO: loaded from: classes.dex */
public final class zzaum<P> {
    private static final Charset UTF_8 = Charset.forName("UTF-8");
    private ConcurrentMap<String, List<zzaun<P>>> zzdhk = new ConcurrentHashMap();
    private zzaun<P> zzdhl;

    /* JADX WARN: Removed duplicated region for block: B:12:0x0064  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final com.google.android.gms.internal.ads.zzaun<P> zza(P r4, com.google.android.gms.internal.ads.zzaxr.zzb r5) throws java.security.GeneralSecurityException {
        /*
            r3 = this;
            com.google.android.gms.internal.ads.zzaun r0 = new com.google.android.gms.internal.ads.zzaun
            int[] r1 = com.google.android.gms.internal.ads.zzaud.zzdhh
            com.google.android.gms.internal.ads.zzayd r2 = r5.zzzs()
            int r2 = r2.ordinal()
            r1 = r1[r2]
            r2 = 5
            switch(r1) {
                case 1: goto L23;
                case 2: goto L23;
                case 3: goto L1d;
                case 4: goto L1a;
                default: goto L12;
            }
        L12:
            java.security.GeneralSecurityException r4 = new java.security.GeneralSecurityException
            java.lang.String r5 = "unknown output prefix type"
            r4.<init>(r5)
            throw r4
        L1a:
            byte[] r1 = com.google.android.gms.internal.ads.zzauc.zzdhg
            goto L38
        L1d:
            java.nio.ByteBuffer r1 = java.nio.ByteBuffer.allocate(r2)
            r2 = 1
            goto L28
        L23:
            java.nio.ByteBuffer r1 = java.nio.ByteBuffer.allocate(r2)
            r2 = 0
        L28:
            java.nio.ByteBuffer r1 = r1.put(r2)
            int r2 = r5.zzzr()
            java.nio.ByteBuffer r1 = r1.putInt(r2)
            byte[] r1 = r1.array()
        L38:
            com.google.android.gms.internal.ads.zzaxl r2 = r5.zzzq()
            com.google.android.gms.internal.ads.zzayd r5 = r5.zzzs()
            r0.<init>(r4, r1, r2, r5)
            java.util.ArrayList r4 = new java.util.ArrayList
            r4.<init>()
            r4.add(r0)
            java.lang.String r5 = new java.lang.String
            byte[] r1 = r0.zzwj()
            java.nio.charset.Charset r2 = com.google.android.gms.internal.ads.zzaum.UTF_8
            r5.<init>(r1, r2)
            java.util.concurrent.ConcurrentMap<java.lang.String, java.util.List<com.google.android.gms.internal.ads.zzaun<P>>> r1 = r3.zzdhk
            java.util.List r4 = java.util.Collections.unmodifiableList(r4)
            java.lang.Object r4 = r1.put(r5, r4)
            java.util.List r4 = (java.util.List) r4
            if (r4 == 0) goto L78
            java.util.ArrayList r1 = new java.util.ArrayList
            r1.<init>()
            r1.addAll(r4)
            r1.add(r0)
            java.util.concurrent.ConcurrentMap<java.lang.String, java.util.List<com.google.android.gms.internal.ads.zzaun<P>>> r4 = r3.zzdhk
            java.util.List r1 = java.util.Collections.unmodifiableList(r1)
            r4.put(r5, r1)
        L78:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaum.zza(java.lang.Object, com.google.android.gms.internal.ads.zzaxr$zzb):com.google.android.gms.internal.ads.zzaun");
    }

    protected final void zza(zzaun<P> zzaunVar) {
        this.zzdhl = zzaunVar;
    }

    public final zzaun<P> zzwh() {
        return this.zzdhl;
    }
}

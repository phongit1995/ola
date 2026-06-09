package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzbda<T> implements zzbdm<T> {
    private final zzbcu zzdwl;
    private final boolean zzdwm;
    private final zzbee<?, ?> zzdwv;
    private final zzbbd<?> zzdww;

    private zzbda(zzbee<?, ?> zzbeeVar, zzbbd<?> zzbbdVar, zzbcu zzbcuVar) {
        this.zzdwv = zzbeeVar;
        this.zzdwm = zzbbdVar.zzh(zzbcuVar);
        this.zzdww = zzbbdVar;
        this.zzdwl = zzbcuVar;
    }

    static <T> zzbda<T> zza(zzbee<?, ?> zzbeeVar, zzbbd<?> zzbbdVar, zzbcu zzbcuVar) {
        return new zzbda<>(zzbeeVar, zzbbdVar, zzbcuVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final boolean equals(T t, T t2) {
        if (!this.zzdwv.zzac(t).equals(this.zzdwv.zzac(t2))) {
            return false;
        }
        if (this.zzdwm) {
            return this.zzdww.zzm(t).equals(this.zzdww.zzm(t2));
        }
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final int hashCode(T t) {
        int iHashCode = this.zzdwv.zzac(t).hashCode();
        return this.zzdwm ? (iHashCode * 53) + this.zzdww.zzm(t).hashCode() : iHashCode;
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final T newInstance() {
        return (T) this.zzdwl.zzadf().zzadj();
    }

    /* JADX WARN: Removed duplicated region for block: B:49:0x008b A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:53:? A[LOOP:0: B:45:0x000c->B:53:?, LOOP_END, SYNTHETIC] */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r11, com.google.android.gms.internal.ads.zzbdl r12, com.google.android.gms.internal.ads.zzbbb r13) {
        /*
            r10 = this;
            com.google.android.gms.internal.ads.zzbee<?, ?> r0 = r10.zzdwv
            com.google.android.gms.internal.ads.zzbbd<?> r1 = r10.zzdww
            java.lang.Object r2 = r0.zzad(r11)
            com.google.android.gms.internal.ads.zzbbg r3 = r1.zzn(r11)
        Lc:
            int r4 = r12.zzaci()     // Catch: java.lang.Throwable -> L8f
            r5 = 2147483647(0x7fffffff, float:NaN)
            if (r4 != r5) goto L19
            r0.zzf(r11, r2)
            return
        L19:
            int r4 = r12.getTag()     // Catch: java.lang.Throwable -> L8f
            r6 = 11
            if (r4 == r6) goto L3e
            r5 = r4 & 7
            r6 = 2
            if (r5 != r6) goto L39
            com.google.android.gms.internal.ads.zzbcu r5 = r10.zzdwl     // Catch: java.lang.Throwable -> L8f
            int r4 = r4 >>> 3
            java.lang.Object r4 = r1.zza(r13, r5, r4)     // Catch: java.lang.Throwable -> L8f
            if (r4 == 0) goto L34
            r1.zza(r12, r4, r13, r3)     // Catch: java.lang.Throwable -> L8f
            goto L88
        L34:
            boolean r4 = r0.zza(r2, r12)     // Catch: java.lang.Throwable -> L8f
            goto L89
        L39:
            boolean r4 = r12.zzacj()     // Catch: java.lang.Throwable -> L8f
            goto L89
        L3e:
            r4 = 0
            r6 = 0
            r4 = r6
            r7 = 0
        L42:
            int r8 = r12.zzaci()     // Catch: java.lang.Throwable -> L8f
            if (r8 == r5) goto L70
            int r8 = r12.getTag()     // Catch: java.lang.Throwable -> L8f
            r9 = 16
            if (r8 != r9) goto L5b
            int r7 = r12.zzabt()     // Catch: java.lang.Throwable -> L8f
            com.google.android.gms.internal.ads.zzbcu r6 = r10.zzdwl     // Catch: java.lang.Throwable -> L8f
            java.lang.Object r6 = r1.zza(r13, r6, r7)     // Catch: java.lang.Throwable -> L8f
            goto L42
        L5b:
            r9 = 26
            if (r8 != r9) goto L6a
            if (r6 == 0) goto L65
            r1.zza(r12, r6, r13, r3)     // Catch: java.lang.Throwable -> L8f
            goto L42
        L65:
            com.google.android.gms.internal.ads.zzbah r4 = r12.zzabs()     // Catch: java.lang.Throwable -> L8f
            goto L42
        L6a:
            boolean r8 = r12.zzacj()     // Catch: java.lang.Throwable -> L8f
            if (r8 != 0) goto L42
        L70:
            int r5 = r12.getTag()     // Catch: java.lang.Throwable -> L8f
            r8 = 12
            if (r5 == r8) goto L7d
            com.google.android.gms.internal.ads.zzbbu r12 = com.google.android.gms.internal.ads.zzbbu.zzadp()     // Catch: java.lang.Throwable -> L8f
            throw r12     // Catch: java.lang.Throwable -> L8f
        L7d:
            if (r4 == 0) goto L88
            if (r6 == 0) goto L85
            r1.zza(r4, r6, r13, r3)     // Catch: java.lang.Throwable -> L8f
            goto L88
        L85:
            r0.zza(r2, r7, r4)     // Catch: java.lang.Throwable -> L8f
        L88:
            r4 = 1
        L89:
            if (r4 != 0) goto Lc
            r0.zzf(r11, r2)
            return
        L8f:
            r12 = move-exception
            r0.zzf(r11, r2)
            throw r12
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbda.zza(java.lang.Object, com.google.android.gms.internal.ads.zzbdl, com.google.android.gms.internal.ads.zzbbb):void");
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final void zza(T t, zzbey zzbeyVar) {
        int iZzhq;
        Object value;
        for (T t2 : this.zzdww.zzm(t)) {
            zzbbi zzbbiVar = (zzbbi) t2.getKey();
            if (zzbbiVar.zzacz() != zzbex.MESSAGE || zzbbiVar.zzada() || zzbbiVar.zzadb()) {
                throw new IllegalStateException("Found invalid MessageSet item.");
            }
            if (t2 instanceof zzbbz) {
                iZzhq = zzbbiVar.zzhq();
                value = ((zzbbz) t2).zzadv().zzaav();
            } else {
                iZzhq = zzbbiVar.zzhq();
                value = t2.getValue();
            }
            zzbeyVar.zza(iZzhq, value);
        }
        zzbee<?, ?> zzbeeVar = this.zzdwv;
        zzbeeVar.zzc(zzbeeVar.zzac(t), zzbeyVar);
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:16:0x003e. Please report as an issue. */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:24:0x005a  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x0061  */
    /* JADX WARN: Removed duplicated region for block: B:47:0x005f A[SYNTHETIC] */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r7, byte[] r8, int r9, int r10, com.google.android.gms.internal.ads.zzbae r11) throws com.google.android.gms.internal.ads.zzbbu {
        /*
            r6 = this;
            com.google.android.gms.internal.ads.zzbbo r7 = (com.google.android.gms.internal.ads.zzbbo) r7
            com.google.android.gms.internal.ads.zzbef r0 = r7.zzdtt
            com.google.android.gms.internal.ads.zzbef r1 = com.google.android.gms.internal.ads.zzbef.zzagc()
            if (r0 != r1) goto L10
            com.google.android.gms.internal.ads.zzbef r0 = com.google.android.gms.internal.ads.zzbef.zzagd()
            r7.zzdtt = r0
        L10:
            r7 = r0
        L11:
            if (r9 >= r10) goto L69
            int r2 = com.google.android.gms.internal.ads.zzbad.zza(r8, r9, r11)
            int r0 = r11.zzdpl
            r9 = 11
            r1 = 2
            if (r0 == r9) goto L30
            r9 = r0 & 7
            if (r9 != r1) goto L2b
            r1 = r8
            r3 = r10
            r4 = r7
            r5 = r11
            int r9 = com.google.android.gms.internal.ads.zzbad.zza(r0, r1, r2, r3, r4, r5)
            goto L11
        L2b:
            int r9 = com.google.android.gms.internal.ads.zzbad.zza(r0, r8, r2, r10, r11)
            goto L11
        L30:
            r9 = 0
            r0 = 0
        L32:
            if (r2 >= r10) goto L5f
            int r2 = com.google.android.gms.internal.ads.zzbad.zza(r8, r2, r11)
            int r3 = r11.zzdpl
            int r4 = r3 >>> 3
            r5 = r3 & 7
            switch(r4) {
                case 2: goto L4d;
                case 3: goto L42;
                default: goto L41;
            }
        L41:
            goto L56
        L42:
            if (r5 != r1) goto L56
            int r2 = com.google.android.gms.internal.ads.zzbad.zze(r8, r2, r11)
            java.lang.Object r0 = r11.zzdpn
            com.google.android.gms.internal.ads.zzbah r0 = (com.google.android.gms.internal.ads.zzbah) r0
            goto L32
        L4d:
            if (r5 != 0) goto L56
            int r2 = com.google.android.gms.internal.ads.zzbad.zza(r8, r2, r11)
            int r9 = r11.zzdpl
            goto L32
        L56:
            r4 = 12
            if (r3 == r4) goto L5f
            int r2 = com.google.android.gms.internal.ads.zzbad.zza(r3, r8, r2, r10, r11)
            goto L32
        L5f:
            if (r0 == 0) goto L67
            int r9 = r9 << 3
            r9 = r9 | r1
            r7.zzb(r9, r0)
        L67:
            r9 = r2
            goto L11
        L69:
            if (r9 == r10) goto L70
            com.google.android.gms.internal.ads.zzbbu r7 = com.google.android.gms.internal.ads.zzbbu.zzadr()
            throw r7
        L70:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbda.zza(java.lang.Object, byte[], int, int, com.google.android.gms.internal.ads.zzbae):void");
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final boolean zzaa(T t) {
        return this.zzdww.zzm(t).isInitialized();
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final void zzc(T t, T t2) {
        zzbdo.zza(this.zzdwv, t, t2);
        if (this.zzdwm) {
            zzbdo.zza(this.zzdww, t, t2);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final void zzo(T t) {
        this.zzdwv.zzo(t);
        this.zzdww.zzo(t);
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final int zzy(T t) {
        zzbee<?, ?> zzbeeVar = this.zzdwv;
        int iZzae = zzbeeVar.zzae(zzbeeVar.zzac(t)) + 0;
        return this.zzdwm ? iZzae + this.zzdww.zzm(t).zzacx() : iZzae;
    }
}

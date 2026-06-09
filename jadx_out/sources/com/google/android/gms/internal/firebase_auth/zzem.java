package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzem<T> implements zzev<T> {
    private final zzeh zzto;
    private final boolean zztp;
    private final zzfp<?, ?> zzty;
    private final zzcp<?> zztz;

    private zzem(zzfp<?, ?> zzfpVar, zzcp<?> zzcpVar, zzeh zzehVar) {
        this.zzty = zzfpVar;
        this.zztp = zzcpVar.zze(zzehVar);
        this.zztz = zzcpVar;
        this.zzto = zzehVar;
    }

    static <T> zzem<T> zza(zzfp<?, ?> zzfpVar, zzcp<?> zzcpVar, zzeh zzehVar) {
        return new zzem<>(zzfpVar, zzcpVar, zzehVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final boolean equals(T t, T t2) {
        if (!this.zzty.zzr(t).equals(this.zzty.zzr(t2))) {
            return false;
        }
        if (this.zztp) {
            return this.zztz.zzc(t).equals(this.zztz.zzc(t2));
        }
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final int hashCode(T t) {
        int iHashCode = this.zzty.zzr(t).hashCode();
        return this.zztp ? (iHashCode * 53) + this.zztz.zzc(t).hashCode() : iHashCode;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final T newInstance() {
        return (T) this.zzto.zzea().zzec();
    }

    /* JADX WARN: Removed duplicated region for block: B:49:0x008b A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:53:? A[LOOP:0: B:45:0x000c->B:53:?, LOOP_END, SYNTHETIC] */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r11, com.google.android.gms.internal.firebase_auth.zzeu r12, com.google.android.gms.internal.firebase_auth.zzco r13) {
        /*
            r10 = this;
            com.google.android.gms.internal.firebase_auth.zzfp<?, ?> r0 = r10.zzty
            com.google.android.gms.internal.firebase_auth.zzcp<?> r1 = r10.zztz
            java.lang.Object r2 = r0.zzs(r11)
            com.google.android.gms.internal.firebase_auth.zzcs r3 = r1.zzd(r11)
        Lc:
            int r4 = r12.zzda()     // Catch: java.lang.Throwable -> L8f
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
            com.google.android.gms.internal.firebase_auth.zzeh r5 = r10.zzto     // Catch: java.lang.Throwable -> L8f
            int r4 = r4 >>> 3
            java.lang.Object r4 = r1.zza(r13, r5, r4)     // Catch: java.lang.Throwable -> L8f
            if (r4 == 0) goto L34
            r1.zza(r12, r4, r13, r3)     // Catch: java.lang.Throwable -> L8f
            goto L88
        L34:
            boolean r4 = r0.zza(r2, r12)     // Catch: java.lang.Throwable -> L8f
            goto L89
        L39:
            boolean r4 = r12.zzdb()     // Catch: java.lang.Throwable -> L8f
            goto L89
        L3e:
            r4 = 0
            r6 = 0
            r4 = r6
            r7 = 0
        L42:
            int r8 = r12.zzda()     // Catch: java.lang.Throwable -> L8f
            if (r8 == r5) goto L70
            int r8 = r12.getTag()     // Catch: java.lang.Throwable -> L8f
            r9 = 16
            if (r8 != r9) goto L5b
            int r7 = r12.zzcl()     // Catch: java.lang.Throwable -> L8f
            com.google.android.gms.internal.firebase_auth.zzeh r6 = r10.zzto     // Catch: java.lang.Throwable -> L8f
            java.lang.Object r6 = r1.zza(r13, r6, r7)     // Catch: java.lang.Throwable -> L8f
            goto L42
        L5b:
            r9 = 26
            if (r8 != r9) goto L6a
            if (r6 == 0) goto L65
            r1.zza(r12, r6, r13, r3)     // Catch: java.lang.Throwable -> L8f
            goto L42
        L65:
            com.google.android.gms.internal.firebase_auth.zzbu r4 = r12.zzck()     // Catch: java.lang.Throwable -> L8f
            goto L42
        L6a:
            boolean r8 = r12.zzdb()     // Catch: java.lang.Throwable -> L8f
            if (r8 != 0) goto L42
        L70:
            int r5 = r12.getTag()     // Catch: java.lang.Throwable -> L8f
            r8 = 12
            if (r5 == r8) goto L7d
            com.google.android.gms.internal.firebase_auth.zzdh r12 = com.google.android.gms.internal.firebase_auth.zzdh.zzeh()     // Catch: java.lang.Throwable -> L8f
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
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzem.zza(java.lang.Object, com.google.android.gms.internal.firebase_auth.zzeu, com.google.android.gms.internal.firebase_auth.zzco):void");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final void zza(T t, zzgj zzgjVar) {
        int iZzds;
        Object value;
        for (T t2 : this.zztz.zzc(t)) {
            zzcu zzcuVar = (zzcu) t2.getKey();
            if (zzcuVar.zzdu() != zzgi.MESSAGE || zzcuVar.zzdv() || zzcuVar.zzdw()) {
                throw new IllegalStateException("Found invalid MessageSet item.");
            }
            if (t2 instanceof zzdm) {
                iZzds = zzcuVar.zzds();
                value = ((zzdm) t2).zzen().zzbo();
            } else {
                iZzds = zzcuVar.zzds();
                value = t2.getValue();
            }
            zzgjVar.zza(iZzds, value);
        }
        zzfp<?, ?> zzfpVar = this.zzty;
        zzfpVar.zzc(zzfpVar.zzr(t), zzgjVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final void zzc(T t, T t2) {
        zzex.zza(this.zzty, t, t2);
        if (this.zztp) {
            zzex.zza(this.zztz, t, t2);
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final void zze(T t) {
        this.zzty.zze(t);
        this.zztz.zze(t);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final int zzo(T t) {
        zzfp<?, ?> zzfpVar = this.zzty;
        int iZzt = zzfpVar.zzt(zzfpVar.zzr(t)) + 0;
        return this.zztp ? iZzt + this.zztz.zzc(t).zzdr() : iZzt;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final boolean zzp(T t) {
        return this.zztz.zzc(t).isInitialized();
    }
}

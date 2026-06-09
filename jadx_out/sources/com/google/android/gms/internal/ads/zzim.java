package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzim extends zzbfc<zzim> {
    private Integer zzamf = null;
    private Integer zzanx = null;

    public zzim() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x002f, code lost:
    
        r5 = new java.lang.StringBuilder(51);
        r5.append(r3);
        r5.append(" is not a valid enum CellularNetworkType");
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0047, code lost:
    
        throw new java.lang.IllegalArgumentException(r5.toString());
     */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzo, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.ads.zzim zza(com.google.android.gms.internal.ads.zzbez r7) throws com.google.android.gms.internal.ads.zzbfh {
        /*
            r6 = this;
        L0:
            int r0 = r7.zzabk()
            if (r0 == 0) goto L7b
            r1 = 8
            r2 = 2
            if (r0 == r1) goto L48
            r1 = 16
            if (r0 == r1) goto L16
            boolean r0 = super.zza(r7, r0)
            if (r0 != 0) goto L0
            return r6
        L16:
            int r1 = r7.getPosition()
            int r3 = r7.zzacc()     // Catch: java.lang.IllegalArgumentException -> L74
            if (r3 < 0) goto L23
            if (r3 > r2) goto L23
            goto L28
        L23:
            r2 = 4
            if (r3 < r2) goto L2f
            if (r3 > r2) goto L2f
        L28:
            java.lang.Integer r2 = java.lang.Integer.valueOf(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            r6.zzanx = r2     // Catch: java.lang.IllegalArgumentException -> L74
            goto L0
        L2f:
            java.lang.IllegalArgumentException r2 = new java.lang.IllegalArgumentException     // Catch: java.lang.IllegalArgumentException -> L74
            r4 = 51
            java.lang.StringBuilder r5 = new java.lang.StringBuilder     // Catch: java.lang.IllegalArgumentException -> L74
            r5.<init>(r4)     // Catch: java.lang.IllegalArgumentException -> L74
            r5.append(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            java.lang.String r3 = " is not a valid enum CellularNetworkType"
            r5.append(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            java.lang.String r3 = r5.toString()     // Catch: java.lang.IllegalArgumentException -> L74
            r2.<init>(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            throw r2     // Catch: java.lang.IllegalArgumentException -> L74
        L48:
            int r1 = r7.getPosition()
            int r3 = r7.zzacc()     // Catch: java.lang.IllegalArgumentException -> L74
            if (r3 < 0) goto L5b
            if (r3 > r2) goto L5b
            java.lang.Integer r2 = java.lang.Integer.valueOf(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            r6.zzamf = r2     // Catch: java.lang.IllegalArgumentException -> L74
            goto L0
        L5b:
            java.lang.IllegalArgumentException r2 = new java.lang.IllegalArgumentException     // Catch: java.lang.IllegalArgumentException -> L74
            r4 = 43
            java.lang.StringBuilder r5 = new java.lang.StringBuilder     // Catch: java.lang.IllegalArgumentException -> L74
            r5.<init>(r4)     // Catch: java.lang.IllegalArgumentException -> L74
            r5.append(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            java.lang.String r3 = " is not a valid enum NetworkType"
            r5.append(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            java.lang.String r3 = r5.toString()     // Catch: java.lang.IllegalArgumentException -> L74
            r2.<init>(r3)     // Catch: java.lang.IllegalArgumentException -> L74
            throw r2     // Catch: java.lang.IllegalArgumentException -> L74
        L74:
            r7.zzdc(r1)
            r6.zza(r7, r0)
            goto L0
        L7b:
            return r6
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzim.zza(com.google.android.gms.internal.ads.zzbez):com.google.android.gms.internal.ads.zzim");
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzamf != null) {
            zzbfaVar.zzm(1, this.zzamf.intValue());
        }
        if (this.zzanx != null) {
            zzbfaVar.zzm(2, this.zzanx.intValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzamf != null) {
            iZzr += zzbfa.zzq(1, this.zzamf.intValue());
        }
        return this.zzanx != null ? iZzr + zzbfa.zzq(2, this.zzanx.intValue()) : iZzr;
    }
}

package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzzj {
    private static volatile boolean zzbtn = false;
    int zzbtk;
    private int zzbtl;
    private boolean zzbtm;

    private zzzj() {
        this.zzbtk = 100;
        this.zzbtl = Integer.MAX_VALUE;
        this.zzbtm = false;
    }

    static zzzj zza(byte[] bArr, int i, int i2, boolean z) {
        zzzl zzzlVar = new zzzl(bArr, i, i2);
        try {
            zzzlVar.zzaf(i2);
            return zzzlVar;
        } catch (zzzy e) {
            throw new IllegalArgumentException(e);
        }
    }

    public abstract int zzto();
}

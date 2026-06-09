package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzzl extends zzzj {
    private final byte[] buffer;
    private int limit;
    private int pos;
    private final boolean zzbto;
    private int zzbtp;
    private int zzbtq;
    private int zzbtr;

    private zzzl(byte[] bArr, int i, int i2, boolean z) {
        super();
        this.zzbtr = Integer.MAX_VALUE;
        this.buffer = bArr;
        this.limit = i2 + i;
        this.pos = i;
        this.zzbtq = this.pos;
        this.zzbto = z;
    }

    private final void zztp() {
        this.limit += this.zzbtp;
        int i = this.limit - this.zzbtq;
        if (i <= this.zzbtr) {
            this.zzbtp = 0;
        } else {
            this.zzbtp = i - this.zzbtr;
            this.limit -= this.zzbtp;
        }
    }

    public final int zzaf(int i) {
        if (i < 0) {
            throw zzzy.zzuc();
        }
        int iZzto = i + zzto();
        int i2 = this.zzbtr;
        if (iZzto > i2) {
            throw zzzy.zzub();
        }
        this.zzbtr = iZzto;
        zztp();
        return i2;
    }

    @Override // com.google.android.gms.internal.measurement.zzzj
    public final int zzto() {
        return this.pos - this.zzbtq;
    }
}

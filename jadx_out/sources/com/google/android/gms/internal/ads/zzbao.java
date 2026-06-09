package com.google.android.gms.internal.ads;

import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes.dex */
class zzbao extends zzban {
    protected final byte[] zzdpw;

    zzbao(byte[] bArr) {
        this.zzdpw = bArr;
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbah) || size() != ((zzbah) obj).size()) {
            return false;
        }
        if (size() == 0) {
            return true;
        }
        if (!(obj instanceof zzbao)) {
            return obj.equals(this);
        }
        zzbao zzbaoVar = (zzbao) obj;
        int iZzabg = zzabg();
        int iZzabg2 = zzbaoVar.zzabg();
        if (iZzabg == 0 || iZzabg2 == 0 || iZzabg == iZzabg2) {
            return zza(zzbaoVar, 0, size());
        }
        return false;
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public int size() {
        return this.zzdpw.length;
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    protected final String zza(Charset charset) {
        return new String(this.zzdpw, zzabh(), size(), charset);
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    final void zza(zzbag zzbagVar) {
        zzbagVar.zzb(this.zzdpw, zzabh(), size());
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    protected void zza(byte[] bArr, int i, int i2, int i3) {
        System.arraycopy(this.zzdpw, 0, bArr, 0, i3);
    }

    @Override // com.google.android.gms.internal.ads.zzban
    final boolean zza(zzbah zzbahVar, int i, int i2) {
        if (i2 > zzbahVar.size()) {
            int size = size();
            StringBuilder sb = new StringBuilder(40);
            sb.append("Length too large: ");
            sb.append(i2);
            sb.append(size);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i2 > zzbahVar.size()) {
            int size2 = zzbahVar.size();
            StringBuilder sb2 = new StringBuilder(59);
            sb2.append("Ran off end of other: 0, ");
            sb2.append(i2);
            sb2.append(", ");
            sb2.append(size2);
            throw new IllegalArgumentException(sb2.toString());
        }
        if (!(zzbahVar instanceof zzbao)) {
            return zzbahVar.zzk(0, i2).equals(zzk(0, i2));
        }
        zzbao zzbaoVar = (zzbao) zzbahVar;
        byte[] bArr = this.zzdpw;
        byte[] bArr2 = zzbaoVar.zzdpw;
        int iZzabh = zzabh() + i2;
        int iZzabh2 = zzabh();
        int iZzabh3 = zzbaoVar.zzabh();
        while (iZzabh2 < iZzabh) {
            if (bArr[iZzabh2] != bArr2[iZzabh3]) {
                return false;
            }
            iZzabh2++;
            iZzabh3++;
        }
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public final boolean zzabe() {
        int iZzabh = zzabh();
        return zzbem.zzf(this.zzdpw, iZzabh, size() + iZzabh);
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public final zzbaq zzabf() {
        return zzbaq.zza(this.zzdpw, zzabh(), size(), true);
    }

    protected int zzabh() {
        return 0;
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public byte zzbn(int i) {
        return this.zzdpw[i];
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    protected final int zzc(int i, int i2, int i3) {
        return zzbbq.zza(i, this.zzdpw, zzabh(), i3);
    }

    @Override // com.google.android.gms.internal.ads.zzbah
    public final zzbah zzk(int i, int i2) {
        int iZzd = zzd(0, i2, size());
        return iZzd == 0 ? zzbah.zzdpq : new zzbak(this.zzdpw, zzabh(), iZzd);
    }
}

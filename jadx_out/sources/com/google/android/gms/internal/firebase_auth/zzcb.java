package com.google.android.gms.internal.firebase_auth;

import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
class zzcb extends zzca {
    protected final byte[] zzmp;

    zzcb(byte[] bArr) {
        this.zzmp = bArr;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbu) || size() != ((zzbu) obj).size()) {
            return false;
        }
        if (size() == 0) {
            return true;
        }
        if (!(obj instanceof zzcb)) {
            return obj.equals(this);
        }
        zzcb zzcbVar = (zzcb) obj;
        int iZzby = zzby();
        int iZzby2 = zzcbVar.zzby();
        if (iZzby == 0 || iZzby2 == 0 || iZzby == iZzby2) {
            return zza(zzcbVar, 0, size());
        }
        return false;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    public int size() {
        return this.zzmp.length;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    protected final int zza(int i, int i2, int i3) {
        return zzdd.zza(i, this.zzmp, zzbz(), i3);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    public final zzbu zza(int i, int i2) {
        int iZzb = zzb(0, i2, size());
        return iZzb == 0 ? zzbu.zzmi : new zzbx(this.zzmp, zzbz(), iZzb);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    protected final String zza(Charset charset) {
        return new String(this.zzmp, zzbz(), size(), charset);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    final void zza(zzbt zzbtVar) {
        zzbtVar.zza(this.zzmp, zzbz(), size());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzca
    final boolean zza(zzbu zzbuVar, int i, int i2) {
        if (i2 > zzbuVar.size()) {
            int size = size();
            StringBuilder sb = new StringBuilder(40);
            sb.append("Length too large: ");
            sb.append(i2);
            sb.append(size);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i2 > zzbuVar.size()) {
            int size2 = zzbuVar.size();
            StringBuilder sb2 = new StringBuilder(59);
            sb2.append("Ran off end of other: 0, ");
            sb2.append(i2);
            sb2.append(", ");
            sb2.append(size2);
            throw new IllegalArgumentException(sb2.toString());
        }
        if (!(zzbuVar instanceof zzcb)) {
            return zzbuVar.zza(0, i2).equals(zza(0, i2));
        }
        zzcb zzcbVar = (zzcb) zzbuVar;
        byte[] bArr = this.zzmp;
        byte[] bArr2 = zzcbVar.zzmp;
        int iZzbz = zzbz() + i2;
        int iZzbz2 = zzbz();
        int iZzbz3 = zzcbVar.zzbz();
        while (iZzbz2 < iZzbz) {
            if (bArr[iZzbz2] != bArr2[iZzbz3]) {
                return false;
            }
            iZzbz2++;
            iZzbz3++;
        }
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    public final boolean zzbx() {
        int iZzbz = zzbz();
        return zzfx.zzf(this.zzmp, iZzbz, size() + iZzbz);
    }

    protected int zzbz() {
        return 0;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbu
    public byte zzk(int i) {
        return this.zzmp[i];
    }
}

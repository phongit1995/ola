package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
class zzzh extends zzzg {
    protected final byte[] zzbtj;

    zzzh(byte[] bArr) {
        this.zzbtj = bArr;
    }

    @Override // com.google.android.gms.internal.measurement.zzzb
    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzzb) || size() != ((zzzb) obj).size()) {
            return false;
        }
        if (size() == 0) {
            return true;
        }
        if (!(obj instanceof zzzh)) {
            return obj.equals(this);
        }
        zzzh zzzhVar = (zzzh) obj;
        int iZztm = zztm();
        int iZztm2 = zzzhVar.zztm();
        if (iZztm == 0 || iZztm2 == 0 || iZztm == iZztm2) {
            return zza(zzzhVar, 0, size());
        }
        return false;
    }

    @Override // com.google.android.gms.internal.measurement.zzzb
    public int size() {
        return this.zzbtj.length;
    }

    @Override // com.google.android.gms.internal.measurement.zzzb
    protected final int zza(int i, int i2, int i3) {
        return zzzw.zza(i, this.zzbtj, zztn(), i3);
    }

    @Override // com.google.android.gms.internal.measurement.zzzg
    final boolean zza(zzzb zzzbVar, int i, int i2) {
        if (i2 > zzzbVar.size()) {
            int size = size();
            StringBuilder sb = new StringBuilder(40);
            sb.append("Length too large: ");
            sb.append(i2);
            sb.append(size);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i2 > zzzbVar.size()) {
            int size2 = zzzbVar.size();
            StringBuilder sb2 = new StringBuilder(59);
            sb2.append("Ran off end of other: 0, ");
            sb2.append(i2);
            sb2.append(", ");
            sb2.append(size2);
            throw new IllegalArgumentException(sb2.toString());
        }
        if (!(zzzbVar instanceof zzzh)) {
            return zzzbVar.zzb(0, i2).equals(zzb(0, i2));
        }
        zzzh zzzhVar = (zzzh) zzzbVar;
        byte[] bArr = this.zzbtj;
        byte[] bArr2 = zzzhVar.zzbtj;
        int iZztn = zztn() + i2;
        int iZztn2 = zztn();
        int iZztn3 = zzzhVar.zztn();
        while (iZztn2 < iZztn) {
            if (bArr[iZztn2] != bArr2[iZztn3]) {
                return false;
            }
            iZztn2++;
            iZztn3++;
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzzb
    public byte zzae(int i) {
        return this.zzbtj[i];
    }

    @Override // com.google.android.gms.internal.measurement.zzzb
    public final zzzb zzb(int i, int i2) {
        int iZzb = zzb(0, i2, size());
        return iZzb == 0 ? zzzb.zzbte : new zzze(this.zzbtj, zztn(), iZzb);
    }

    protected int zztn() {
        return 0;
    }
}

package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzbx extends zzcb {
    private final int zzmm;
    private final int zzmn;

    zzbx(byte[] bArr, int i, int i2) {
        super(bArr);
        zzb(i, i + i2, bArr.length);
        this.zzmm = i;
        this.zzmn = i2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcb, com.google.android.gms.internal.firebase_auth.zzbu
    public final int size() {
        return this.zzmn;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcb
    protected final int zzbz() {
        return this.zzmm;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcb, com.google.android.gms.internal.firebase_auth.zzbu
    public final byte zzk(int i) {
        int size = size();
        if (((size - (i + 1)) | i) >= 0) {
            return this.zzmp[this.zzmm + i];
        }
        if (i < 0) {
            StringBuilder sb = new StringBuilder(22);
            sb.append("Index < 0: ");
            sb.append(i);
            throw new ArrayIndexOutOfBoundsException(sb.toString());
        }
        StringBuilder sb2 = new StringBuilder(40);
        sb2.append("Index > length: ");
        sb2.append(i);
        sb2.append(", ");
        sb2.append(size);
        throw new ArrayIndexOutOfBoundsException(sb2.toString());
    }
}

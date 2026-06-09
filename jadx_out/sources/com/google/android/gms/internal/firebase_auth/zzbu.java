package com.google.android.gms.internal.firebase_auth;

import java.io.Serializable;
import java.nio.charset.Charset;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzbu implements Serializable, Iterable<Byte> {
    public static final zzbu zzmi = new zzcb(zzdd.EMPTY_BYTE_ARRAY);
    private static final zzby zzmj;
    private int zzmk = 0;

    static {
        zzbv zzbvVar = null;
        zzmj = zzbr.zzbu() ? new zzcc(zzbvVar) : new zzbw(zzbvVar);
    }

    zzbu() {
    }

    static zzbu zza(byte[] bArr) {
        return new zzcb(bArr);
    }

    public static zzbu zzak(String str) {
        return new zzcb(str.getBytes(zzdd.UTF_8));
    }

    static int zzb(int i, int i2, int i3) {
        int i4 = i2 - i;
        if ((i | i2 | i4 | (i3 - i2)) >= 0) {
            return i4;
        }
        if (i < 0) {
            StringBuilder sb = new StringBuilder(32);
            sb.append("Beginning index: ");
            sb.append(i);
            sb.append(" < 0");
            throw new IndexOutOfBoundsException(sb.toString());
        }
        if (i2 < i) {
            StringBuilder sb2 = new StringBuilder(66);
            sb2.append("Beginning index larger than ending index: ");
            sb2.append(i);
            sb2.append(", ");
            sb2.append(i2);
            throw new IndexOutOfBoundsException(sb2.toString());
        }
        StringBuilder sb3 = new StringBuilder(37);
        sb3.append("End index: ");
        sb3.append(i2);
        sb3.append(" >= ");
        sb3.append(i3);
        throw new IndexOutOfBoundsException(sb3.toString());
    }

    public static zzbu zzb(byte[] bArr, int i, int i2) {
        zzb(i, i + i2, bArr.length);
        return new zzcb(zzmj.zzc(bArr, i, i2));
    }

    static zzbz zzl(int i) {
        return new zzbz(i, null);
    }

    public abstract boolean equals(Object obj);

    public final int hashCode() {
        int iZza = this.zzmk;
        if (iZza == 0) {
            int size = size();
            iZza = zza(size, 0, size);
            if (iZza == 0) {
                iZza = 1;
            }
            this.zzmk = iZza;
        }
        return iZza;
    }

    @Override // java.lang.Iterable
    public /* synthetic */ Iterator<Byte> iterator() {
        return new zzbv(this);
    }

    public abstract int size();

    public final String toString() {
        return String.format("<ByteString@%s size=%d>", Integer.toHexString(System.identityHashCode(this)), Integer.valueOf(size()));
    }

    protected abstract int zza(int i, int i2, int i3);

    public abstract zzbu zza(int i, int i2);

    protected abstract String zza(Charset charset);

    abstract void zza(zzbt zzbtVar);

    public final String zzbw() {
        return size() == 0 ? "" : zza(zzdd.UTF_8);
    }

    public abstract boolean zzbx();

    protected final int zzby() {
        return this.zzmk;
    }

    public abstract byte zzk(int i);
}

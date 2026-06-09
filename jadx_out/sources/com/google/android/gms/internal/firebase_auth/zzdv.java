package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzdv extends zzbq<Long> implements zzdg<Long>, RandomAccess {
    private static final zzdv zzsw;
    private int size;
    private long[] zzsx;

    static {
        zzdv zzdvVar = new zzdv();
        zzsw = zzdvVar;
        zzdvVar.zzbs();
    }

    zzdv() {
        this(new long[10], 0);
    }

    private zzdv(long[] jArr, int i) {
        this.zzsx = jArr;
        this.size = i;
    }

    private final void zzh(int i) {
        if (i < 0 || i >= this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
    }

    private final String zzi(int i) {
        int i2 = this.size;
        StringBuilder sb = new StringBuilder(35);
        sb.append("Index:");
        sb.append(i);
        sb.append(", Size:");
        sb.append(i2);
        return sb.toString();
    }

    private final void zzk(int i, long j) {
        zzbt();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
        if (this.size < this.zzsx.length) {
            System.arraycopy(this.zzsx, i, this.zzsx, i + 1, this.size - i);
        } else {
            long[] jArr = new long[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzsx, 0, jArr, 0, i);
            System.arraycopy(this.zzsx, i, jArr, i + 1, this.size - i);
            this.zzsx = jArr;
        }
        this.zzsx[i] = j;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzk(i, ((Long) obj).longValue());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Long> collection) {
        zzbt();
        zzdd.checkNotNull(collection);
        if (!(collection instanceof zzdv)) {
            return super.addAll(collection);
        }
        zzdv zzdvVar = (zzdv) collection;
        if (zzdvVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzdvVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzdvVar.size;
        if (i > this.zzsx.length) {
            this.zzsx = Arrays.copyOf(this.zzsx, i);
        }
        System.arraycopy(zzdvVar.zzsx, 0, this.zzsx, this.size, zzdvVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzdv)) {
            return super.equals(obj);
        }
        zzdv zzdvVar = (zzdv) obj;
        if (this.size != zzdvVar.size) {
            return false;
        }
        long[] jArr = zzdvVar.zzsx;
        for (int i = 0; i < this.size; i++) {
            if (this.zzsx[i] != jArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        return Long.valueOf(getLong(i));
    }

    public final long getLong(int i) {
        zzh(i);
        return this.zzsx[i];
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzk = 1;
        for (int i = 0; i < this.size; i++) {
            iZzk = (iZzk * 31) + zzdd.zzk(this.zzsx[i]);
        }
        return iZzk;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        zzh(i);
        long j = this.zzsx[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzsx, i + 1, this.zzsx, i, this.size - i);
        }
        this.size--;
        this.modCount++;
        return Long.valueOf(j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzbt();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Long.valueOf(this.zzsx[i]))) {
                System.arraycopy(this.zzsx, i + 1, this.zzsx, i, this.size - i);
                this.size--;
                this.modCount++;
                return true;
            }
        }
        return false;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzbt();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzsx, i2, this.zzsx, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        long jLongValue = ((Long) obj).longValue();
        zzbt();
        zzh(i);
        long j = this.zzsx[i];
        this.zzsx[i] = jLongValue;
        return Long.valueOf(j);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg<Long> zzj(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzdv(Arrays.copyOf(this.zzsx, i), this.size);
    }

    public final void zzl(long j) {
        zzk(this.size, j);
    }
}

package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzbs extends zzbq<Boolean> implements zzdg<Boolean>, RandomAccess {
    private static final zzbs zzmg;
    private int size;
    private boolean[] zzmh;

    static {
        zzbs zzbsVar = new zzbs();
        zzmg = zzbsVar;
        zzbsVar.zzbs();
    }

    zzbs() {
        this(new boolean[10], 0);
    }

    private zzbs(boolean[] zArr, int i) {
        this.zzmh = zArr;
        this.size = i;
    }

    private final void zza(int i, boolean z) {
        zzbt();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
        if (this.size < this.zzmh.length) {
            System.arraycopy(this.zzmh, i, this.zzmh, i + 1, this.size - i);
        } else {
            boolean[] zArr = new boolean[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzmh, 0, zArr, 0, i);
            System.arraycopy(this.zzmh, i, zArr, i + 1, this.size - i);
            this.zzmh = zArr;
        }
        this.zzmh[i] = z;
        this.size++;
        this.modCount++;
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

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zza(i, ((Boolean) obj).booleanValue());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Boolean> collection) {
        zzbt();
        zzdd.checkNotNull(collection);
        if (!(collection instanceof zzbs)) {
            return super.addAll(collection);
        }
        zzbs zzbsVar = (zzbs) collection;
        if (zzbsVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzbsVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzbsVar.size;
        if (i > this.zzmh.length) {
            this.zzmh = Arrays.copyOf(this.zzmh, i);
        }
        System.arraycopy(zzbsVar.zzmh, 0, this.zzmh, this.size, zzbsVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    public final void addBoolean(boolean z) {
        zza(this.size, z);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzbs)) {
            return super.equals(obj);
        }
        zzbs zzbsVar = (zzbs) obj;
        if (this.size != zzbsVar.size) {
            return false;
        }
        boolean[] zArr = zzbsVar.zzmh;
        for (int i = 0; i < this.size; i++) {
            if (this.zzmh[i] != zArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzh(i);
        return Boolean.valueOf(this.zzmh[i]);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzh = 1;
        for (int i = 0; i < this.size; i++) {
            iZzh = (iZzh * 31) + zzdd.zzh(this.zzmh[i]);
        }
        return iZzh;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        zzh(i);
        boolean z = this.zzmh[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzmh, i + 1, this.zzmh, i, this.size - i);
        }
        this.size--;
        this.modCount++;
        return Boolean.valueOf(z);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzbt();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Boolean.valueOf(this.zzmh[i]))) {
                System.arraycopy(this.zzmh, i + 1, this.zzmh, i, this.size - i);
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
        System.arraycopy(this.zzmh, i2, this.zzmh, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        boolean zBooleanValue = ((Boolean) obj).booleanValue();
        zzbt();
        zzh(i);
        boolean z = this.zzmh[i];
        this.zzmh[i] = zBooleanValue;
        return Boolean.valueOf(z);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg<Boolean> zzj(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzbs(Arrays.copyOf(this.zzmh, i), this.size);
    }
}

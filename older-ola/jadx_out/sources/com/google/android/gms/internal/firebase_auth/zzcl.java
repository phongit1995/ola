package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzcl extends zzbq<Double> implements zzdg<Double>, RandomAccess {
    private static final zzcl zznq;
    private int size;
    private double[] zznr;

    static {
        zzcl zzclVar = new zzcl();
        zznq = zzclVar;
        zzclVar.zzbs();
    }

    zzcl() {
        this(new double[10], 0);
    }

    private zzcl(double[] dArr, int i) {
        this.zznr = dArr;
        this.size = i;
    }

    private final void zzc(int i, double d) {
        zzbt();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
        if (this.size < this.zznr.length) {
            System.arraycopy(this.zznr, i, this.zznr, i + 1, this.size - i);
        } else {
            double[] dArr = new double[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zznr, 0, dArr, 0, i);
            System.arraycopy(this.zznr, i, dArr, i + 1, this.size - i);
            this.zznr = dArr;
        }
        this.zznr[i] = d;
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
        zzc(i, ((Double) obj).doubleValue());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Double> collection) {
        zzbt();
        zzdd.checkNotNull(collection);
        if (!(collection instanceof zzcl)) {
            return super.addAll(collection);
        }
        zzcl zzclVar = (zzcl) collection;
        if (zzclVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzclVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzclVar.size;
        if (i > this.zznr.length) {
            this.zznr = Arrays.copyOf(this.zznr, i);
        }
        System.arraycopy(zzclVar.zznr, 0, this.zznr, this.size, zzclVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzcl)) {
            return super.equals(obj);
        }
        zzcl zzclVar = (zzcl) obj;
        if (this.size != zzclVar.size) {
            return false;
        }
        double[] dArr = zzclVar.zznr;
        for (int i = 0; i < this.size; i++) {
            if (this.zznr[i] != dArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzh(i);
        return Double.valueOf(this.zznr[i]);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzk = 1;
        for (int i = 0; i < this.size; i++) {
            iZzk = (iZzk * 31) + zzdd.zzk(Double.doubleToLongBits(this.zznr[i]));
        }
        return iZzk;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        zzh(i);
        double d = this.zznr[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zznr, i + 1, this.zznr, i, this.size - i);
        }
        this.size--;
        this.modCount++;
        return Double.valueOf(d);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzbt();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Double.valueOf(this.zznr[i]))) {
                System.arraycopy(this.zznr, i + 1, this.zznr, i, this.size - i);
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
        System.arraycopy(this.zznr, i2, this.zznr, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        double dDoubleValue = ((Double) obj).doubleValue();
        zzbt();
        zzh(i);
        double d = this.zznr[i];
        this.zznr[i] = dDoubleValue;
        return Double.valueOf(d);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzc(double d) {
        zzc(this.size, d);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg<Double> zzj(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzcl(Arrays.copyOf(this.zznr, i), this.size);
    }
}

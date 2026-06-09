package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzcy extends zzbq<Float> implements zzdg<Float>, RandomAccess {
    private static final zzcy zzqt;
    private int size;
    private float[] zzqu;

    static {
        zzcy zzcyVar = new zzcy();
        zzqt = zzcyVar;
        zzcyVar.zzbs();
    }

    zzcy() {
        this(new float[10], 0);
    }

    private zzcy(float[] fArr, int i) {
        this.zzqu = fArr;
        this.size = i;
    }

    private final void zzc(int i, float f) {
        zzbt();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
        if (this.size < this.zzqu.length) {
            System.arraycopy(this.zzqu, i, this.zzqu, i + 1, this.size - i);
        } else {
            float[] fArr = new float[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzqu, 0, fArr, 0, i);
            System.arraycopy(this.zzqu, i, fArr, i + 1, this.size - i);
            this.zzqu = fArr;
        }
        this.zzqu[i] = f;
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
        zzc(i, ((Float) obj).floatValue());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Float> collection) {
        zzbt();
        zzdd.checkNotNull(collection);
        if (!(collection instanceof zzcy)) {
            return super.addAll(collection);
        }
        zzcy zzcyVar = (zzcy) collection;
        if (zzcyVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzcyVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzcyVar.size;
        if (i > this.zzqu.length) {
            this.zzqu = Arrays.copyOf(this.zzqu, i);
        }
        System.arraycopy(zzcyVar.zzqu, 0, this.zzqu, this.size, zzcyVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzcy)) {
            return super.equals(obj);
        }
        zzcy zzcyVar = (zzcy) obj;
        if (this.size != zzcyVar.size) {
            return false;
        }
        float[] fArr = zzcyVar.zzqu;
        for (int i = 0; i < this.size; i++) {
            if (this.zzqu[i] != fArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzh(i);
        return Float.valueOf(this.zzqu[i]);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iFloatToIntBits = 1;
        for (int i = 0; i < this.size; i++) {
            iFloatToIntBits = (iFloatToIntBits * 31) + Float.floatToIntBits(this.zzqu[i]);
        }
        return iFloatToIntBits;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        zzh(i);
        float f = this.zzqu[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzqu, i + 1, this.zzqu, i, this.size - i);
        }
        this.size--;
        this.modCount++;
        return Float.valueOf(f);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzbt();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Float.valueOf(this.zzqu[i]))) {
                System.arraycopy(this.zzqu, i + 1, this.zzqu, i, this.size - i);
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
        System.arraycopy(this.zzqu, i2, this.zzqu, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        float fFloatValue = ((Float) obj).floatValue();
        zzbt();
        zzh(i);
        float f = this.zzqu[i];
        this.zzqu[i] = fFloatValue;
        return Float.valueOf(f);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzc(float f) {
        zzc(this.size, f);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg<Float> zzj(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzcy(Arrays.copyOf(this.zzqu, i), this.size);
    }
}

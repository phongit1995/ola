package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzdc extends zzbq<Integer> implements zzdg<Integer>, RandomAccess {
    private static final zzdc zzrs;
    private int size;
    private int[] zzrt;

    static {
        zzdc zzdcVar = new zzdc();
        zzrs = zzdcVar;
        zzdcVar.zzbs();
    }

    zzdc() {
        this(new int[10], 0);
    }

    private zzdc(int[] iArr, int i) {
        this.zzrt = iArr;
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

    private final void zzo(int i, int i2) {
        zzbt();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzi(i));
        }
        if (this.size < this.zzrt.length) {
            System.arraycopy(this.zzrt, i, this.zzrt, i + 1, this.size - i);
        } else {
            int[] iArr = new int[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzrt, 0, iArr, 0, i);
            System.arraycopy(this.zzrt, i, iArr, i + 1, this.size - i);
            this.zzrt = iArr;
        }
        this.zzrt[i] = i2;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzo(i, ((Integer) obj).intValue());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Integer> collection) {
        zzbt();
        zzdd.checkNotNull(collection);
        if (!(collection instanceof zzdc)) {
            return super.addAll(collection);
        }
        zzdc zzdcVar = (zzdc) collection;
        if (zzdcVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzdcVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzdcVar.size;
        if (i > this.zzrt.length) {
            this.zzrt = Arrays.copyOf(this.zzrt, i);
        }
        System.arraycopy(zzdcVar.zzrt, 0, this.zzrt, this.size, zzdcVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzdc)) {
            return super.equals(obj);
        }
        zzdc zzdcVar = (zzdc) obj;
        if (this.size != zzdcVar.size) {
            return false;
        }
        int[] iArr = zzdcVar.zzrt;
        for (int i = 0; i < this.size; i++) {
            if (this.zzrt[i] != iArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        return Integer.valueOf(getInt(i));
    }

    public final int getInt(int i) {
        zzh(i);
        return this.zzrt[i];
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int i = 1;
        for (int i2 = 0; i2 < this.size; i2++) {
            i = (i * 31) + this.zzrt[i2];
        }
        return i;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        zzh(i);
        int i2 = this.zzrt[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzrt, i + 1, this.zzrt, i, this.size - i);
        }
        this.size--;
        this.modCount++;
        return Integer.valueOf(i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzbt();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Integer.valueOf(this.zzrt[i]))) {
                System.arraycopy(this.zzrt, i + 1, this.zzrt, i, this.size - i);
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
        System.arraycopy(this.zzrt, i2, this.zzrt, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        int iIntValue = ((Integer) obj).intValue();
        zzbt();
        zzh(i);
        int i2 = this.zzrt[i];
        this.zzrt[i] = iIntValue;
        return Integer.valueOf(i2);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzal(int i) {
        zzo(this.size, i);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg<Integer> zzj(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzdc(Arrays.copyOf(this.zzrt, i), this.size);
    }
}

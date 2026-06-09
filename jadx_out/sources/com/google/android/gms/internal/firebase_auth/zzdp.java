package com.google.android.gms.internal.firebase_auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
public final class zzdp extends zzbq<String> implements zzdq, RandomAccess {
    private static final zzdp zzsq;
    private static final zzdq zzsr;
    private final List<Object> zzss;

    static {
        zzdp zzdpVar = new zzdp();
        zzsq = zzdpVar;
        zzdpVar.zzbs();
        zzsr = zzsq;
    }

    public zzdp() {
        this(10);
    }

    public zzdp(int i) {
        this((ArrayList<Object>) new ArrayList(i));
    }

    private zzdp(ArrayList<Object> arrayList) {
        this.zzss = arrayList;
    }

    private static String zzg(Object obj) {
        return obj instanceof String ? (String) obj : obj instanceof zzbu ? ((zzbu) obj).zzbw() : zzdd.zze((byte[]) obj);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzbt();
        this.zzss.add(i, (String) obj);
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final boolean addAll(int i, Collection<? extends String> collection) {
        zzbt();
        if (collection instanceof zzdq) {
            collection = ((zzdq) collection).zzeo();
        }
        boolean zAddAll = this.zzss.addAll(i, collection);
        this.modCount++;
        return zAddAll;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends String> collection) {
        return addAll(size(), collection);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final void clear() {
        zzbt();
        this.zzss.clear();
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final /* bridge */ /* synthetic */ boolean equals(Object obj) {
        return super.equals(obj);
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        Object obj = this.zzss.get(i);
        if (obj instanceof String) {
            return (String) obj;
        }
        if (obj instanceof zzbu) {
            zzbu zzbuVar = (zzbu) obj;
            String strZzbw = zzbuVar.zzbw();
            if (zzbuVar.zzbx()) {
                this.zzss.set(i, strZzbw);
            }
            return strZzbw;
        }
        byte[] bArr = (byte[]) obj;
        String strZze = zzdd.zze(bArr);
        if (zzdd.zzd(bArr)) {
            this.zzss.set(i, strZze);
        }
        return strZze;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final Object getRaw(int i) {
        return this.zzss.get(i);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.Collection, java.util.List
    public final /* bridge */ /* synthetic */ int hashCode() {
        return super.hashCode();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzbt();
        Object objRemove = this.zzss.remove(i);
        this.modCount++;
        return zzg(objRemove);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final /* bridge */ /* synthetic */ boolean remove(Object obj) {
        return super.remove(obj);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final /* bridge */ /* synthetic */ boolean removeAll(Collection collection) {
        return super.removeAll(collection);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final /* bridge */ /* synthetic */ boolean retainAll(Collection collection) {
        return super.retainAll(collection);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        zzbt();
        return zzg(this.zzss.set(i, (String) obj));
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.zzss.size();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbq, com.google.android.gms.internal.firebase_auth.zzdg
    public final /* bridge */ /* synthetic */ boolean zzbr() {
        return super.zzbr();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final void zzc(zzbu zzbuVar) {
        zzbt();
        this.zzss.add(zzbuVar);
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final List<?> zzeo() {
        return Collections.unmodifiableList(this.zzss);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final zzdq zzep() {
        return zzbr() ? new zzfs(this) : this;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdg
    public final /* synthetic */ zzdg zzj(int i) {
        if (i < size()) {
            throw new IllegalArgumentException();
        }
        ArrayList arrayList = new ArrayList(i);
        arrayList.addAll(this.zzss);
        return new zzdp((ArrayList<Object>) arrayList);
    }
}

package com.google.android.gms.internal.firebase_auth;

import java.util.AbstractList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfs extends AbstractList<String> implements zzdq, RandomAccess {
    private final zzdq zzvf;

    public zzfs(zzdq zzdqVar) {
        this.zzvf = zzdqVar;
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        return (String) this.zzvf.get(i);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final Object getRaw(int i) {
        return this.zzvf.getRaw(i);
    }

    @Override // java.util.AbstractList, java.util.AbstractCollection, java.util.Collection, java.lang.Iterable, java.util.List
    public final Iterator<String> iterator() {
        return new zzfu(this);
    }

    @Override // java.util.AbstractList, java.util.List
    public final ListIterator<String> listIterator(int i) {
        return new zzft(this, i);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.zzvf.size();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final void zzc(zzbu zzbuVar) {
        throw new UnsupportedOperationException();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final List<?> zzeo() {
        return this.zzvf.zzeo();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdq
    public final zzdq zzep() {
        return this;
    }
}

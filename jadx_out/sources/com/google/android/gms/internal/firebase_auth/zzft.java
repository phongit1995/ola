package com.google.android.gms.internal.firebase_auth;

import java.util.ListIterator;

/* JADX INFO: loaded from: classes2.dex */
final class zzft implements ListIterator<String> {
    private final /* synthetic */ int val$index;
    private ListIterator<String> zzvg;
    private final /* synthetic */ zzfs zzvh;

    zzft(zzfs zzfsVar, int i) {
        this.zzvh = zzfsVar;
        this.val$index = i;
        this.zzvg = this.zzvh.zzvf.listIterator(this.val$index);
    }

    @Override // java.util.ListIterator
    public final /* synthetic */ void add(String str) {
        throw new UnsupportedOperationException();
    }

    @Override // java.util.ListIterator, java.util.Iterator
    public final boolean hasNext() {
        return this.zzvg.hasNext();
    }

    @Override // java.util.ListIterator
    public final boolean hasPrevious() {
        return this.zzvg.hasPrevious();
    }

    @Override // java.util.ListIterator, java.util.Iterator
    public final /* synthetic */ Object next() {
        return this.zzvg.next();
    }

    @Override // java.util.ListIterator
    public final int nextIndex() {
        return this.zzvg.nextIndex();
    }

    @Override // java.util.ListIterator
    public final /* synthetic */ String previous() {
        return this.zzvg.previous();
    }

    @Override // java.util.ListIterator
    public final int previousIndex() {
        return this.zzvg.previousIndex();
    }

    @Override // java.util.ListIterator, java.util.Iterator
    public final void remove() {
        throw new UnsupportedOperationException();
    }

    @Override // java.util.ListIterator
    public final /* synthetic */ void set(String str) {
        throw new UnsupportedOperationException();
    }
}

package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
final class zzfu implements Iterator<String> {
    private final /* synthetic */ zzfs zzvh;
    private Iterator<String> zzvi;

    zzfu(zzfs zzfsVar) {
        this.zzvh = zzfsVar;
        this.zzvi = this.zzvh.zzvf.iterator();
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return this.zzvi.hasNext();
    }

    @Override // java.util.Iterator
    public final /* synthetic */ String next() {
        return this.zzvi.next();
    }

    @Override // java.util.Iterator
    public final void remove() {
        throw new UnsupportedOperationException();
    }
}

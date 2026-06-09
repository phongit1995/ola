package com.google.android.gms.internal.measurement;

import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
final class zzev implements Iterator<String> {
    private Iterator<String> zzahp;
    private final /* synthetic */ zzeu zzahq;

    zzev(zzeu zzeuVar) {
        this.zzahq = zzeuVar;
        this.zzahp = this.zzahq.zzaho.keySet().iterator();
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return this.zzahp.hasNext();
    }

    @Override // java.util.Iterator
    public final /* synthetic */ String next() {
        return this.zzahp.next();
    }

    @Override // java.util.Iterator
    public final void remove() {
        throw new UnsupportedOperationException("Remove not supported");
    }
}

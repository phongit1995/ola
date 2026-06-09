package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [V, K] */
/* JADX INFO: loaded from: classes2.dex */
final class zzfa<K, V> implements Iterator<Map.Entry<K, V>> {
    private int pos;
    private Iterator<Map.Entry<K, V>> zzuq;
    private final /* synthetic */ zzey zzur;

    private zzfa(zzey zzeyVar) {
        this.zzur = zzeyVar;
        this.pos = this.zzur.zzul.size();
    }

    /* synthetic */ zzfa(zzey zzeyVar, zzez zzezVar) {
        this(zzeyVar);
    }

    private final Iterator<Map.Entry<K, V>> zzft() {
        if (this.zzuq == null) {
            this.zzuq = this.zzur.zzuo.entrySet().iterator();
        }
        return this.zzuq;
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return (this.pos > 0 && this.pos <= this.zzur.zzul.size()) || zzft().hasNext();
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        Map.Entry<K, V> next;
        if (zzft().hasNext()) {
            next = zzft().next();
        } else {
            List list = this.zzur.zzul;
            int i = this.pos - 1;
            this.pos = i;
            next = (Map.Entry<K, V>) list.get(i);
        }
        return next;
    }

    @Override // java.util.Iterator
    public final void remove() {
        throw new UnsupportedOperationException();
    }
}

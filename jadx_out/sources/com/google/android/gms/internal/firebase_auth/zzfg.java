package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [V, K] */
/* JADX INFO: loaded from: classes2.dex */
final class zzfg<K, V> implements Iterator<Map.Entry<K, V>> {
    private int pos;
    private Iterator<Map.Entry<K, V>> zzuq;
    private final /* synthetic */ zzey zzur;
    private boolean zzuv;

    private zzfg(zzey zzeyVar) {
        this.zzur = zzeyVar;
        this.pos = -1;
    }

    /* synthetic */ zzfg(zzey zzeyVar, zzez zzezVar) {
        this(zzeyVar);
    }

    private final Iterator<Map.Entry<K, V>> zzft() {
        if (this.zzuq == null) {
            this.zzuq = this.zzur.zzum.entrySet().iterator();
        }
        return this.zzuq;
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        if (this.pos + 1 >= this.zzur.zzul.size()) {
            return !this.zzur.zzum.isEmpty() && zzft().hasNext();
        }
        return true;
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        this.zzuv = true;
        int i = this.pos + 1;
        this.pos = i;
        return i < this.zzur.zzul.size() ? (Map.Entry<K, V>) this.zzur.zzul.get(this.pos) : zzft().next();
    }

    @Override // java.util.Iterator
    public final void remove() {
        if (!this.zzuv) {
            throw new IllegalStateException("remove() was called before next()");
        }
        this.zzuv = false;
        this.zzur.zzfr();
        if (this.pos >= this.zzur.zzul.size()) {
            zzft().remove();
            return;
        }
        zzey zzeyVar = this.zzur;
        int i = this.pos;
        this.pos = i - 1;
        zzeyVar.zzav(i);
    }
}

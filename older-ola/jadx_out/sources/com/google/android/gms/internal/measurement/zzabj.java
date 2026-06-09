package com.google.android.gms.internal.measurement;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [V, K] */
/* JADX INFO: loaded from: classes2.dex */
final class zzabj<K, V> implements Iterator<Map.Entry<K, V>> {
    private int pos;
    private final /* synthetic */ zzabd zzbwm;
    private boolean zzbwn;
    private Iterator<Map.Entry<K, V>> zzbwo;

    private zzabj(zzabd zzabdVar) {
        this.zzbwm = zzabdVar;
        this.pos = -1;
    }

    /* synthetic */ zzabj(zzabd zzabdVar, zzabe zzabeVar) {
        this(zzabdVar);
    }

    private final Iterator<Map.Entry<K, V>> zzve() {
        if (this.zzbwo == null) {
            this.zzbwo = this.zzbwm.zzbwg.entrySet().iterator();
        }
        return this.zzbwo;
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        if (this.pos + 1 >= this.zzbwm.zzbwf.size()) {
            return !this.zzbwm.zzbwg.isEmpty() && zzve().hasNext();
        }
        return true;
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        this.zzbwn = true;
        int i = this.pos + 1;
        this.pos = i;
        return i < this.zzbwm.zzbwf.size() ? (Map.Entry<K, V>) this.zzbwm.zzbwf.get(this.pos) : zzve().next();
    }

    @Override // java.util.Iterator
    public final void remove() {
        if (!this.zzbwn) {
            throw new IllegalStateException("remove() was called before next()");
        }
        this.zzbwn = false;
        this.zzbwm.zzva();
        if (this.pos >= this.zzbwm.zzbwf.size()) {
            zzve().remove();
            return;
        }
        zzabd zzabdVar = this.zzbwm;
        int i = this.pos;
        this.pos = i - 1;
        zzabdVar.zzai(i);
    }
}

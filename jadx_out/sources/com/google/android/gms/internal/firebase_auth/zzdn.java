package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzdn<K> implements Iterator<Map.Entry<K, Object>> {
    private Iterator<Map.Entry<K, Object>> zzsm;

    public zzdn(Iterator<Map.Entry<K, Object>> it2) {
        this.zzsm = it2;
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return this.zzsm.hasNext();
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        Map.Entry<K, Object> next = this.zzsm.next();
        return next.getValue() instanceof zzdk ? new zzdm(next) : next;
    }

    @Override // java.util.Iterator
    public final void remove() {
        this.zzsm.remove();
    }
}

package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzfb extends zzfh {
    private final /* synthetic */ zzey zzur;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    private zzfb(zzey zzeyVar) {
        super(zzeyVar, null);
        this.zzur = zzeyVar;
    }

    /* synthetic */ zzfb(zzey zzeyVar, zzez zzezVar) {
        this(zzeyVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfh, java.util.AbstractCollection, java.util.Collection, java.lang.Iterable, java.util.Set
    public final Iterator<Map.Entry<K, V>> iterator() {
        return new zzfa(this.zzur, null);
    }
}

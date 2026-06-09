package com.google.android.gms.internal.firebase_auth;

import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzdm<K> implements Map.Entry<K, Object> {
    private Map.Entry<K, zzdk> zzsl;

    private zzdm(Map.Entry<K, zzdk> entry) {
        this.zzsl = entry;
    }

    @Override // java.util.Map.Entry
    public final K getKey() {
        return this.zzsl.getKey();
    }

    @Override // java.util.Map.Entry
    public final Object getValue() {
        if (this.zzsl.getValue() == null) {
            return null;
        }
        return zzdk.zzem();
    }

    @Override // java.util.Map.Entry
    public final Object setValue(Object obj) {
        if (obj instanceof zzeh) {
            return this.zzsl.getValue().zzi((zzeh) obj);
        }
        throw new IllegalArgumentException("LazyField now only used for MessageSet, and the value of MessageSet must be an instance of MessageLite");
    }

    public final zzdk zzen() {
        return this.zzsl.getValue();
    }
}

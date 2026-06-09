package com.google.android.gms.internal.firebase_auth;

import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [V, K] */
/* JADX INFO: loaded from: classes2.dex */
final class zzff<K, V> implements Comparable<zzff>, Map.Entry<K, V> {
    private V value;
    private final /* synthetic */ zzey zzur;

    /* JADX INFO: Incorrect field signature: TK; */
    private final Comparable zzuu;

    /* JADX WARN: Multi-variable type inference failed */
    zzff(zzey zzeyVar, K k, V v) {
        this.zzur = zzeyVar;
        this.zzuu = k;
        this.value = v;
    }

    zzff(zzey zzeyVar, Map.Entry<K, V> entry) {
        this(zzeyVar, (Comparable) entry.getKey(), entry.getValue());
    }

    private static boolean equals(Object obj, Object obj2) {
        return obj == null ? obj2 == null : obj.equals(obj2);
    }

    @Override // java.lang.Comparable
    public final /* synthetic */ int compareTo(zzff zzffVar) {
        return ((Comparable) getKey()).compareTo((Comparable) zzffVar.getKey());
    }

    @Override // java.util.Map.Entry
    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof Map.Entry)) {
            return false;
        }
        Map.Entry entry = (Map.Entry) obj;
        return equals(this.zzuu, entry.getKey()) && equals(this.value, entry.getValue());
    }

    @Override // java.util.Map.Entry
    public final /* synthetic */ Object getKey() {
        return this.zzuu;
    }

    @Override // java.util.Map.Entry
    public final V getValue() {
        return this.value;
    }

    @Override // java.util.Map.Entry
    public final int hashCode() {
        return (this.zzuu == null ? 0 : this.zzuu.hashCode()) ^ (this.value != null ? this.value.hashCode() : 0);
    }

    @Override // java.util.Map.Entry
    public final V setValue(V v) {
        this.zzur.zzfr();
        V v2 = this.value;
        this.value = v;
        return v2;
    }

    public final String toString() {
        String strValueOf = String.valueOf(this.zzuu);
        String strValueOf2 = String.valueOf(this.value);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 1 + String.valueOf(strValueOf2).length());
        sb.append(strValueOf);
        sb.append("=");
        sb.append(strValueOf2);
        return sb.toString();
    }
}

package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzdz<K, V> {
    static <K, V> int zza(zzea<K, V> zzeaVar, K k, V v) {
        return zzcs.zza(zzeaVar.zztb, 1, k) + zzcs.zza(zzeaVar.zztd, 2, v);
    }

    static <K, V> void zza(zzci zzciVar, zzea<K, V> zzeaVar, K k, V v) {
        zzcs.zza(zzciVar, zzeaVar.zztb, 1, k);
        zzcs.zza(zzciVar, zzeaVar.zztd, 2, v);
    }
}

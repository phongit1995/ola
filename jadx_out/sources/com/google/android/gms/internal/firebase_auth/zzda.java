package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;

/* JADX INFO: loaded from: classes2.dex */
final class zzda implements zzeg {
    private static final zzda zzqw = new zzda();

    private zzda() {
    }

    public static zzda zzdy() {
        return zzqw;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeg
    public final boolean zzb(Class<?> cls) {
        return zzdb.class.isAssignableFrom(cls);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeg
    public final zzef zzc(Class<?> cls) {
        if (!zzdb.class.isAssignableFrom(cls)) {
            String strValueOf = String.valueOf(cls.getName());
            throw new IllegalArgumentException(strValueOf.length() != 0 ? "Unsupported message type: ".concat(strValueOf) : new String("Unsupported message type: "));
        }
        try {
            return (zzef) zzdb.zzd(cls.asSubclass(zzdb.class)).zza(zzdb.zze.zzrg, (Object) null, (Object) null);
        } catch (Exception e) {
            String strValueOf2 = String.valueOf(cls.getName());
            throw new RuntimeException(strValueOf2.length() != 0 ? "Unable to get message info for ".concat(strValueOf2) : new String("Unable to get message info for "), e);
        }
    }
}

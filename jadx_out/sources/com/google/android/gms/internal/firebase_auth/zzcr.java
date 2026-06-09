package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzcr {
    private static final zzcp<?> zzny = new zzcq();
    private static final zzcp<?> zznz = zzdm();

    private static zzcp<?> zzdm() {
        try {
            return (zzcp) Class.forName("com.google.protobuf.ExtensionSchemaFull").getDeclaredConstructor(new Class[0]).newInstance(new Object[0]);
        } catch (Exception unused) {
            return null;
        }
    }

    static zzcp<?> zzdn() {
        return zzny;
    }

    static zzcp<?> zzdo() {
        if (zznz == null) {
            throw new IllegalStateException("Protobuf runtime is not correctly loaded.");
        }
        return zznz;
    }
}

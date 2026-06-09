package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzbr {
    private static final Class<?> zzme = zzaj("libcore.io.Memory");
    private static final boolean zzmf;

    static {
        zzmf = zzaj("org.robolectric.Robolectric") != null;
    }

    private static <T> Class<T> zzaj(String str) {
        try {
            return (Class<T>) Class.forName(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    static boolean zzbu() {
        return (zzme == null || zzmf) ? false : true;
    }

    static Class<?> zzbv() {
        return zzme;
    }
}

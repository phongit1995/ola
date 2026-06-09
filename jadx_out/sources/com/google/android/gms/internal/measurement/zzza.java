package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzza {
    private static final Class<?> zzbtc = zzfm("libcore.io.Memory");
    private static final boolean zzbtd;

    static {
        zzbtd = zzfm("org.robolectric.Robolectric") != null;
    }

    private static <T> Class<T> zzfm(String str) {
        try {
            return (Class<T>) Class.forName(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    static boolean zztk() {
        return (zzbtc == null || zzbtd) ? false : true;
    }

    static Class<?> zztl() {
        return zzbtc;
    }
}

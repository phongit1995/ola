package com.google.android.gms.internal.firebase_auth;

import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgr {
    protected static final Charset UTF_8 = Charset.forName("UTF-8");
    private static final Charset ISO_8859_1 = Charset.forName("ISO-8859-1");
    public static final Object zzxz = new Object();

    public static void zza(zzgn zzgnVar, zzgn zzgnVar2) {
        if (zzgnVar.zzxr != null) {
            zzgnVar2.zzxr = (zzgp) zzgnVar.zzxr.clone();
        }
    }
}

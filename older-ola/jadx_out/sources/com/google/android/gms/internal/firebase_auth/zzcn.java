package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzcn {
    private static final Class<?> zzns = zzdg();

    private static final zzco zzao(String str) {
        return (zzco) zzns.getDeclaredMethod(str, new Class[0]).invoke(null, new Object[0]);
    }

    private static Class<?> zzdg() {
        try {
            return Class.forName("com.google.protobuf.ExtensionRegistry");
        } catch (ClassNotFoundException unused) {
            return null;
        }
    }

    public static zzco zzdh() {
        if (zzns != null) {
            try {
                return zzao("getEmptyRegistry");
            } catch (Exception unused) {
            }
        }
        return zzco.zznw;
    }

    static zzco zzdi() {
        zzco zzcoVarZzao;
        if (zzns != null) {
            try {
                zzcoVarZzao = zzao("loadGeneratedRegistry");
            } catch (Exception unused) {
                zzcoVarZzao = null;
            }
        } else {
            zzcoVarZzao = null;
        }
        if (zzcoVarZzao == null) {
            zzcoVarZzao = zzco.zzdi();
        }
        return zzcoVarZzao == null ? zzdh() : zzcoVarZzao;
    }
}

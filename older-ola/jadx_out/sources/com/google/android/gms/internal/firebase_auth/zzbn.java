package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzbn;
import com.google.android.gms.internal.firebase_auth.zzbo;
import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzbn<MessageType extends zzbn<MessageType, BuilderType>, BuilderType extends zzbo<MessageType, BuilderType>> implements zzeh {
    private static boolean zzmb = false;
    protected int zzma = 0;

    @Override // com.google.android.gms.internal.firebase_auth.zzeh
    public final zzbu zzbo() {
        try {
            zzbz zzbzVarZzl = zzbu.zzl(zzdq());
            zzb(zzbzVarZzl.zzcb());
            return zzbzVarZzl.zzca();
        } catch (IOException e) {
            String name = getClass().getName();
            StringBuilder sb = new StringBuilder(String.valueOf(name).length() + 62 + String.valueOf("ByteString").length());
            sb.append("Serializing ");
            sb.append(name);
            sb.append(" to a ");
            sb.append("ByteString");
            sb.append(" threw an IOException (should never happen).");
            throw new RuntimeException(sb.toString(), e);
        }
    }

    int zzbp() {
        throw new UnsupportedOperationException();
    }

    void zzg(int i) {
        throw new UnsupportedOperationException();
    }
}

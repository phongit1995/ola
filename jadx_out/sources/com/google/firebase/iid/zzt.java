package com.google.firebase.iid;

import android.util.Base64;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.util.VisibleForTesting;
import java.security.KeyPair;

/* JADX INFO: loaded from: classes2.dex */
final class zzt {
    private final KeyPair zzbk;
    private final long zzbl;

    @VisibleForTesting
    zzt(KeyPair keyPair, long j) {
        this.zzbk = keyPair;
        this.zzbl = j;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final String zzp() {
        return Base64.encodeToString(this.zzbk.getPublic().getEncoded(), 11);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final String zzq() {
        return Base64.encodeToString(this.zzbk.getPrivate().getEncoded(), 11);
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzt)) {
            return false;
        }
        zzt zztVar = (zzt) obj;
        return this.zzbl == zztVar.zzbl && this.zzbk.getPublic().equals(zztVar.zzbk.getPublic()) && this.zzbk.getPrivate().equals(zztVar.zzbk.getPrivate());
    }

    final long getCreationTime() {
        return this.zzbl;
    }

    final KeyPair getKeyPair() {
        return this.zzbk;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzbk.getPublic(), this.zzbk.getPrivate(), Long.valueOf(this.zzbl));
    }
}

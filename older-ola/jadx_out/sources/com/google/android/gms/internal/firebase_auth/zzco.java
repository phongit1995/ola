package com.google.android.gms.internal.firebase_auth;

import android.support.v4.internal.view.SupportMenu;
import com.google.android.gms.internal.firebase_auth.zzdb;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public class zzco {
    private static volatile boolean zznt = false;
    private static volatile zzco zznv;
    private final Map<zza, zzdb.zzd<?, ?>> zznx;
    private static final Class<?> zznu = zzdj();
    static final zzco zznw = new zzco(true);

    static final class zza {
        private final int number;
        private final Object object;

        zza(Object obj, int i) {
            this.object = obj;
            this.number = i;
        }

        public final boolean equals(Object obj) {
            if (!(obj instanceof zza)) {
                return false;
            }
            zza zzaVar = (zza) obj;
            return this.object == zzaVar.object && this.number == zzaVar.number;
        }

        public final int hashCode() {
            return (System.identityHashCode(this.object) * SupportMenu.USER_MASK) + this.number;
        }
    }

    zzco() {
        this.zznx = new HashMap();
    }

    private zzco(boolean z) {
        this.zznx = Collections.emptyMap();
    }

    static zzco zzdi() {
        return zzcz.zza(zzco.class);
    }

    private static Class<?> zzdj() {
        try {
            return Class.forName("com.google.protobuf.Extension");
        } catch (ClassNotFoundException unused) {
            return null;
        }
    }

    public static zzco zzdk() {
        return zzcn.zzdh();
    }

    public static zzco zzdl() {
        zzco zzcoVarZzdi;
        zzco zzcoVar = zznv;
        if (zzcoVar != null) {
            return zzcoVar;
        }
        synchronized (zzco.class) {
            zzcoVarZzdi = zznv;
            if (zzcoVarZzdi == null) {
                zzcoVarZzdi = zzcn.zzdi();
                zznv = zzcoVarZzdi;
            }
        }
        return zzcoVarZzdi;
    }

    public final <ContainingType extends zzeh> zzdb.zzd<ContainingType, ?> zza(ContainingType containingtype, int i) {
        return (zzdb.zzd) this.zznx.get(new zza(containingtype, i));
    }
}

package com.google.android.gms.internal.measurement;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/* JADX INFO: loaded from: classes2.dex */
final class zzaay {
    private static final zzaay zzbvx = new zzaay();
    private final zzabb zzbvy;
    private final ConcurrentMap<Class<?>, zzaba<?>> zzbvz = new ConcurrentHashMap();

    private zzaay() {
        String[] strArr = {"com.google.protobuf.AndroidProto3SchemaFactory"};
        zzabb zzabbVarZzfq = null;
        for (int i = 0; i <= 0; i++) {
            zzabbVarZzfq = zzfq(strArr[0]);
            if (zzabbVarZzfq != null) {
                break;
            }
        }
        this.zzbvy = zzabbVarZzfq == null ? new zzaai() : zzabbVarZzfq;
    }

    private static zzabb zzfq(String str) {
        try {
            return (zzabb) Class.forName(str).getConstructor(new Class[0]).newInstance(new Object[0]);
        } catch (Throwable unused) {
            return null;
        }
    }

    public static zzaay zzus() {
        return zzbvx;
    }

    public final <T> zzaba<T> zzt(T t) {
        Class<?> cls = t.getClass();
        zzzw.zza(cls, "messageType");
        zzaba<T> zzabaVar = (zzaba) this.zzbvz.get(cls);
        if (zzabaVar != null) {
            return zzabaVar;
        }
        zzaba<T> zzabaVarZzg = this.zzbvy.zzg(cls);
        zzzw.zza(cls, "messageType");
        zzzw.zza(zzabaVarZzg, "schema");
        zzaba<T> zzabaVar2 = (zzaba) this.zzbvz.putIfAbsent(cls, zzabaVarZzg);
        return zzabaVar2 != null ? zzabaVar2 : zzabaVarZzg;
    }
}

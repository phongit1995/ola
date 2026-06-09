package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public enum zzdj {
    VOID(Void.class, Void.class, null),
    INT(Integer.TYPE, Integer.class, 0),
    LONG(Long.TYPE, Long.class, 0L),
    FLOAT(Float.TYPE, Float.class, Float.valueOf(0.0f)),
    DOUBLE(Double.TYPE, Double.class, Double.valueOf(0.0d)),
    BOOLEAN(Boolean.TYPE, Boolean.class, false),
    STRING(String.class, String.class, ""),
    BYTE_STRING(zzbu.class, zzbu.class, zzbu.zzmi),
    ENUM(Integer.TYPE, Integer.class, null),
    MESSAGE(Object.class, Object.class, null);

    private final Class<?> zzsh;
    private final Class<?> zzsi;
    private final Object zzsj;

    zzdj(Class cls, Class cls2, Object obj) {
        this.zzsh = cls;
        this.zzsi = cls2;
        this.zzsj = obj;
    }

    public final Class<?> zzel() {
        return this.zzsi;
    }
}

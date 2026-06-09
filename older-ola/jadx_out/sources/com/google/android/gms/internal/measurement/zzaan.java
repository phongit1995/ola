package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzaan {
    private static final zzaal zzbvn = zzuk();
    private static final zzaal zzbvo = new zzaam();

    static zzaal zzui() {
        return zzbvn;
    }

    static zzaal zzuj() {
        return zzbvo;
    }

    private static zzaal zzuk() {
        try {
            return (zzaal) Class.forName("com.google.protobuf.MapFieldSchemaFull").getDeclaredConstructor(new Class[0]).newInstance(new Object[0]);
        } catch (Exception unused) {
            return null;
        }
    }
}

package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzac {
    private String message;

    public static zzac zzj(String str) {
        zzac zzacVar = new zzac();
        zzacVar.message = str;
        return zzacVar;
    }

    public final String getErrorMessage() {
        return this.message;
    }
}

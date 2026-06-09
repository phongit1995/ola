package com.google.android.gms.internal.firebase_auth;

import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfo extends RuntimeException {
    private final List<String> zzvc;

    public zzfo(zzeh zzehVar) {
        super("Message was missing required fields.  (Lite runtime could not determine which fields were missing).");
        this.zzvc = null;
    }
}

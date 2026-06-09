package com.google.firebase.auth.internal;

import com.google.android.gms.common.logging.Logger;
import com.google.firebase.auth.GetTokenResult;
import java.util.Collections;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public final class zzy {
    private static final Logger zzdx = new Logger("GetTokenResultFactory", new String[0]);

    public static GetTokenResult zzag(String str) {
        Map<String, Object> mapZzah;
        try {
            mapZzah = zzz.zzah(str);
        } catch (com.google.android.gms.internal.firebase_auth.zzv e) {
            zzdx.e("Error parsing token claims", e, new Object[0]);
            mapZzah = Collections.EMPTY_MAP;
        }
        return new GetTokenResult(str, mapZzah);
    }
}

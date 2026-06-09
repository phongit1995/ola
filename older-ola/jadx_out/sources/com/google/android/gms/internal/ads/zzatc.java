package com.google.android.gms.internal.ads;

import android.net.http.SslError;
import javax.annotation.Nullable;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
final class zzatc {
    private static final String[] zzdbo = {"UNKNOWN", "HOST_LOOKUP", "UNSUPPORTED_AUTH_SCHEME", "AUTHENTICATION", "PROXY_AUTHENTICATION", "CONNECT", "IO", "TIMEOUT", "REDIRECT_LOOP", "UNSUPPORTED_SCHEME", "FAILED_SSL_HANDSHAKE", "BAD_URL", "FILE", "FILE_NOT_FOUND", "TOO_MANY_REQUESTS"};
    private static final String[] zzdbp = {"NOT_YET_VALID", "EXPIRED", "ID_MISMATCH", "UNTRUSTED", "DATE_INVALID", "INVALID"};

    zzatc() {
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0039  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void zzd(java.lang.String r2, java.lang.String r3, java.lang.String r4) {
        /*
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r0 = com.google.android.gms.internal.ads.zznk.zzazy
            com.google.android.gms.internal.ads.zzni r1 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r0 = r1.zzd(r0)
            java.lang.Boolean r0 = (java.lang.Boolean) r0
            boolean r0 = r0.booleanValue()
            if (r0 != 0) goto L13
            return
        L13:
            android.os.Bundle r0 = new android.os.Bundle
            r0.<init>()
            java.lang.String r1 = "err"
            r0.putString(r1, r2)
            java.lang.String r2 = "code"
            r0.putString(r2, r3)
            java.lang.String r2 = "host"
            boolean r3 = android.text.TextUtils.isEmpty(r4)
            if (r3 != 0) goto L39
            android.net.Uri r3 = android.net.Uri.parse(r4)
            java.lang.String r4 = r3.getHost()
            if (r4 == 0) goto L39
            java.lang.String r3 = r3.getHost()
            goto L3b
        L39:
            java.lang.String r3 = ""
        L3b:
            r0.putString(r2, r3)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzatc.zzd(java.lang.String, java.lang.String, java.lang.String):void");
    }

    final void zzb(@Nullable SslError sslError) {
        if (sslError == null) {
            return;
        }
        int primaryError = sslError.getPrimaryError();
        zzd("ssl_err", (primaryError < 0 || primaryError >= zzdbp.length) ? String.valueOf(primaryError) : zzdbp[primaryError], sslError.getUrl());
    }

    final void zze(int i, String str) {
        int i2;
        zzd("http_err", (i >= 0 || (i2 = (-i) + (-1)) >= zzdbo.length) ? String.valueOf(i) : zzdbo[i2], str);
    }
}

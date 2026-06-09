package com.google.android.gms.auth.api.signin.internal;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.PendingResults;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.StatusPendingResult;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;

/* JADX INFO: loaded from: classes.dex */
public final class zze implements Runnable {
    private static final Logger zzer = new Logger("RevokeAccessOperation", new String[0]);
    private final StatusPendingResult zzes;
    private final String zzz;

    private zze(String str) {
        Preconditions.checkNotEmpty(str);
        this.zzz = str;
        this.zzes = new StatusPendingResult((GoogleApiClient) null);
    }

    public static PendingResult<Status> zzg(String str) {
        if (str == null) {
            return PendingResults.immediateFailedResult(new Status(4), null);
        }
        zze zzeVar = new zze(str);
        new Thread(zzeVar).start();
        return zzeVar.zzes;
    }

    /* JADX WARN: Removed duplicated region for block: B:21:0x008f A[PHI: r0 r2 r3 r4
      0x008f: PHI (r0v3 com.google.android.gms.common.api.Status) = (r0v1 com.google.android.gms.common.api.Status), (r0v4 com.google.android.gms.common.api.Status) binds: [B:15:0x0073, B:20:0x008d] A[DONT_GENERATE, DONT_INLINE]
      0x008f: PHI (r2v5 java.lang.String) = (r2v2 java.lang.String), (r2v9 java.lang.String) binds: [B:15:0x0073, B:20:0x008d] A[DONT_GENERATE, DONT_INLINE]
      0x008f: PHI (r3v2 com.google.android.gms.common.logging.Logger) = (r3v0 com.google.android.gms.common.logging.Logger), (r3v3 com.google.android.gms.common.logging.Logger) binds: [B:15:0x0073, B:20:0x008d] A[DONT_GENERATE, DONT_INLINE]
      0x008f: PHI (r4v1 java.lang.String) = (r4v0 java.lang.String), (r4v2 java.lang.String) binds: [B:15:0x0073, B:20:0x008d] A[DONT_GENERATE, DONT_INLINE]] */
    @Override // java.lang.Runnable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void run() {
        /*
            r6 = this;
            com.google.android.gms.common.api.Status r0 = com.google.android.gms.common.api.Status.RESULT_INTERNAL_ERROR
            r1 = 0
            java.net.URL r2 = new java.net.URL     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r3 = "https://accounts.google.com/o/oauth2/revoke?token="
            java.lang.String r3 = java.lang.String.valueOf(r3)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r4 = r6.zzz     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r4 = java.lang.String.valueOf(r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            int r5 = r4.length()     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            if (r5 == 0) goto L1c
            java.lang.String r3 = r3.concat(r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            goto L22
        L1c:
            java.lang.String r4 = new java.lang.String     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r4.<init>(r3)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r3 = r4
        L22:
            r2.<init>(r3)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.net.URLConnection r2 = r2.openConnection()     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.net.HttpURLConnection r2 = (java.net.HttpURLConnection) r2     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r3 = "Content-Type"
            java.lang.String r4 = "application/x-www-form-urlencoded"
            r2.setRequestProperty(r3, r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            int r2 = r2.getResponseCode()     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r3 = 200(0xc8, float:2.8E-43)
            if (r2 != r3) goto L3e
            com.google.android.gms.common.api.Status r3 = com.google.android.gms.common.api.Status.RESULT_SUCCESS     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r0 = r3
            goto L47
        L3e:
            com.google.android.gms.common.logging.Logger r3 = com.google.android.gms.auth.api.signin.internal.zze.zzer     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r4 = "Unable to revoke access!"
            java.lang.Object[] r5 = new java.lang.Object[r1]     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r3.e(r4, r5)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
        L47:
            com.google.android.gms.common.logging.Logger r3 = com.google.android.gms.auth.api.signin.internal.zze.zzer     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r4 = 26
            java.lang.StringBuilder r5 = new java.lang.StringBuilder     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r5.<init>(r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r4 = "Response Code: "
            r5.append(r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r5.append(r2)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.String r2 = r5.toString()     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            java.lang.Object[] r4 = new java.lang.Object[r1]     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            r3.d(r2, r4)     // Catch: java.lang.Exception -> L62 java.io.IOException -> L7c
            goto L9e
        L62:
            r2 = move-exception
            com.google.android.gms.common.logging.Logger r3 = com.google.android.gms.auth.api.signin.internal.zze.zzer
            java.lang.String r4 = "Exception when revoking access: "
            java.lang.String r2 = r2.toString()
            java.lang.String r2 = java.lang.String.valueOf(r2)
            int r5 = r2.length()
            if (r5 == 0) goto L76
            goto L8f
        L76:
            java.lang.String r2 = new java.lang.String
            r2.<init>(r4)
            goto L99
        L7c:
            r2 = move-exception
            com.google.android.gms.common.logging.Logger r3 = com.google.android.gms.auth.api.signin.internal.zze.zzer
            java.lang.String r4 = "IOException when revoking access: "
            java.lang.String r2 = r2.toString()
            java.lang.String r2 = java.lang.String.valueOf(r2)
            int r5 = r2.length()
            if (r5 == 0) goto L94
        L8f:
            java.lang.String r2 = r4.concat(r2)
            goto L99
        L94:
            java.lang.String r2 = new java.lang.String
            r2.<init>(r4)
        L99:
            java.lang.Object[] r1 = new java.lang.Object[r1]
            r3.e(r2, r1)
        L9e:
            com.google.android.gms.common.api.internal.StatusPendingResult r1 = r6.zzes
            r1.setResult(r0)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.auth.api.signin.internal.zze.run():void");
    }
}

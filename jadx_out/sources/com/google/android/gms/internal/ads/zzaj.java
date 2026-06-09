package com.google.android.gms.internal.ads;

import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public class zzaj implements zzm {
    private static final boolean DEBUG = zzaf.DEBUG;

    @Deprecated
    private final zzar zzbo;
    private final zzai zzbp;
    private final zzak zzbq;

    public zzaj(zzai zzaiVar) {
        this(zzaiVar, new zzak(4096));
    }

    private zzaj(zzai zzaiVar, zzak zzakVar) {
        this.zzbp = zzaiVar;
        this.zzbo = zzaiVar;
        this.zzbq = zzakVar;
    }

    @Deprecated
    public zzaj(zzar zzarVar) {
        this(zzarVar, new zzak(4096));
    }

    @Deprecated
    private zzaj(zzar zzarVar, zzak zzakVar) {
        this.zzbo = zzarVar;
        this.zzbp = new zzah(zzarVar);
        this.zzbq = zzakVar;
    }

    private static void zza(String str, zzr<?> zzrVar, zzae zzaeVar) throws zzae {
        zzab zzabVarZzj = zzrVar.zzj();
        int iZzi = zzrVar.zzi();
        try {
            zzabVarZzj.zza(zzaeVar);
            zzrVar.zzb(String.format("%s-retry [timeout=%s]", str, Integer.valueOf(iZzi)));
        } catch (zzae e) {
            zzrVar.zzb(String.format("%s-timeout-giveup [timeout=%s]", str, Integer.valueOf(iZzi)));
            throw e;
        }
    }

    private final byte[] zza(InputStream inputStream, int i) throws Throwable {
        zzau zzauVar = new zzau(this.zzbq, i);
        byte[] bArr = null;
        try {
            if (inputStream == null) {
                throw new zzac();
            }
            byte[] bArrZzb = this.zzbq.zzb(1024);
            while (true) {
                try {
                    int i2 = inputStream.read(bArrZzb);
                    if (i2 == -1) {
                        break;
                    }
                    zzauVar.write(bArrZzb, 0, i2);
                } catch (Throwable th) {
                    th = th;
                    bArr = bArrZzb;
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException unused) {
                            zzaf.v("Error occurred when closing InputStream", new Object[0]);
                        }
                    }
                    this.zzbq.zza(bArr);
                    zzauVar.close();
                    throw th;
                }
            }
            byte[] byteArray = zzauVar.toByteArray();
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException unused2) {
                    zzaf.v("Error occurred when closing InputStream", new Object[0]);
                }
            }
            this.zzbq.zza(bArrZzb);
            zzauVar.close();
            return byteArray;
        } catch (Throwable th2) {
            th = th2;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:78:0x019b, code lost:
    
        throw new java.io.IOException();
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:143:0x021f A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:60:0x0140 A[Catch: IOException -> 0x019e, MalformedURLException -> 0x0225, SocketTimeoutException -> 0x0247, TRY_LEAVE, TryCatch #6 {IOException -> 0x019e, blocks: (B:56:0x012f, B:73:0x0182, B:60:0x0140, B:67:0x015d), top: B:134:0x012f }] */
    /* JADX WARN: Removed duplicated region for block: B:93:0x01b7  */
    /* JADX WARN: Type inference failed for: r17v11 */
    /* JADX WARN: Type inference failed for: r17v12 */
    /* JADX WARN: Type inference failed for: r17v13 */
    /* JADX WARN: Type inference failed for: r17v14 */
    /* JADX WARN: Type inference failed for: r17v15 */
    /* JADX WARN: Type inference failed for: r17v2, types: [java.util.List] */
    /* JADX WARN: Type inference failed for: r17v3 */
    /* JADX WARN: Type inference failed for: r7v15 */
    /* JADX WARN: Type inference failed for: r7v17 */
    /* JADX WARN: Type inference failed for: r7v20 */
    /* JADX WARN: Type inference failed for: r7v7 */
    /* JADX WARN: Type inference failed for: r7v8 */
    @Override // com.google.android.gms.internal.ads.zzm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public com.google.android.gms.internal.ads.zzp zzc(com.google.android.gms.internal.ads.zzr<?> r24) throws com.google.android.gms.internal.ads.zzae {
        /*
            Method dump skipped, instruction units count: 595
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaj.zzc(com.google.android.gms.internal.ads.zzr):com.google.android.gms.internal.ads.zzp");
    }
}

package com.google.firebase.auth.api.internal;

import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzh implements zzdk<com.google.android.gms.internal.firebase_auth.zzba> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;
    private final /* synthetic */ zzdj zzfo;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzao zzfp;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzaz zzfq;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzaj zzfr;

    zzh(zza zzaVar, com.google.android.gms.internal.firebase_auth.zzaz zzazVar, com.google.android.gms.internal.firebase_auth.zzaj zzajVar, zzcb zzcbVar, com.google.android.gms.internal.firebase_auth.zzao zzaoVar, zzdj zzdjVar) {
        this.zzfm = zzaVar;
        this.zzfq = zzazVar;
        this.zzfr = zzajVar;
        this.zzfl = zzcbVar;
        this.zzfp = zzaoVar;
        this.zzfo = zzdjVar;
    }

    /* JADX WARN: Removed duplicated region for block: B:23:0x0076  */
    /* JADX WARN: Removed duplicated region for block: B:27:0x008c  */
    @Override // com.google.firebase.auth.api.internal.zzdk
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final /* synthetic */ void onSuccess(@android.support.annotation.NonNull com.google.android.gms.internal.firebase_auth.zzba r4) {
        /*
            r3 = this;
            com.google.android.gms.internal.firebase_auth.zzba r4 = (com.google.android.gms.internal.firebase_auth.zzba) r4
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r1 = "EMAIL"
            boolean r0 = r0.zzu(r1)
            r1 = 0
            if (r0 == 0) goto L13
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            r0.zzl(r1)
            goto L26
        L13:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r0 = r0.getEmail()
            if (r0 == 0) goto L26
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            com.google.android.gms.internal.firebase_auth.zzaz r2 = r3.zzfq
            java.lang.String r2 = r2.getEmail()
            r0.zzl(r2)
        L26:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r2 = "DISPLAY_NAME"
            boolean r0 = r0.zzu(r2)
            if (r0 == 0) goto L36
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            r0.zzm(r1)
            goto L49
        L36:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r0 = r0.getDisplayName()
            if (r0 == 0) goto L49
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            com.google.android.gms.internal.firebase_auth.zzaz r2 = r3.zzfq
            java.lang.String r2 = r2.getDisplayName()
            r0.zzm(r2)
        L49:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r2 = "PHOTO_URL"
            boolean r0 = r0.zzu(r2)
            if (r0 == 0) goto L59
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
        L55:
            r0.zzn(r1)
            goto L6a
        L59:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r0 = r0.zzt()
            if (r0 == 0) goto L6a
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            com.google.android.gms.internal.firebase_auth.zzaz r1 = r3.zzfq
            java.lang.String r1 = r1.zzt()
            goto L55
        L6a:
            com.google.android.gms.internal.firebase_auth.zzaz r0 = r3.zzfq
            java.lang.String r0 = r0.getPassword()
            boolean r0 = android.text.TextUtils.isEmpty(r0)
            if (r0 != 0) goto L85
            com.google.android.gms.internal.firebase_auth.zzaj r0 = r3.zzfr
            java.lang.String r1 = "redacted"
            byte[] r1 = r1.getBytes()
            java.lang.String r1 = com.google.android.gms.common.util.Base64Utils.encode(r1)
            r0.zzo(r1)
        L85:
            java.util.List r0 = r4.zzat()
            if (r0 == 0) goto L8c
            goto L91
        L8c:
            java.util.ArrayList r0 = new java.util.ArrayList
            r0.<init>()
        L91:
            com.google.android.gms.internal.firebase_auth.zzaj r1 = r3.zzfr
            r1.zzb(r0)
            com.google.firebase.auth.api.internal.zzcb r0 = r3.zzfl
            com.google.firebase.auth.api.internal.zza r1 = r3.zzfm
            com.google.android.gms.internal.firebase_auth.zzao r2 = r3.zzfp
            com.google.android.gms.internal.firebase_auth.zzao r4 = com.google.firebase.auth.api.internal.zza.zza(r1, r2, r4)
            com.google.android.gms.internal.firebase_auth.zzaj r1 = r3.zzfr
            r0.zza(r4, r1)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.auth.api.internal.zzh.onSuccess(java.lang.Object):void");
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfo.zzc(str);
    }
}

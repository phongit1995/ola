package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.auth.ActionCodeSettings;

/* JADX INFO: loaded from: classes2.dex */
public final class zzan implements com.google.firebase.auth.api.internal.zzdp<zzl> {
    private String zzaf;
    private String zzah;
    private ActionCodeSettings zzhb;
    private String zzjw;

    public zzan(@NonNull int i) {
        this.zzjw = i != 1 ? i != 4 ? i != 6 ? "REQUEST_TYPE_UNSET_ENUM_VALUE" : "EMAIL_SIGNIN" : "VERIFY_EMAIL" : "PASSWORD_RESET";
    }

    public final zzan zza(@NonNull ActionCodeSettings actionCodeSettings) {
        this.zzhb = (ActionCodeSettings) Preconditions.checkNotNull(actionCodeSettings);
        return this;
    }

    /* JADX WARN: Removed duplicated region for block: B:18:0x003a  */
    @Override // com.google.firebase.auth.api.internal.zzdp
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzgt zzao() {
        /*
            r5 = this;
            com.google.android.gms.internal.firebase_auth.zzl r0 = new com.google.android.gms.internal.firebase_auth.zzl
            r0.<init>()
            java.lang.String r1 = r5.zzjw
            int r2 = r1.hashCode()
            r3 = -1452371317(0xffffffffa96e928b, float:-5.2973722E-14)
            r4 = 1
            if (r2 == r3) goto L30
            r3 = -1341836234(0xffffffffb0053436, float:-4.8459314E-10)
            if (r2 == r3) goto L26
            r3 = 870738373(0x33e669c5, float:1.0729449E-7)
            if (r2 == r3) goto L1c
            goto L3a
        L1c:
            java.lang.String r2 = "EMAIL_SIGNIN"
            boolean r1 = r1.equals(r2)
            if (r1 == 0) goto L3a
            r1 = 2
            goto L3b
        L26:
            java.lang.String r2 = "VERIFY_EMAIL"
            boolean r1 = r1.equals(r2)
            if (r1 == 0) goto L3a
            r1 = 1
            goto L3b
        L30:
            java.lang.String r2 = "PASSWORD_RESET"
            boolean r1 = r1.equals(r2)
            if (r1 == 0) goto L3a
            r1 = 0
            goto L3b
        L3a:
            r1 = -1
        L3b:
            switch(r1) {
                case 0: goto L44;
                case 1: goto L43;
                case 2: goto L41;
                default: goto L3e;
            }
        L3e:
            r4 = -2147483648(0xffffffff80000000, float:-0.0)
            goto L44
        L41:
            r4 = 6
            goto L44
        L43:
            r4 = 4
        L44:
            r0.zzao = r4
            java.lang.String r1 = r5.zzah
            r0.zzah = r1
            java.lang.String r1 = r5.zzaf
            r0.zzaf = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            if (r1 == 0) goto L8a
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            java.lang.String r1 = r1.getUrl()
            r0.zzat = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            java.lang.String r1 = r1.getIOSBundle()
            r0.zzau = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            java.lang.String r1 = r1.zzf()
            r0.zzav = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            java.lang.String r1 = r1.getAndroidPackageName()
            r0.zzaw = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            boolean r1 = r1.getAndroidInstallApp()
            r0.zzax = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            java.lang.String r1 = r1.getAndroidMinimumVersion()
            r0.zzay = r1
            com.google.firebase.auth.ActionCodeSettings r1 = r5.zzhb
            boolean r1 = r1.canHandleCodeInApp()
            r0.zzaz = r1
        L8a:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzan.zzao():com.google.android.gms.internal.firebase_auth.zzgt");
    }

    public final zzan zzp(@NonNull String str) {
        this.zzah = Preconditions.checkNotEmpty(str);
        return this;
    }

    public final zzan zzq(@NonNull String str) {
        this.zzaf = Preconditions.checkNotEmpty(str);
        return this;
    }
}

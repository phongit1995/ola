package com.google.android.gms.internal.firebase_auth;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaz implements com.google.firebase.auth.api.internal.zzdp<zzo> {
    private String zzaf;
    private String zzag;
    private String zzah;
    private String zzbh;
    private String zzbi;
    private String zzbr;
    private boolean zzbt = true;
    private zzbd zzkf = new zzbd();
    private zzbd zzke = new zzbd();

    @Nullable
    public final String getDisplayName() {
        return this.zzbh;
    }

    @Nullable
    public final String getEmail() {
        return this.zzah;
    }

    @Nullable
    public final String getPassword() {
        return this.zzbi;
    }

    @NonNull
    public final zzaz zzaa(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        this.zzke.zzbc().add(str);
        return this;
    }

    @NonNull
    public final zzaz zzab(@NonNull String str) {
        this.zzag = Preconditions.checkNotEmpty(str);
        return this;
    }

    /* JADX WARN: Removed duplicated region for block: B:26:0x0091  */
    @Override // com.google.firebase.auth.api.internal.zzdp
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzgt zzao() {
        /*
            r11 = this;
            com.google.android.gms.internal.firebase_auth.zzo r0 = new com.google.android.gms.internal.firebase_auth.zzo
            r0.<init>()
            java.lang.String r1 = r11.zzaf
            r0.zzaf = r1
            java.lang.String r1 = r11.zzah
            r0.zzah = r1
            java.lang.String r1 = r11.zzbi
            r0.zzbi = r1
            java.lang.String r1 = r11.zzbh
            r0.zzbh = r1
            java.lang.String r1 = r11.zzbr
            r0.zzbr = r1
            com.google.android.gms.internal.firebase_auth.zzbd r1 = r11.zzke
            java.util.List r1 = r1.zzbc()
            com.google.android.gms.internal.firebase_auth.zzbd r2 = r11.zzke
            java.util.List r2 = r2.zzbc()
            int r2 = r2.size()
            java.lang.String[] r2 = new java.lang.String[r2]
            java.lang.Object[] r1 = r1.toArray(r2)
            java.lang.String[] r1 = (java.lang.String[]) r1
            r0.zzbu = r1
            com.google.android.gms.internal.firebase_auth.zzbd r1 = r11.zzkf
            java.util.List r1 = r1.zzbc()
            int r2 = r1.size()
            int[] r2 = new int[r2]
            r3 = 0
            r4 = 0
        L41:
            int r5 = r1.size()
            if (r4 >= r5) goto La2
            java.lang.Object r5 = r1.get(r4)
            java.lang.String r5 = (java.lang.String) r5
            r6 = -1
            int r7 = r5.hashCode()
            r8 = -333046776(0xffffffffec261c08, float:-8.0325624E26)
            r9 = 2
            r10 = 1
            if (r7 == r8) goto L87
            r8 = 66081660(0x3f0537c, float:1.4125099E-36)
            if (r7 == r8) goto L7d
            r8 = 1939891618(0x73a065a2, float:2.541592E31)
            if (r7 == r8) goto L73
            r8 = 1999612571(0x772faa9b, float:3.5629384E33)
            if (r7 == r8) goto L69
            goto L91
        L69:
            java.lang.String r7 = "PASSWORD"
            boolean r5 = r5.equals(r7)
            if (r5 == 0) goto L91
            r5 = 2
            goto L92
        L73:
            java.lang.String r7 = "PHOTO_URL"
            boolean r5 = r5.equals(r7)
            if (r5 == 0) goto L91
            r5 = 3
            goto L92
        L7d:
            java.lang.String r7 = "EMAIL"
            boolean r5 = r5.equals(r7)
            if (r5 == 0) goto L91
            r5 = 0
            goto L92
        L87:
            java.lang.String r7 = "DISPLAY_NAME"
            boolean r5 = r5.equals(r7)
            if (r5 == 0) goto L91
            r5 = 1
            goto L92
        L91:
            r5 = -1
        L92:
            switch(r5) {
                case 0: goto L9c;
                case 1: goto L9d;
                case 2: goto L9a;
                case 3: goto L98;
                default: goto L95;
            }
        L95:
            r9 = -2147483648(0xffffffff80000000, float:-0.0)
            goto L9d
        L98:
            r9 = 4
            goto L9d
        L9a:
            r9 = 5
            goto L9d
        L9c:
            r9 = 1
        L9d:
            r2[r4] = r9
            int r4 = r4 + 1
            goto L41
        La2:
            r0.zzbs = r2
            boolean r1 = r11.zzbt
            r0.zzbt = r1
            java.lang.String r1 = r11.zzag
            r0.zzag = r1
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzaz.zzao():com.google.android.gms.internal.firebase_auth.zzgt");
    }

    @Nullable
    public final String zzt() {
        return this.zzbr;
    }

    public final boolean zzu(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzkf.zzbc().contains(str);
    }

    @NonNull
    public final zzaz zzv(@NonNull String str) {
        this.zzaf = Preconditions.checkNotEmpty(str);
        return this;
    }

    @NonNull
    public final zzaz zzw(@Nullable String str) {
        if (str == null) {
            this.zzkf.zzbc().add("EMAIL");
            return this;
        }
        this.zzah = str;
        return this;
    }

    @NonNull
    public final zzaz zzx(@Nullable String str) {
        if (str == null) {
            this.zzkf.zzbc().add("PASSWORD");
            return this;
        }
        this.zzbi = str;
        return this;
    }

    @NonNull
    public final zzaz zzy(@Nullable String str) {
        if (str == null) {
            this.zzkf.zzbc().add("DISPLAY_NAME");
            return this;
        }
        this.zzbh = str;
        return this;
    }

    @NonNull
    public final zzaz zzz(@Nullable String str) {
        if (str == null) {
            this.zzkf.zzbc().add("PHOTO_URL");
            return this;
        }
        this.zzbr = str;
        return this;
    }
}

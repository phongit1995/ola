package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzi implements zzdk<com.google.android.gms.internal.firebase_auth.zzah> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zzdj zzfo;
    private final /* synthetic */ String zzfs;
    private final /* synthetic */ String zzft;
    private final /* synthetic */ Boolean zzfu;
    private final /* synthetic */ com.google.firebase.auth.zzd zzfv;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzao zzfw;

    zzi(zza zzaVar, zzdj zzdjVar, String str, String str2, Boolean bool, com.google.firebase.auth.zzd zzdVar, zzcb zzcbVar, com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzfo = zzdjVar;
        this.zzfs = str;
        this.zzft = str2;
        this.zzfu = bool;
        this.zzfv = zzdVar;
        this.zzfl = zzcbVar;
        this.zzfw = zzaoVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzah zzahVar) {
        com.google.android.gms.internal.firebase_auth.zzaq zzaqVar;
        List<com.google.android.gms.internal.firebase_auth.zzaj> listZzas = zzahVar.zzas();
        if (listZzas == null || listZzas.isEmpty()) {
            this.zzfo.zzc("No users.");
            return;
        }
        boolean zBooleanValue = false;
        com.google.android.gms.internal.firebase_auth.zzaj zzajVar = listZzas.get(0);
        com.google.android.gms.internal.firebase_auth.zzas zzasVarZzau = zzajVar.zzau();
        List<com.google.android.gms.internal.firebase_auth.zzaq> listZzat = zzasVarZzau != null ? zzasVarZzau.zzat() : null;
        if (listZzat != null && !listZzat.isEmpty()) {
            if (TextUtils.isEmpty(this.zzfs)) {
                zzaqVar = listZzat.get(0);
            } else {
                for (int i = 0; i < listZzat.size(); i++) {
                    if (listZzat.get(i).getProviderId().equals(this.zzfs)) {
                        zzaqVar = listZzat.get(i);
                    }
                }
            }
            zzaqVar.zzt(this.zzft);
            break;
        }
        if (this.zzfu != null) {
            zBooleanValue = this.zzfu.booleanValue();
        } else if (zzajVar.getLastSignInTimestamp() - zzajVar.getCreationTimestamp() < 1000) {
            zBooleanValue = true;
        }
        zzajVar.zzc(zBooleanValue);
        zzajVar.zzb(this.zzfv);
        this.zzfl.zza(this.zzfw, zzajVar);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfo.zzc(str);
    }
}

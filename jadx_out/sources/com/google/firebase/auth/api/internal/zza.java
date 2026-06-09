package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.EmailAuthCredential;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
public final class zza {
    private final zzdi zzfk;

    public zza(@NonNull zzdi zzdiVar) {
        this.zzfk = (zzdi) Preconditions.checkNotNull(zzdiVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static com.google.android.gms.internal.firebase_auth.zzao zza(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull com.google.android.gms.internal.firebase_auth.zzba zzbaVar) {
        Preconditions.checkNotNull(zzaoVar);
        Preconditions.checkNotNull(zzbaVar);
        String idToken = zzbaVar.getIdToken();
        String strZzap = zzbaVar.zzap();
        return (TextUtils.isEmpty(idToken) || TextUtils.isEmpty(strZzap)) ? zzaoVar : new com.google.android.gms.internal.firebase_auth.zzao(strZzap, idToken, Long.valueOf(zzbaVar.zzaq()), zzaoVar.zzax());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzaa zzaaVar, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotNull(zzaaVar);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(zzaaVar, new zzf(this, zzcbVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @Nullable String str, @Nullable String str2, @Nullable Boolean bool, @Nullable com.google.firebase.auth.zzd zzdVar, @NonNull zzcb zzcbVar, @NonNull zzdj zzdjVar) {
        Preconditions.checkNotNull(zzaoVar);
        Preconditions.checkNotNull(zzdjVar);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzag(zzaoVar.zzaw()), new zzi(this, zzdjVar, str2, str, bool, zzdVar, zzcbVar, zzaoVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zza(@NonNull zzcb zzcbVar, @NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull com.google.android.gms.internal.firebase_auth.zzaj zzajVar, @NonNull com.google.android.gms.internal.firebase_auth.zzaz zzazVar, @NonNull zzdj zzdjVar) {
        Preconditions.checkNotNull(zzcbVar);
        Preconditions.checkNotNull(zzaoVar);
        Preconditions.checkNotNull(zzajVar);
        Preconditions.checkNotNull(zzazVar);
        Preconditions.checkNotNull(zzdjVar);
        this.zzfk.zza(zzazVar, new zzh(this, zzazVar, zzajVar, zzcbVar, zzaoVar, zzdjVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zza(@NonNull zzcb zzcbVar, @NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull com.google.android.gms.internal.firebase_auth.zzaz zzazVar, @NonNull zzdj zzdjVar) {
        Preconditions.checkNotNull(zzcbVar);
        Preconditions.checkNotNull(zzaoVar);
        Preconditions.checkNotNull(zzazVar);
        Preconditions.checkNotNull(zzdjVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzag(zzaoVar.zzaw()), new zzg(this, zzdjVar, zzcbVar, zzaoVar, zzazVar));
    }

    private final void zza(@NonNull String str, @NonNull zzdk<com.google.android.gms.internal.firebase_auth.zzao> zzdkVar) {
        Preconditions.checkNotNull(zzdkVar);
        Preconditions.checkNotEmpty(str);
        com.google.android.gms.internal.firebase_auth.zzao zzaoVarZzs = com.google.android.gms.internal.firebase_auth.zzao.zzs(str);
        if (zzaoVarZzs.isValid()) {
            zzdkVar.onSuccess(zzaoVarZzs);
        } else {
            this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzaf(zzaoVarZzs.zzap()), new zzag(this, zzdkVar));
        }
    }

    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotNull(zzbfVar);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(zzbfVar, new zzx(this, zzcbVar));
    }

    public final void zza(@NonNull EmailAuthCredential emailAuthCredential, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotNull(emailAuthCredential);
        Preconditions.checkNotNull(zzcbVar);
        if (emailAuthCredential.zzi()) {
            zza(emailAuthCredential.zzh(), new zze(this, emailAuthCredential, zzcbVar));
        } else {
            zza(new com.google.android.gms.internal.firebase_auth.zzaa(emailAuthCredential, null), zzcbVar);
        }
    }

    public final void zza(@NonNull zzcb zzcbVar) {
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzbb(), new zzab(this, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzbfVar);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzq(this, zzbfVar, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull ActionCodeSettings actionCodeSettings, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        com.google.android.gms.internal.firebase_auth.zzan zzanVar = new com.google.android.gms.internal.firebase_auth.zzan(actionCodeSettings.getRequestType());
        zzanVar.zzp(str);
        zzanVar.zza(actionCodeSettings);
        this.zzfk.zza(zzanVar, new zzk(this, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull UserProfileChangeRequest userProfileChangeRequest, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(userProfileChangeRequest);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzac(this, userProfileChangeRequest, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzaf(str), new zzb(this, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzad(this, str2, zzcbVar));
    }

    public final void zza(@NonNull String str, @NonNull String str2, @NonNull String str3, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotEmpty(str3);
        Preconditions.checkNotNull(zzcbVar);
        zza(str3, new zzp(this, str, str2, zzcbVar));
    }

    public final void zzb(@NonNull String str, @Nullable ActionCodeSettings actionCodeSettings, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        com.google.android.gms.internal.firebase_auth.zzan zzanVar = new com.google.android.gms.internal.firebase_auth.zzan(4);
        zzanVar.zzq(str);
        if (actionCodeSettings != null) {
            zzanVar.zza(actionCodeSettings);
        }
        this.zzfk.zza(zzanVar, new zzl(this, zzcbVar));
    }

    public final void zzb(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzbi(str), new zzm(this, zzcbVar));
    }

    public final void zzb(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzae(this, str2, zzcbVar));
    }

    public final void zzc(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        com.google.android.gms.internal.firebase_auth.zzaz zzazVar = new com.google.android.gms.internal.firebase_auth.zzaz();
        zzazVar.zzab(str);
        this.zzfk.zza(zzazVar, new zzaf(this, zzcbVar));
    }

    public final void zzc(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzbb(str, str2, null), new zzc(this, zzcbVar));
    }

    public final void zzd(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzw(str), new zzj(this, zzcbVar));
    }

    public final void zzd(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzbl(str, str2), new zzd(this, zzcbVar));
    }

    public final void zze(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzau(str, null), new zzn(this, zzcbVar));
    }

    public final void zze(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zza(new com.google.android.gms.internal.firebase_auth.zzau(str, str2), new zzo(this, zzcbVar));
    }

    public final void zzf(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzs(this, zzcbVar));
    }

    public final void zzf(@NonNull String str, @NonNull String str2, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotNull(zzcbVar);
        zza(str2, new zzt(this, str, zzcbVar));
    }

    public final void zzg(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzv(this, zzcbVar));
    }

    public final void zzh(@NonNull String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzcbVar);
        zza(str, new zzy(this, zzcbVar));
    }

    public final void zzi(@Nullable String str, @NonNull zzcb zzcbVar) {
        Preconditions.checkNotNull(zzcbVar);
        this.zzfk.zzb(str, new zzaa(this, zzcbVar));
    }
}

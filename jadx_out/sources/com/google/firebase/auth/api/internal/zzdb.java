package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
final class zzdb extends zzci {
    final /* synthetic */ zzcy zziw;

    private zzdb(zzcy zzcyVar) {
        this.zziw = zzcyVar;
    }

    private final void zza(zzdh zzdhVar) {
        this.zziw.zzij.execute(new zzdg(this, zzdhVar));
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void onFailure(@NonNull Status status) {
        if (this.zziw.zzia != 8) {
            this.zziw.zzd(status);
            this.zziw.zzc(status);
        } else {
            zzcy.zza(this.zziw, true);
            this.zziw.zzis = false;
            zza(new zzdf(this, status));
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void onVerificationCompleted(@NonNull PhoneAuthCredential phoneAuthCredential) {
        boolean z = this.zziw.zzia == 8;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        zzcy.zza(this.zziw, true);
        this.zziw.zzis = true;
        zza(new zzdd(this, phoneAuthCredential));
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(@NonNull Status status, @NonNull PhoneAuthCredential phoneAuthCredential) {
        if (this.zziw.zzik == null) {
            onFailure(status);
        } else {
            zzcy.zza(this.zziw, true);
            this.zziw.zzik.zza(status, phoneAuthCredential);
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull com.google.android.gms.internal.firebase_auth.zzaj zzajVar) {
        boolean z = this.zziw.zzia == 2;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(37);
        sb.append("Unexpected response type: ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzil = zzaoVar;
        this.zziw.zzim = zzajVar;
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(@Nullable com.google.android.gms.internal.firebase_auth.zzav zzavVar) {
        boolean z = this.zziw.zzia == 4;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzio = zzavVar;
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzx zzxVar) {
        boolean z = this.zziw.zzia == 3;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzin = zzxVar;
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzac() {
        boolean z = this.zziw.zzia == 5;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzad() {
        boolean z = this.zziw.zzia == 6;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzae() {
        boolean z = this.zziw.zzia == 9;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzb(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        boolean z = this.zziw.zzia == 1;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(37);
        sb.append("Unexpected response type: ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzil = zzaoVar;
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzd(@NonNull String str) {
        boolean z = this.zziw.zzia == 7;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzip = str;
        this.zziw.zzam();
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zze(@NonNull String str) {
        boolean z = this.zziw.zzia == 8;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzey = str;
        zza(new zzdc(this, str));
    }

    @Override // com.google.firebase.auth.api.internal.zzch
    public final void zzf(@NonNull String str) {
        boolean z = this.zziw.zzia == 8;
        int i = this.zziw.zzia;
        StringBuilder sb = new StringBuilder(36);
        sb.append("Unexpected response type ");
        sb.append(i);
        Preconditions.checkState(z, sb.toString());
        this.zziw.zzey = str;
        zzcy.zza(this.zziw, true);
        this.zziw.zzis = true;
        zza(new zzde(this, str));
    }
}

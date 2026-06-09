package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "ResetPasswordResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzav extends AbstractSafeParcelable implements com.google.firebase.auth.api.internal.zzcg<zzav, zzg.zzd> {
    public static final Parcelable.Creator<zzav> CREATOR = new zzaw();

    @SafeParcelable.Field(getter = "getEmail", id = 2)
    private String zzah;

    @SafeParcelable.Field(getter = "getNewEmail", id = 3)
    private String zzas;

    @SafeParcelable.Field(getter = "getRequestType", id = 4)
    private String zzjw;

    public zzav() {
    }

    @SafeParcelable.Constructor
    zzav(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) String str3) {
        this.zzah = str;
        this.zzas = str2;
        this.zzjw = str3;
    }

    public final String getEmail() {
        return this.zzah;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzah, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzas, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzjw, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.zzd zzdVar = (zzg.zzd) zzgtVar;
        this.zzah = Strings.emptyToNull(zzdVar.zzah);
        this.zzas = Strings.emptyToNull(zzdVar.zzas);
        int i = zzdVar.zzbc;
        this.zzjw = i != 1 ? i != 4 ? null : "VERIFY_EMAIL" : "PASSWORD_RESET";
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.zzd> zzag() {
        return zzg.zzd.class;
    }

    public final String zzba() {
        return this.zzas;
    }

    public final String zzbb() {
        return this.zzjw;
    }
}

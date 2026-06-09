package com.google.firebase.auth.internal;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.firebase.auth.AdditionalUserInfo;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseUser;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "DefaultAuthResultCreator")
public final class zzf implements AuthResult {
    public static final Parcelable.Creator<zzf> CREATOR = new zzg();

    @SafeParcelable.Field(getter = "getUser", id = 1)
    private zzl zzks;

    @SafeParcelable.Field(getter = "getAdditionalUserInfo", id = 2)
    private zzd zzkt;

    @SafeParcelable.Field(getter = "getOAuthCredential", id = 3)
    private com.google.firebase.auth.zzd zzku;

    public zzf(@NonNull zzl zzlVar) {
        this.zzks = (zzl) Preconditions.checkNotNull(zzlVar);
        List<zzh> listZzbg = this.zzks.zzbg();
        this.zzkt = null;
        for (int i = 0; i < listZzbg.size(); i++) {
            if (!TextUtils.isEmpty(listZzbg.get(i).getRawUserInfo())) {
                this.zzkt = new zzd(listZzbg.get(i).getProviderId(), listZzbg.get(i).getRawUserInfo(), zzlVar.isNewUser());
            }
        }
        if (this.zzkt == null) {
            this.zzkt = new zzd(zzlVar.isNewUser());
        }
        this.zzku = zzlVar.zzav();
    }

    @SafeParcelable.Constructor
    zzf(@SafeParcelable.Param(id = 1) zzl zzlVar, @SafeParcelable.Param(id = 2) zzd zzdVar, @SafeParcelable.Param(id = 3) com.google.firebase.auth.zzd zzdVar2) {
        this.zzks = zzlVar;
        this.zzkt = zzdVar;
        this.zzku = zzdVar2;
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.firebase.auth.AuthResult
    @Nullable
    public final AdditionalUserInfo getAdditionalUserInfo() {
        return this.zzkt;
    }

    @Override // com.google.firebase.auth.AuthResult
    @Nullable
    public final FirebaseUser getUser() {
        return this.zzks;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getUser(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 2, getAdditionalUserInfo(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzku, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

package com.google.android.gms.internal.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DeleteRequestCreator")
@SafeParcelable.Reserved({1000})
public final class zzay extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzay> CREATOR = new zzaz();

    @SafeParcelable.Field(getter = "getCredential", id = 1)
    private final Credential zzdq;

    @SafeParcelable.Constructor
    public zzay(@SafeParcelable.Param(id = 1) Credential credential) {
        this.zzdq = credential;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzdq, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

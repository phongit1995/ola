package com.google.android.gms.internal.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DeviceMetaDataRequestCreator")
public final class zzy extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzy> CREATOR = new zzz();

    @SafeParcelable.Field(id = 2)
    private final String accountType;

    @SafeParcelable.VersionField(id = 1)
    private final int zzy;

    @SafeParcelable.Constructor
    zzy(@SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) String str) {
        this.zzy = 1;
        this.accountType = (String) Preconditions.checkNotNull(str);
    }

    public zzy(String str) {
        this(1, str);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzy);
        SafeParcelWriter.writeString(parcel, 2, this.accountType, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

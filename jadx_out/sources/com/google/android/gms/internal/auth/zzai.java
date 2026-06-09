package com.google.android.gms.internal.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "SendDataRequestCreator")
public final class zzai extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzai> CREATOR = new zzaj();

    @SafeParcelable.Field(id = 2)
    private final String accountType;

    @SafeParcelable.Field(id = 3)
    private final byte[] zzbz;

    @SafeParcelable.VersionField(id = 1)
    private final int zzy;

    @SafeParcelable.Constructor
    zzai(@SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) byte[] bArr) {
        this.zzy = 1;
        this.accountType = (String) Preconditions.checkNotNull(str);
        this.zzbz = (byte[]) Preconditions.checkNotNull(bArr);
    }

    public zzai(String str, byte[] bArr) {
        this(1, str, bArr);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzy);
        SafeParcelWriter.writeString(parcel, 2, this.accountType, false);
        SafeParcelWriter.writeByteArray(parcel, 3, this.zzbz, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
